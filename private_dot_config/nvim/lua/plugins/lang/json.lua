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
