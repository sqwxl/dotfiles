return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	},

	{
		"mason-org/mason.nvim",
		opts = {},
	},
}
