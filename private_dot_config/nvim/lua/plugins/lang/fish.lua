vim.lsp.config("fish_lsp", {})
vim.lsp.enable("fish_lsp")

return {
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				fish = { "fish_indent" },
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				fish = { "fish" },
			},
		},
	},
}
