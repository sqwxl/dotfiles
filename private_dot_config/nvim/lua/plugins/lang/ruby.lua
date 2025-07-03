return {
	{
		"suketa/nvim-dap-ruby",
		config = function()
			require("dap-ruby").setup()
		end,
	},
	{
		"olimorris/neotest-rspec",
	},
	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = {
			"suketa/nvim-dap-ruby",
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
					-- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
					-- rspec_cmd = function()
					--   return vim.tbl_flatten({
					--     "bundle",
					--     "exec",
					--     "rspec",
					--   })
					-- end,
				},
			},
		},
	},
}
