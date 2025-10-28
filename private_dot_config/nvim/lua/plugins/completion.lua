return {
	"saghen/blink.cmp",
	version = "*",
	build = "cargo build --release",
	dependencies = { "rafamadriz/friendly-snippets" },
	event = { "InsertEnter", "CmdlineEnter" },
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "enter" },

		appearance = {
			nerd_font_variant = "normal",
			kind_icons = Util.config.icons.kinds,
		},

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
			accept = {
				auto_brackets = { enabled = true },
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
	opts_extend = {
		"sources.completion.enabled_providers",
		"sources.default",
	},
	---@param opts blink.cmp.Config | { sources: { compat: string[] } }
	config = function(_, opts)
		-- check if we need to override symbol kinds
		for _, provider in pairs(opts.sources.providers or {}) do
			---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
			if provider.kind then
				local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
				local kind_idx = #CompletionItemKind + 1

				CompletionItemKind[kind_idx] = provider.kind
				---@diagnostic disable-next-line: no-unknown
				CompletionItemKind[provider.kind] = kind_idx

				---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
				local transform_items = provider.transform_items
				---@param ctx blink.cmp.Context
				---@param items blink.cmp.CompletionItem[]
				provider.transform_items = function(ctx, items)
					items = transform_items and transform_items(ctx, items) or items
					for _, item in ipairs(items) do
						item.kind = kind_idx or item.kind
						item.kind_icon = Util.config.icons.kinds[item.kind_name] or item.kind_icon or nil
					end
					return items
				end

				-- Unset custom prop to pass blink.cmp validation
				provider.kind = nil
			end
		end

		require("blink.cmp").setup(opts)
	end,
}
