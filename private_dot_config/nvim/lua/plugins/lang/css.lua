return {
	{
		"mason-org/mason.nvim",
		optional = true,
		opts = { ensure_installed = { "prettierd", "biome", "stylelint" } },
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				scss = { "prettierd" },
				css = { "prettierd" },
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				css = { "biomejs" },
				sass = { "stylelint" },
			},
			linters = {
				stylelint = { stream = "stderr" },
			},
		},
	},
}
