/**
 * Confirm Writes Extension
 *
 * Requires user approval before the agent writes or edits a file. Mirrors the
 * Claude Code permissions in ~/.claude/settings.json: ask on Edit/Write, allow
 * under temp directories, no prompt for anything else.
 *
 * A doomed `edit` call is answered with its error before any prompt. The call
 * is replayed through a dry-run twin of the built-in edit tool (same matching,
 * writes disabled), so the model can retry instead of the user approving an
 * edit that cannot apply. The block has no `terminate`: the model gets the
 * error as the tool result and continues.
 *
 * `edit_lines` is gated as well. Hashline editing is currently disabled with
 * PI_HARNESS_HASHLINES_ENABLED=false, but that env var is a runtime toggle: if it
 * is ever re-enabled (or lost, when pi starts from a shell that lacks it) an
 * ungated edit_lines would silently bypass the write approval below.
 *
 * Declining blocks the call with `terminate: true`. Pi records the block reason
 * as the tool result, so the model learns on its next turn that the edit was
 * rejected, and the run ends without the model spending a turn responding.
 * Do not call `ctx.abort()` here: an aborted signal replaces the block reason
 * with "Operation aborted", which loses the rejection.
 *
 * The prompt mirrors Claude Code: three choices, with Tab opening an inline
 * editor so any answer can carry a message. A message is attached to the tool
 * result the model reads next: on an approval it is appended to the executed
 * tool's result, on a rejection it is added to the block reason with
 * `terminate` omitted so the model can act on it in the same run.
 *
 * Two modes: `ask` (default) prompts for every gated call, `auto` writes
 * without prompting. Toggle with shift+tab, switch with /edits, or choose
 * "allow all writes this session" in the prompt. `--auto-edits` starts a
 * session in auto mode. The mode is per session and resets on session start.
 * shift+tab requires `app.thinking.cycle` to be unbound in keybindings.json.
 */

import type {
	EditToolInput,
	ExtensionAPI,
	ExtensionContext,
	ExtensionToolContext,
} from "@earendil-works/pi-coding-agent";
import { createEditToolDefinition, isToolCallEventType } from "@earendil-works/pi-coding-agent";
import { Editor, Key, matchesKey, truncateToWidth } from "@earendil-works/pi-tui";
import { constants } from "node:fs";
import { access, readFile } from "node:fs/promises";

type WriteMode = "ask" | "auto";

const ALLOWED_PREFIXES = ["/tmp/", "/private/tmp/", "/var/folders/"];

function isAutoAllowed(path: string): boolean {
	return ALLOWED_PREFIXES.some((prefix) => path.startsWith(prefix));
}

/** The built-in edit tool with writes disabled: reports whether the call could apply, without touching the file. */
const dryRunEdit = createEditToolDefinition(process.cwd(), {
	operations: {
		readFile,
		writeFile: async () => {},
		access: (path) => access(path, constants.R_OK | constants.W_OK),
	},
});

/** The error the real `edit` call would fail with, or undefined when it would apply. */
async function editFailure(input: EditToolInput, ctx: ExtensionContext): Promise<string | undefined> {
	// `execute` reads only `cwd`; the tool-running fields have no job in a dry run.
	const toolContext: ExtensionToolContext = {
		...ctx,
		tools: [],
		executeTool: async () => {
			throw new Error("dry run does not execute tools");
		},
	};
	try {
		await dryRunEdit.execute("dry-run", input, undefined, undefined, toolContext);
		return undefined;
	} catch (error) {
		return error instanceof Error ? error.message : String(error);
	}
}

const WRITE_OPTIONS = [
	{ id: "yes", label: "Yes" },
	{ id: "allow-all", label: "Yes, allow all writes this session" },
	{ id: "no", label: "No" },
] as const;

type WriteVerdict = { choice: (typeof WRITE_OPTIONS)[number]["id"]; message: string };

/**
 * Ask for a decision with an optional message. Tab opens the inline editor;
 * Enter submits the highlighted choice together with the message. Outside the
 * TUI the built-in selector is used and the message is omitted.
 */
