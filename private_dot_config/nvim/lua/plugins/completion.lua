return {
	"saghen/blink.cmp",
	enabled = false,
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts_extend = { "sources.default" },
	event = "InsertEnter",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "enter" },

		appearance = { nerd_font_variant = "normal" },

		fuzzy = { implementation = "rust" },

		completion = {
			menu = {
				max_height = 30,
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
			},
			ghost_text = {
				enabled = true,
			},
		},

		-- experimental signature help support
		-- signature = { enabled = true },

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "lazydev" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100, -- show at a higher priority than lsp
				},
			},
		},

		cmdline = {
			enabled = false,
		},
	},
}
