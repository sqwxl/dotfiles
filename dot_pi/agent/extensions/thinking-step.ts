/**
 * Thinking Step Extension
 *
 * Steps the thinking level with `<` and `>` while the prompt is empty. The
 * editor matches extension shortcuts before it inserts text, so a non-empty
 * prompt gets the character pasted back to keep normal typing working.
 *
 * Both spellings of each key are registered: legacy terminals send `<`,
 * kitty terminals may send `shift+,` with the shift modifier.
 *
 * shift+tab is left to the write approval mode in confirm-writes.ts; unbind
 * `app.thinking.cycle` in keybindings.json to free it.
 */

import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

const LEVELS = ["off", "minimal", "low", "medium", "high", "xhigh", "max"] as const;

export default function (pi: ExtensionAPI) {
	/**
	 * Walk toward the requested direction until the level changes. Models skip
	 * levels (deepseek-flash: off/low/high/max) and clamping maps an unsupported
	 * level to a neighbor that can equal the current one.
	 */
	function step(delta: 1 | -1, ctx: ExtensionContext): void {
		const current = pi.getThinkingLevel();
		const start = LEVELS.indexOf(current);
		const from = start === -1 ? (delta === 1 ? 0 : LEVELS.length - 1) : start + delta;
		for (let index = from; index >= 0 && index < LEVELS.length; index += delta) {
			pi.setThinkingLevel(LEVELS[index]);
			const applied = pi.getThinkingLevel();
			if (applied !== current) {
				ctx.ui.notify(`Thinking level: ${applied}`, "info");
				return;
			}
		}
		ctx.ui.notify(`Thinking level: ${current} (at limit)`, "info");
	}

	const steps = [
		{ keys: ["<", "shift+,", "shift+<"], char: "<", delta: -1, description: "Lower thinking level" },
		{ keys: [">", "shift+.", "shift+>"], char: ">", delta: 1, description: "Raise thinking level" },
	] as const;

	for (const { keys, char, delta, description } of steps) {
		const handler = (ctx: ExtensionContext) => {
			if (ctx.ui.getEditorText() !== "") {
				ctx.ui.pasteToEditor(char);
				return;
			}
			step(delta, ctx);
		};
		for (const key of keys) {
			pi.registerShortcut(key, { description, handler });
		}
	}
}
