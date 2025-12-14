_G.Sqwxl = require("util")

---@class SqwxlConfig
local M = {}

Sqwxl.config = M

M.icons = {
	misc = {
		dots = "󰇘",
	},
	ft = {
		octo = "",
	},
	dap = {
		Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
		Breakpoint = " ",
		BreakpointCondition = " ",
		BreakpointRejected = { " ", "DiagnosticError" },
		LogPoint = ".>",
	},
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	},
	git = {
		added = " ",
		modified = " ",
		removed = " ",
	},
	kinds = {
		Array = " ",
		Boolean = "󰨙 ",
		Class = " ",
		Codeium = "󰘦 ",
		Color = " ",
		Control = " ",
		Collapsed = " ",
		Constant = "󰏿 ",
		Constructor = " ",
		Copilot = " ",
		Enum = " ",
		EnumMember = " ",
		Event = " ",
		Field = " ",
		File = " ",
		Folder = " ",
		Function = "󰊕 ",
		Interface = " ",
		Key = " ",
		Keyword = " ",
		Method = "󰊕 ",
		Module = " ",
		Namespace = "󰦮 ",
		Null = " ",
		Number = "󰎠 ",
		Object = " ",
		Operator = " ",
		Package = " ",
		Property = " ",
		Reference = " ",
		Snippet = "󱄽 ",
		String = " ",
		Struct = "󰆼 ",
		Supermaven = " ",
		TabNine = "󰏚 ",
		Text = " ",
		TypeParameter = " ",
		Unit = " ",
		Value = " ",
		Variable = "󰀫 ",
	},
}

M.did_init = false
M._options = {} ---@type vim.bo|vim.wo

function M.init()
	if M.did_init then
		return
	end
	M.did_init = true

	-- save some options to track defaults
	M._options.indentexpr = vim.o.indentexpr
	M._options.foldmethod = vim.o.foldmethod
	M._options.foldexpr = vim.o.foldexpr

	Sqwxl.plugin.setup()
end

return M
