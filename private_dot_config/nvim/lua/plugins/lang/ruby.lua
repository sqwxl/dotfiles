return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "suketa/nvim-dap-ruby" },
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
