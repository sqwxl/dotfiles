return {
	{
		"mason-org/mason.nvim",
		optional = true,
		opts = {
			ensure_installed = {
				"gopls",
				"goimports",
				"gofumpt",
				"golangci-lint",
				"delve",
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = {
			ensure_installed = {
				"go",
				"gomod",
				"gosum",
				"gowork",
				"gotmpl",
			},
		},
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				go = { "goimports", "gofumpt" },
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				go = { "golangcilint" },
			},
		},
	},

	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = { "fredrikaverpil/neotest-golang" },
		opts = {
			adapters = {
				["neotest-golang"] = {
					dap_go_enabled = true,
				},
			},
		},
	},

	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = {
			{
				"leoluz/nvim-dap-go",
				opts = {},
				keys = {
					{
						"<leader>dPt",
						function()
							require("dap-go").debug_test()
						end,
						desc = "Debug Test",
						ft = "go",
					},
					{
						"<leader>dPl",
						function()
							require("dap-go").debug_last_test()
						end,
						desc = "Debug Last Test",
						ft = "go",
					},
				},
			},
		},
	},
}
