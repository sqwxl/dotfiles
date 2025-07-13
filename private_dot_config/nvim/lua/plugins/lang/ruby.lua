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
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				ruby = { "standardrb" },
				eruby = { "erb_format" },
			},
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