async function askApproval(
	ctx: ExtensionContext,
	toolName: string,
	path: string,
): Promise<WriteVerdict | undefined> {
	if (ctx.mode !== "tui") {
		const labels = WRITE_OPTIONS.map((option) => option.label);
		const choice = await ctx.ui.select(`Write to file?\n\n  ${toolName}  ${path}`, labels);
		const index = choice === undefined ? -1 : labels.indexOf(choice);
		return index === -1 ? undefined : { choice: WRITE_OPTIONS[index].id, message: "" };
	}

	return ctx.ui.custom<WriteVerdict | undefined>((tui, theme, keybindings, done) => {
		let selected = 0;
		let editing = false;
		let cached: string[] | undefined;

		const editor = new Editor(tui, {
			borderColor: (text) => theme.fg("accent", text),
			selectList: {
				selectedPrefix: (text) => theme.fg("accent", text),
				selectedText: (text) => theme.fg("accent", text),
				description: (text) => theme.fg("muted", text),
				scrollInfo: (text) => theme.fg("dim", text),
				noMatch: (text) => theme.fg("warning", text),
			},
		});
		editor.onSubmit = (value) => done({ choice: WRITE_OPTIONS[selected].id, message: value.trim() });

		function refresh(): void {
			cached = undefined;
			tui.requestRender();
		}

		function handleInput(data: string): void {
			if (editing) {
				if (matchesKey(data, Key.escape)) {
					editing = false;
					editor.focused = false;
					refresh();
					return;
				}
				editor.handleInput(data);
				refresh();
				return;
			}

			if (keybindings.matches(data, "tui.select.up")) {
				selected = Math.max(0, selected - 1);
				refresh();
				return;
			}
			if (keybindings.matches(data, "tui.select.down")) {
				selected = Math.min(WRITE_OPTIONS.length - 1, selected + 1);
				refresh();
				return;
			}
			if (matchesKey(data, Key.tab)) {
				editing = true;
				editor.focused = true;
				refresh();
				return;
			}
			if (keybindings.matches(data, "tui.select.confirm")) {
				done({ choice: WRITE_OPTIONS[selected].id, message: "" });
				return;
			}
			if (keybindings.matches(data, "tui.select.cancel")) {
				done(undefined);
			}
		}

		function render(width: number): string[] {
			if (cached) {
				return cached;
			}
			const lineWidth = Math.max(1, width);
			const lines = [
				theme.fg("accent", "─".repeat(lineWidth)),
				truncateToWidth(theme.fg("text", " Write to file?"), lineWidth, ""),
				truncateToWidth(theme.fg("muted", ` ${toolName}  ${path}`), lineWidth, ""),
				"",
			];
			for (let index = 0; index < WRITE_OPTIONS.length; index++) {
				const prefix = index === selected ? theme.fg("accent", " > ") : "   ";
				const color = index === selected ? "accent" : "text";
				const label = `${index + 1}. ${WRITE_OPTIONS[index].label}`;
				lines.push(truncateToWidth(`${prefix}${theme.fg(color, label)}`, lineWidth, ""));
			}
			lines.push("");
			if (editing) {
				lines.push(theme.fg("muted", " Message:"));
				for (const line of editor.render(Math.max(1, lineWidth - 2))) {
					lines.push(` ${line}`);
				}
				lines.push(truncateToWidth(theme.fg("dim", " Enter to submit • Esc to go back"), lineWidth, ""));
			} else {
				const hint = " ↑↓ choose • Tab to add a message • Enter to confirm • Esc to cancel";
				lines.push(truncateToWidth(theme.fg("dim", hint), lineWidth, ""));
			}
			lines.push(theme.fg("accent", "─".repeat(lineWidth)));
			cached = lines;
			return lines;
		}

		return {
			render,
			invalidate: () => {
				cached = undefined;
			},
			handleInput,
		};
	});
}

export default function (pi: ExtensionAPI) {
	let mode: WriteMode = "ask";
	const approvalNotes = new Map<string, { toolName: string; message: string }>();

	function updateStatus(ctx: ExtensionContext): void {
		ctx.ui.setStatus(
			"confirm-writes",
			mode === "auto" ? ctx.ui.theme.fg("warning", "writes: auto") : ctx.ui.theme.fg("dim", "writes: ask"),
		);
	}

	function setMode(next: WriteMode, ctx: ExtensionContext): void {
		mode = next;
		updateStatus(ctx);
		ctx.ui.notify(next === "auto" ? "Write approvals off this session" : "Write approvals on", "info");
	}

	pi.registerFlag("auto-edits", {
		description: "Start with write/edit approvals off",
		type: "boolean",
		default: false,
	});

	pi.registerCommand("edits", {
		description: "Show or set the write/edit approval mode: /edits ask | auto",
		handler: async (args, ctx) => {
			const next = args.trim().toLowerCase();
			if (next === "ask" || next === "auto") {
				setMode(next, ctx);
				return;
			}
			ctx.ui.notify(`Write approval mode: ${mode} (use /edits ask or /edits auto)`, "info");
		},
	});

	pi.registerShortcut("shift+tab", {
		description: "Toggle write/edit approval mode",
		handler: async (ctx) => {
			setMode(mode === "auto" ? "ask" : "auto", ctx);
		},
	});

	pi.on("session_start", async (_event, ctx) => {
		if (pi.getFlag("auto-edits") === true) {
			mode = "auto";
		}
		approvalNotes.clear();
		updateStatus(ctx);
	});

	pi.on("tool_result", async (event) => {
		const note = approvalNotes.get(event.toolCallId);
		if (!note) {
			return undefined;
		}
		approvalNotes.delete(event.toolCallId);
		return {
			content: [
				...event.content,
				{ type: "text", text: `\nThe user approved this ${note.toolName} and added: ${note.message}` },
			],
		};
	});

	pi.on("tool_call", async (event, ctx) => {
		if (event.toolName !== "write" && event.toolName !== "edit" && event.toolName !== "edit_lines") {
			return undefined;
		}

		const path = String(event.input.path ?? "");
		if (!path || isAutoAllowed(path)) {
			return undefined;
		}

		if (mode === "auto") {
			return undefined;
		}

		if (isToolCallEventType("edit", event)) {
			const failure = await editFailure(event.input, ctx);
			if (failure) {
				return { block: true, reason: failure };
			}
		}

		if (!ctx.hasUI) {
			return {
				block: true,
				reason: `${event.toolName} to ${path} needs approval, but no UI is available`,
			};
		}

		const decline = `The user declined this ${event.toolName} to ${path}. This is a deliberate rejection, not an error. Do not retry it unchanged.`;
		const verdict = await askApproval(ctx, event.toolName, path);
		if (!verdict) {
			return { block: true, terminate: true, reason: `${decline} Wait for the user's next instruction.` };
		}

		const { choice, message } = verdict;
		if (choice === "allow-all") {
			setMode("auto", ctx);
		}
		if (choice !== "no") {
			if (message) {
				approvalNotes.set(event.toolCallId, { toolName: event.toolName, message });
			}
			return undefined;
		}

		return {
			block: true,
			terminate: !message,
			reason: message ? `${decline} The user added: ${message}` : `${decline} Wait for the user's next instruction.`,
		};
	});
}
