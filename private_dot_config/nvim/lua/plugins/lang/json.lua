vim.lsp.config("jsonls", {
	-- lazy-load shemastore when needed
	before_init = function(_, new_config)
		new_config.settings.json.schemas = new_config.settings.json.schemas or {}
		vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
	end,
	settings = {
		json = {
			format = {
				enable = true,
			},
			validate = { enable = true },
		},
	},
})
vim.lsp.enable("jsonls")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = { ensure_installed = { "json5" } },
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				json = { "prettierd" },
				jsonc = { "prettierd" },
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				json = { "jsonlint" },
				jsonc = { "jsonlint" },
			},
		},
	},

	{
		"b0o/schemastore.nvim",
		lazy = true,
	},
}
