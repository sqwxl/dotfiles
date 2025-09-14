vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			disableOrganizeImports = true, -- Using Ruff
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				diagnosticSeverityOverrides = {
					reportAny = "none",
					reportUnknownVariableType = "none",
					reportUnknownMemberType = "none",
					reportUnknownArgumentType = "none",
					reportUnusedExpression = "none",
					reportUnusedCallResult = "none",
				},
			},
		},
	},
})
vim.lsp.enable("basedpyright")

vim.lsp.config("ruff", {
	init_options = {
		settings = {
			lineLength = 160,
		},
	},
})
vim.lsp.enable("ruff")

return {
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				python = {
					"ruff_fix",
					-- "ruff_format",
					"ruff_organize_imports",
					lsp_format = "last",
				},
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				python = { "ruff" },
			},
		},
	},

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
			{
				"mfussenegger/nvim-dap-python",
				config = function()
					require("dap-python").setup("uv")
				end,
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
			},
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
