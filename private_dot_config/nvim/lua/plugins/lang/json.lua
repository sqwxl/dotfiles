vim.lsp.config("jsonls", {
	-- lazy-load shemastore when needed
	on_new_config = function(new_config)
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
		opts = { ensure_installed = { "json5" } },
	},

	{
		"b0o/SchemaStore.nvim",
		lazy = true,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				json = { "biome-check" },
				jsonc = { "biome-check" },
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				json = { "biomejs" },
				jsonc = { "biomejs" },
			},
		},
	},
}
