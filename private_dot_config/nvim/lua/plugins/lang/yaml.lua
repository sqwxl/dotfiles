return {
	{
		"mason-org/mason.nvim",
		optional = true,
		opts = { ensure_installed = { "yamlfix" } },
	},

	{
		"b0o/schemastore.nvim",
		lazy = true,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				yaml = { "yamlfix" },
			},
		},
	},
}
