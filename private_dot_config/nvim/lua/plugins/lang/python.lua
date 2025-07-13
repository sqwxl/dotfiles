vim.lsp.config("basedpyright", {
	{
		settings = {
			basedpyright = {
				disableOrganizeImports = true, -- Using Ruff
				disableTaggedHints = true, -- Using Ruff
				analysis = {
					autoImportCompletions = true,
					diagnosticSeverityOverrides = {
						reportUndefinedVariable = "none",
					},
				},
			},
		},
	},
})
vim.lsp.enable("basedpyright")

vim.lsp.config("ruff", {
	{ settings = { lineLength = { 120 } } },
	keys = {
		{
			"<leader>co",
			function()
				vim.lsp.buf.code_action({
					apply = true,
					context = { only = { "source.organizeImports" }, diagnostics = {} },
				})
			end,
			desc = "Organize Imports",
		},
	},
})
vim.lsp.enable("ruff")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "ninja", "rst" } },
	},

	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"nvim-neotest/neotest-python",
		},
		opts = {
			adapters = {
				["neotest-python"] = {
					-- Here you can specify the settings for the adapter, i.e.
					-- runner = "pytest",
					-- python = ".venv/bin/python",
				},
			},
		},
	},

	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = {
			"mfussenegger/nvim-dap-python",
			keys = {
				{
					"<leader>dPt",
					function()
						require("dap-python").test_method()
					end,
					desc = "Debug Method",
					ft = "python",
				},
				{
					"<leader>dPc",
					function()
						require("dap-python").test_class()
					end,
					desc = "Debug Class",
					ft = "python",
				},
			},
			config = function()
				require("dap-python").setup("uv")
			end,
		},
	},

	-- Don't mess up DAP adapters provided by nvim-dap-python
	{
		"jay-babu/mason-nvim-dap.nvim",
		optional = true,
		opts = {
			handlers = {
				python = function() end,
			},
		},
	},
}
