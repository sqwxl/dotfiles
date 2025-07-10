return {
	"Wansmer/treesj",
	lazy = true,
	opts = {
		use_default_keymaps = false,
		max_join_length = 300,
	},
	keys = {
		{
			"<A-a>",
			function()
				require("treesj").toggle()
			end,
			desc = "Toggle fold/unfold tree structures",
		},
	},
}
