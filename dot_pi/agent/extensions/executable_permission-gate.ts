/**
 * Permission Gate Extension
 *
 * Requires user approval before the LLM runs privileged or destructive
 * commands via the bash tool. Blocks by default when there's no UI
 * (print/json modes).
 *
 * Bash commands that write files are refused before they run. In-place
 * editors, interpreter programs that call write functions, and text producers
 * redirected into a file bypass the edit/write approval, so the model is
 * answered with a corrective reason and retries with the proper tool. The
 * command is parsed (unbash) and classified structurally: quoting, wrappers
 * (sudo, xargs, bash -c) and command substitutions are handled. Build tools,
 * formatters, and reads stay untouched.
 *
 * Declining blocks the call with `terminate: true`. Pi records the block reason
 * as the tool result, so the model learns on its next turn that the command was
 * rejected, and the run ends without the model spending a turn responding.
 * Do not call `ctx.abort()` here: an aborted signal replaces the block reason
 * with "Operation aborted", which loses the rejection.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

import { findBashFileEdit } from "./bash-guard/guard.ts";

const dangerousPatterns = [
	/\brm\s+(-[a-z]*[rf][a-z]*\s+)?(?:--recursive|--force|\/|~|\*)/i, // rm -rf on paths
	/\bsudo\b/i, // privilege escalation
	/\b(chmod|chown)\b.*777/i, // world-writable perms
	/\b(dd|mkfs|fdisk|parted)\b/i, // raw disk operations
	/\b(shutdown|reboot|poweroff|halt)\b/i, // system state changes
	/\b>+\s*\/dev\/(sd[a-z]|disk)/i, // writing to block devices
];

export default function (pi: ExtensionAPI) {
	pi.on("tool_call", async (event, ctx) => {
		if (event.toolName !== "bash") return undefined;

		const command = event.input.command as string;
		const fileEdit = findBashFileEdit(command);
		if (fileEdit) {
			return {
				block: true,
				reason: `Blocked: ${fileEdit}. Use the edit or write tool instead. If a script is needed, create it with the write tool first.`,
			};
		}
		if (!dangerousPatterns.some((p) => p.test(command))) return undefined;

		if (!ctx.hasUI) {
			return { block: true, reason: "Dangerous command blocked (no UI for confirmation)" };
		}

		const choice = await ctx.ui.select(`⚠️ Dangerous command:\n\n  ${command}\n\nAllow?`, ["Yes", "No"]);
		if (choice !== "Yes") {
			return {
				block: true,
				terminate: true,
				reason: "The user declined to run this command. This is a deliberate rejection, not an error. Do not retry it unchanged. Wait for the user's next instruction.",
			};
		}
		return undefined;
	});
}
