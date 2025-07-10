return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		labels = "aoeuidhtnsqjkxbmwvzpyfgcrl",
		modes = {
			char = {
				char_actions = function(motion)
					return {
						[";"] = "prev",
						[","] = "next",
						[motion:lower()] = "next",
						[motion:upper()] = "prev",
					}
				end,
			},
		},
		jump = {
			autojump = true,
		},
	},
	keys = {
		{
			"s",
			function()
				require("flash").jump()
			end,
			desc = "Flash",
			mode = { "n", "x", "o" },
		},
		{
			"S",
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
			mode = { "n", "o", "x" },
		},
		{
			"r",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
			mode = "o",
		},
		{
			"R",
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
			mode = { "o", "x" },
		},
		{
			"<C-s>",
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
			mode = { "c" },
		},
	},
}
