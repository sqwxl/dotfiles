return {
	{
		"suketa/nvim-dap-ruby",
		config = function()
			require("dap-ruby").setup()
		end,
	},
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
