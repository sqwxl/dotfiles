vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			codelens = { enabled = false },
			diagnostics = {
				disable = { "redefined-local", "lowercase-global" },
			},
			format = {
				enabled = true,
				defaultConfig = {
					quote_style = "double",
					call_arg_parenthesese = "remove_string_only",
				},
			},
			hint = {
				enable = true,
				setType = false,
				paramType = true,
				paramName = "Disable",
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
			workspace = {
				checkThirdParty = false,
			},
		},
	},
})
vim.lsp.enable("lua_ls")

return {
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				-- lua = { "selene", "luacheck" },
			},
		},
	},

	{
		"folke/lazydev.nvim",
		lazy = true,
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},
}
