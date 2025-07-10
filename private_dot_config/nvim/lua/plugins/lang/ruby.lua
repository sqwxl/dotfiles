return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"sqwxl/nvim-dap-ruby",
			branch = "patch-2",
		},
		config = function()
			require("dap-ruby").setup()
		end,
	},
	{
		"nvim-neotest/neotest",
		lazy = true,
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
