import { parse } from "unbash";

type AstNode = {
	readonly type: string;
	readonly value?: string;
	readonly text?: string;
	readonly parts?: readonly AstNode[];
	readonly name?: AstNode;
	readonly prefix?: readonly AstNode[];
	readonly suffix?: readonly AstNode[];
	readonly operator?: string;
	readonly target?: AstNode;
	readonly body?: { readonly text: string };
	readonly script?: AstNode;
	readonly commands?: readonly AstNode[];
};

type Check = (node: AstNode, raw: string) => string | undefined;

const SCRATCH = /^\/(?:dev|tmp|private\/tmp|var\/folders)(?:\/|$)/;
const DYNAMIC = /[$`]/;
const WRITE_REDIRECTS = new Set([">", ">>", ">|", "&>", "&>>", "<>"]);
const REDIRECT_PRODUCERS = new Set(["cat", "echo", "printf", "sed", "awk"]);
const IN_PLACE_EDITORS = new Set(["sed", "perl", "ruby", "yq"]);
const FILE_WRITERS = new Set(["tee", "truncate"]);
const SHELLS = new Set(["bash", "sh", "zsh", "dash", "ksh", "ash", "fish"]);
const WRAPPERS = new Set(["sudo", "doas", "env", "nice", "nohup", "timeout", "command", "builtin", "exec", "xargs"]);
const INTERPRETER = /^(?:python\d*(?:\.\d+)*|pypy\d*|node(?:js)?|ruby|perl|php|bun|deno)$/;
const CODE_FLAGS = new Set(["-c", "-e", "-E", "-p", "-r", "--eval", "--print"]);
const GIT_APPLY_READ_ONLY = new Set(["--check", "--stat", "--numstat", "--summary"]);
const PATTERN_KILLERS = new Set(["pkill", "killall"]);
const PID_LOOKUPS = new Set(["pgrep", "pidof", "ps", "lsof"]);
const LISTENER_ONLY = /^(?:-s)?TCP:LISTEN$/;

const WRAPPER_VALUE_FLAGS: Record<string, ReadonlySet<string>> = {
	sudo: new Set(["-u", "-g", "-p", "-C", "-h", "-r", "-t", "-U", "-D", "-R", "--user", "--group", "--prompt", "--close-from", "--host", "--role", "--type", "--other-user", "--command-timeout"]),
	doas: new Set(["-u", "-C", "-a"]),
	env: new Set(["-u", "-C", "-S", "--unset", "--chdir", "--split-string"]),
	nice: new Set(["-n", "--adjustment"]),
	timeout: new Set(["-s", "-k", "--signal", "--kill-after"]),
	xargs: new Set(["-I", "-n", "-P", "-s", "-E", "-a", "-d", "-L", "-e", "--max-args", "--max-procs", "--max-chars", "--eof", "--arg-file", "--delimiter", "--max-lines"]),
	exec: new Set(["-a", "--argv0"]),
};

/** File writes as they appear inside Python, Node, Ruby, Perl and PHP programs. */
const WRITE_MARKERS = [
	/\bopen\s*\([^)]*,\s*['"](?:[wax][bt]?\+?|[>]{1,2})['"]/,
	/\bopen\s*\([^)]*mode\s*=\s*['"][wax]/,
	/(?<!stdout)(?<!stderr)\.write(?:_text|_bytes)?\s*\(/,
	/\bwritelines\s*\(/,
	/\bwrite(?:Text|Line)?File(?:Sync)?\s*\(/,
	/\bappendFile(?:Sync)?\s*\(/,
	/\bcreateWriteStream\s*\(/,
	/\bFile\.(?:write|open|binwrite)|\bFileUtils\.|\bIO\.write/,
	/\bfile_put_contents\s*\(/,
	/\bsubprocess\.|\bos\.(?:system|popen|remove|unlink|rename|replace|mkdir)/,
	/\bshutil\./,
];

function isRecord(value: unknown): value is Record<string, unknown> {
	return typeof value === "object" && value !== null;
}

function isAstNode(value: unknown): value is AstNode {
	return isRecord(value) && typeof value.type === "string";
}

function nodeValue(node: AstNode | undefined): string | undefined {
	return typeof node?.value === "string" ? node.value : undefined;
}

function basename(path: string): string {
	const trimmed = path.replace(/\/+$/, "");
	const slash = trimmed.lastIndexOf("/");
	return slash === -1 ? trimmed : trimmed.slice(slash + 1);
}

/** True when the command writes or rewrites a file through bash. */
export function findBashFileEdit(command: string): string | undefined {
	return findInScript(command, 0, checkFileEdit);
}

/** True when the command kills processes picked by a pattern or a broad lookup rather than by explicit PID. */
export function findMassKill(command: string): string | undefined {
	return findInScript(command, 0, checkMassKill);
}

function findInScript(source: string, depth: number, check: Check): string | undefined {
	if (depth > 6) {
		return undefined;
	}
	try {
		const root: unknown = parse(source);
		return walk(root, source, depth, check);
	} catch {
		return undefined;
	}
}

function walk(node: unknown, raw: string, depth: number, check: Check): string | undefined {
	if (Array.isArray(node)) {
		for (const child of node) {
			const found = walk(child, raw, depth, check);
			if (found) {
				return found;
			}
		}
		return undefined;
	}
	if (!isAstNode(node)) {
		return undefined;
	}
	if (node.type === "Word") {
		return node.parts ? walk(node.parts, raw, depth, check) : undefined;
	}

	const own = check(node, raw);
	if (own) {
		return own;
	}
	if (node.type === "Command") {
		const code = nestedScript(node);
		const nested = code === undefined ? undefined : findInScript(code, depth + 1, check);
		if (nested) {
			return nested;
		}
	}

	for (const child of Object.values(node)) {
		if (isRecord(child)) {
			const found = walk(child, raw, depth, check);
			if (found) {
				return found;
			}
		}
	}
	return undefined;
}

function commandWords(command: AstNode): AstNode[] {
	const words: AstNode[] = command.name ? [command.name] : [];
	for (const arg of [...(command.prefix ?? []), ...(command.suffix ?? [])]) {
		if (arg.type === "Word") {
			words.push(arg);
		}
	}
	return words;
}

function nestedScript(command: AstNode): string | undefined {
	const resolved = resolveWrapped(commandWords(command));
	if (!resolved) {
		return undefined;
	}
	const { base, args } = resolved;

	if (base === "eval") {
		const code = nodeValue(args[0]);
		return code !== undefined && !DYNAMIC.test(code) ? code : undefined;
	}
	if (SHELLS.has(base)) {
		return codeArgument(args) ?? (hasPositional(args) ? undefined : heredocBody(command));
	}
	return undefined;
}

function checkMassKill(node: AstNode): string | undefined {
	if (node.type === "Pipeline") {
		return checkKillPipeline(node);
	}
	if (node.type !== "Command") {
		return undefined;
	}
	const resolved = resolveWrapped(commandWords(node));
	if (!resolved) {
		return undefined;
	}
	const { base, args } = resolved;

	if (PATTERN_KILLERS.has(base)) {
		return `'${base}' kills every process that matches a pattern`;
	}
	if (base !== "kill") {
		return undefined;
	}

	const targets = killTargets(args);
	if (targets.some((target) => nodeValue(target) === "-1")) {
		return "'kill -1' signals every process you own";
	}
	const lookup = targets.map((target) => walk(target, "", 0, broadPidLookup)).find((found) => found !== undefined);
	return lookup ? `'kill $(${lookup} ...)' kills every process the lookup matches` : undefined;
}

function checkKillPipeline(pipeline: AstNode): string | undefined {
	const commands = pipeline.commands ?? [];
	const killer = commands.findIndex((command) => resolveWrapped(commandWords(command))?.base === "kill");
	if (killer < 1) {
		return undefined;
	}
	const lookup = commands.slice(0, killer).map((command) => walk(command, "", 0, broadPidLookup)).find((found) => found !== undefined);
	return lookup ? `'${lookup} | xargs kill' kills every process the lookup matches` : undefined;
}

function broadPidLookup(node: AstNode): string | undefined {
	if (node.type !== "Command") {
		return undefined;
	}
	const resolved = resolveWrapped(commandWords(node));
	if (!resolved || !PID_LOOKUPS.has(resolved.base)) {
		return undefined;
	}
	const listenerOnly = resolved.base === "lsof" && resolved.args.some((arg) => LISTENER_ONLY.test(nodeValue(arg) ?? ""));
	return listenerOnly ? undefined : resolved.base;
}

function killTargets(args: AstNode[]): AstNode[] {
	const first = nodeValue(args[0]);
	let index = 0;
	if (first === "-s" || first === "-n") {
		index = 2;
	} else if (first?.startsWith("-") && first !== "--") {
		index = 1;
	}
	if (nodeValue(args[index]) === "--") {
		index++;
	}
	return args.slice(index);
}

function checkFileEdit(command: AstNode, raw: string): string | undefined {
	if (command.type !== "Command") {
		return undefined;
	}
	const resolved = resolveWrapped(commandWords(command));
	if (!resolved) {
		return undefined;
	}
	const { base, args } = resolved;
	const values = args.map((arg) => nodeValue(arg) ?? "");

	if (IN_PLACE_EDITORS.has(base) && args.some((arg) => isInPlaceFlag(nodeValue(arg), base))) {
		return `'${base} -i' edits a file in place`;
	}
	if (base === "awk" && values.some((value, index) => value === "-i" && values[index + 1] === "inplace")) {
		return "'awk -i inplace' edits a file in place";
	}
	if (FILE_WRITERS.has(base)) {
		return `'${base}' writes files`;
	}
	if (base === "patch" && !values.includes("--dry-run")) {
		return "'patch' edits files";
	}
	if (base === "git" && values[0] === "apply" && !values.some((value) => GIT_APPLY_READ_ONLY.has(value))) {
		return "'git apply' edits files";
	}

	const codeInput = INTERPRETER.test(base) && hasCodeInput(base, values, command);
	if (REDIRECT_PRODUCERS.has(base) || codeInput) {
		const redirect = findWriteRedirect(command);
		if (redirect) {
			return redirect;
		}
	}
	if (codeInput && WRITE_MARKERS.some((marker) => marker.test(raw))) {
		return `a '${base}' program writes files`;
	}
	return undefined;
}

function findWriteRedirect(command: AstNode): string | undefined {
	for (const redirection of [...(command.prefix ?? []), ...(command.suffix ?? [])]) {
		if (redirection.type !== "Redirect") {
			continue;
		}
		const operator = redirection.operator;
		const path = redirection.target ? nodeValue(redirection.target) : undefined;
		if (operator === undefined || path === undefined || DYNAMIC.test(path) || SCRATCH.test(path)) {
			continue;
		}
		if (WRITE_REDIRECTS.has(operator) || (operator === ">&" && !/^\d+$/.test(path))) {
			return `'${operator} ${path}' writes a file`;
		}
	}
	return undefined;
}

function isInPlaceFlag(value: string | undefined, base: string): boolean {
	if (value === undefined) {
		return false;
	}
	if (value === "--in-place" || value.startsWith("--in-place=")) {
		return true;
	}
	if (base === "yq" && (value === "--inplace" || value.startsWith("--inplace="))) {
		return true;
	}
	return /^-[^-]*i/.test(value);
}

function hasCodeInput(base: string, values: string[], command: AstNode): boolean {
	if (values.includes("-") || values.some((value) => CODE_FLAGS.has(value))) {
		return true;
	}
	if (base === "deno" && values[0] === "eval") {
		return true;
	}
	return heredocBody(command) !== undefined;
}

function codeArgument(args: AstNode[]): string | undefined {
	for (let index = 0; index < args.length; index++) {
		const value = nodeValue(args[index]);
		if (value !== undefined && (/^-[a-zA-Z]*c$/.test(value) || value === "--command")) {
			const code = nodeValue(args[index + 1]);
			return code !== undefined && !DYNAMIC.test(code) ? code : undefined;
		}
	}
	return undefined;
}

function hasPositional(args: AstNode[]): boolean {
	return args.some((arg) => {
		const value = nodeValue(arg);
		return value !== undefined && !value.startsWith("-");
	});
}

function heredocBody(command: AstNode): string | undefined {
	for (const redirection of [...(command.prefix ?? []), ...(command.suffix ?? [])]) {
		if (redirection.type === "HereDoc") {
			return redirection.body?.text;
		}
	}
	return undefined;
}

function resolveWrapped(words: AstNode[]): { base: string; args: AstNode[] } | undefined {
	let index = 0;
	for (let hops = 0; hops < 8; hops++) {
		const name = nodeValue(words[index]);
		if (name === undefined || DYNAMIC.test(name)) {
			return undefined;
		}
		const base = basename(name);
		const args = words.slice(index + 1);
		if (!WRAPPERS.has(base)) {
			return { base, args };
		}
		index += 1 + wrapperOptions(base, args);
	}
	return undefined;
}

function wrapperOptions(base: string, args: AstNode[]): number {
	let consumed = 0;
	let positionalSeen = false;
	for (const arg of args) {
		const value = nodeValue(arg);
		if (value === undefined || DYNAMIC.test(value)) {
			return consumed;
		}
		if (value === "--") {
			return consumed + 1;
		}
		if (base === "env" && /^[A-Za-z_][A-Za-z0-9_]*=/.test(value)) {
			consumed++;
			continue;
		}
		if (value.startsWith("-") && value.length > 1) {
			const name = value.includes("=") ? value.slice(0, value.indexOf("=")) : value;
			const takesValue = WRAPPER_VALUE_FLAGS[base]?.has(name) ?? false;
			consumed += takesValue && !value.includes("=") ? 2 : 1;
			continue;
		}
		if (base === "timeout" && !positionalSeen) {
			positionalSeen = true;
			consumed++;
			continue;
		}
		break;
	}
	return consumed;
}
