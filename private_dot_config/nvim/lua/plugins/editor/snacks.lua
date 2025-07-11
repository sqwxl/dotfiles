return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				header = [[
        ______ _____ ______ __  __ __ __________
       /\  __ \\  __\\  __ \\ \/\ \\_\\  __  __ \
       \ \ \/\ \\  __\\ \_\ \\ \/ |/\ \\ \/\ \/\ \
        \ \_\ \_\\____\\_____\\__/ \ \_\\_\ \_\ \_\
         \/_/\/_//____//_____//_/   \/_//_/\/_/\/_/]],
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = "󰙅 ", key = "e", desc = "Explorer", action = ":Neotree" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
					{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			formats = {
				header = { "%s", align = "left" },
			},
			sections = {
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
		notifier = { enabled = false, timeout = 3000 },
		statuscolumn = { enabled = true },
		picker = { enabled = true, formatters = { file = { truncate = 80 } } },
		styles = { notifications = { wo = { wrap = true }, relative = true } },
	},
	dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.zen():map("<leader>uz")
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle
					.option(
						"conceallevel",
						{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
					)
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle.dim():map("<leader>uD")

				Snacks.toggle.inlay_hints():map("<leader>uh")
			end,
		})
	end,
}
