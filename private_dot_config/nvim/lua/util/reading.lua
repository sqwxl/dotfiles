---@class util.reading
local M = {}

-- Window-local options and their reading-mode values. Clearing `statuscolumn` and
-- the gutter options together also hides gitsigns, which draw into the sign column.
local WIN_OPTS = {
	cursorline = false,
	foldcolumn = "0",
	list = false,
	number = false,
	relativenumber = false,
	signcolumn = "no",
	spell = false,
	statuscolumn = "",
	wrap = true,
}

---@return boolean
function M.enabled()
	return vim.w.reading == true
end

---@param state boolean
function M.set(state)
	if state == M.enabled() then
		return
	end

	if state then
		local win_saved = {} ---@type table<string, string|boolean>
		for opt, value in pairs(WIN_OPTS) do
			win_saved[opt] = vim.wo[opt]
			vim.wo[opt] = value
		end
		vim.w.reading_saved = win_saved
		vim.w.reading = true

		vim.b.reading_saved = {
			diagnostics = vim.diagnostic.is_enabled({ bufnr = 0 }),
			inlay_hints = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
			snacks_indent = vim.b.snacks_indent,
		}
		vim.b.reading = true -- read by the blink.cmp auto_show/ghost_text predicates
		vim.b.snacks_indent = false
		vim.diagnostic.enable(false, { bufnr = 0 })
		vim.lsp.inlay_hint.enable(false, { bufnr = 0 })

		return
	end

	for opt, value in pairs(vim.w.reading_saved or {}) do
		vim.wo[opt] = value
	end
	vim.w.reading_saved = nil
	vim.w.reading = nil

	local saved = vim.b.reading_saved or {}
	vim.b.reading_saved = nil
	vim.b.reading = nil
	vim.b.snacks_indent = saved.snacks_indent
	vim.diagnostic.enable(saved.diagnostics ~= false, { bufnr = 0 })
	vim.lsp.inlay_hint.enable(saved.inlay_hints ~= false, { bufnr = 0 })
end

return M
