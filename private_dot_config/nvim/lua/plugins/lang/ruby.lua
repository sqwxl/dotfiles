vim.lsp.config("ruby_lsp", {
	init_options = {
		formatter = "standard",
		linters = { "standard" },
	},
})

vim.lsp.enable("ruby_lsp")

return {
	{
		"mason-org/mason.nvim",
		optional = true,
		opts = { ensure_installed = { "erb-formatter", "erb-lint" } },
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				ruby = { "ruby" },
			},
		},
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				ruby = { "standardrb" },
				eruby = { "erb_format" },
			},
			formatters = {
				rubocop = {
					args = { "--server", "--auto-correct-all", "--stderr", "--force-exclusion", "--stdin", "$FILENAME" },
				},
			},
		},
	},

	-- {
	-- 	"suketa/nvim-dap-ruby",
	-- 	config = function()
	-- 		require("dap-ruby").setup()
	-- 	end,
	-- },

	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = {
			"sqwxl/nvim-dap-ruby",
			config = function()
				require("dap-ruby").setup()
			end,
		},
	},

	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"olimorris/neotest-rspec",
		},
		opts = {
			adapters = {
				["neotest-rspec"] = {
					rspec_cmd = { "bundle", "exec", "rspec" },
				},
			},
		},
	},
}
