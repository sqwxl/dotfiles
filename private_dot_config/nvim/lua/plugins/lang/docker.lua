vim.lsp.config("dockerls", {})
vim.lsp.enable("dockerls")

vim.lsp.config("docker_compose_language_service", {})
vim.lsp.enable("docker_compose_language_service")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "dockerfile" } },
	},

	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "hadolint" } },
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				dockerfile = { "hadolint" },
			},
		},
	},
}
