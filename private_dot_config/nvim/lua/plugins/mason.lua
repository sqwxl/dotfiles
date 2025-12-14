return {
	{
		"mason-org/mason.nvim",
		opts = {},
		config = function(_, opts)
			require("mason").setup(opts)

			-- Auto-install formatters/linters after conform and lint are loaded
			Sqwxl.on_very_lazy(function()
				require("util.auto-mason")
			end)
		end,
	},
}
