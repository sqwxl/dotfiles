return {
	"stevearc/conform.nvim",
	dependencies = { "mason-org/mason.nvim" },
	cmd = { "ConformInfo" },
	event = { "BufWritePre" },
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
	opts_extend = { "formatters_by_ft", "formatters" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		default_format_opts = {
			timeout_ms = 3000,
			lsp_format = "fallback",
		},
		format_on_save = function()
			if not vim.g.format_on_save then
				return
			end

			return {}
		end,
		notify_on_error = true,
		formatters_by_ft = {
			go = { "gofmt" },
			just = { "just" },
			nix = { "alejandra" },
			xml = { "xmlformat" },
		},
		formatters = {
			injected = { options = { ignore_errors = true } },
		},
	},
}
