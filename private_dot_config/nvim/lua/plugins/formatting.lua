return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	dependencies = { "mason-org/mason.nvim" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		default_format_opts = {
			timeout_ms = 3000,
			lsp_format = "fallback",
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout = 500,
		},
		notify_on_error = true,
		formatters_by_ft = {
			css = { "prettierd" },
			fish = { "fish_indent" },
			go = { "gofmt" },
			html = { "prettierd" },
			htmldjango = { "djlint" },
			jinja = { "djlint" },
			just = { "just" },
			lua = { "stylua" },
			nix = { "alejandra" },
			-- php = { "pint" },
			scss = { "prettierd" },
			sh = { "shfmt" },
			xml = { "xmlformat" },
		},
		formatters = {
			injected = { options = { ignore_errors = true } },
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
