return {
	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason.nvim", "nvim-lspconfig" },
		opts = {
			automatic_installation = true,
			automatic_enable = false,
		},
	},
}
