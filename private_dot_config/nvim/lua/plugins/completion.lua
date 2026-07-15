return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	event = { "InsertEnter", "CmdlineEnter" },
	opts_extend = {
		"sources.completion.enabled_providers",
		"sources.default",
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "enter" },

		appearance = {
			nerd_font_variant = "normal",
			kind_icons = Sqwxl.config.icons.kinds,
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },

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
			accept = {
				auto_brackets = { enabled = true },
			},
		},

		signature = { enabled = true },

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "lazydev" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100, -- show at a higher priority than lsp
				},

				buffer = {
					opts = {
						get_bufnrs = function()
							return vim.tbl_filter(function(bufnr)
								return vim.bo[bufnr].buftype == ""
							end, vim.api.nvim_list_bufs())
						end,
					},
				},
			},
		},

		cmdline = {
			enabled = true,
			keymap = { preset = "cmdline", ["<CR>"] = { "accept_and_enter", "fallback" } },
			completion = {
				list = { selection = { preselect = true } },
				menu = {
					-- auto_show = function()
					-- 	return vim.fn.getcmdtype() == ":"
					-- end,
				},
				ghost_text = { enabled = true },
			},
		},
	},
}
