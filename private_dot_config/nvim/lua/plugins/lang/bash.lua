return {
	{
		"mason-org/mason.nvim",
		optional = true,
		opts = {
			ensure_installed = { "shellcheck", "shfmt" },
		},
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				sh = { "shfmt" },
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				sh = { "shellcheck" },
			},
		},
	},
}
