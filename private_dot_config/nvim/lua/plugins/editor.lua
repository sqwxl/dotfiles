return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		---@module "gruvbox"
		---@type GruvboxConfig
		opts = {
			transparent_mode = true,
			overrides = {
				WindowPickerStatusLine = { link = "GruvboxBlueBold" },
				WindowPickerStatusLineNC = { link = "GruvboxAqua" },
				WindowPickerWinBar = { link = "GruvboxBlueBold" },
				WindowPickerWinBarNC = { link = "GruvboxAqua" },
			},
		},
	},

	{
		"folke/snacks.nvim",
		dependencies = { "nvim-mini/mini.icons", "nvim-tree/nvim-web-devicons" },
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			indent = { enabled = false },
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{ icon = "󰙅 ", key = "e", desc = "Explorer", action = ":Neotree" },
						{ icon = " ", key = "n", desc = "New file", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "/",
							desc = "Grep",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "s", desc = "Restore session", section = "session" },
						{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
						{ icon = "󰋖 ", key = "h", desc = "Help", action = ":lua Snacks.dashboard.pick('help')" },
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
		config = function(_, opts)
			Snacks.toggle.animate():map("<Leader>ua")
			Snacks.toggle.diagnostics():map("<Leader>ud")
			Snacks.toggle.dim():map("<Leader>uD")
			Snacks.toggle.indent():map("<Leader>ug")
			Snacks.toggle.inlay_hints():map("<Leader>uh")
			Snacks.toggle.line_number():map("<Leader>ul")
			Snacks.toggle
				.option("background", { off = "light", on = "dark", name = "Dark Background" })
				:map("<Leader>ub")
			Snacks.toggle
				.option(
					"conceallevel",
					{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
				)
				:map("<Leader>uc")
			Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<Leader>uL")
			Snacks.toggle
				.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
				:map("<Leader>uA")
			Snacks.toggle.option("spell", { name = "Spelling" }):map("<Leader>us")
			Snacks.toggle.option("wrap", { name = "Wrap" }):map("<Leader>uw")
			Snacks.toggle.profiler():map("<Leader>dpp")
			Snacks.toggle.profiler_highlights():map("<Leader>dph")
			Snacks.toggle.scroll():map("<Leader>uS")
			Snacks.toggle.treesitter():map("<Leader>uT")
			Snacks.toggle({
				name = "Context header",
				get = function()
					return require("treesitter-context").enabled()
				end,
				set = function(state)
					if state then
						require("treesitter-context").enable()
					else
						require("treesitter-context").disable()
					end
				end,
			}):map("<Leader>ut")
			Snacks.toggle.zen():map("<Leader>uz")
			Snacks.toggle.zoom():map("<Leader>wm"):map("<Leader>uZ")
			Snacks.toggle({
				name = "Format on save",
				get = function()
					return vim.g.format_on_save
				end,
				set = function(state)
					vim.g.format_on_save = state
				end,
			}):map("<Leader>uf")

			require("snacks").setup(opts)
		end,
		keys = {
			-- stylua: ignore start
			{ "<Leader>$",   function() Snacks.picker.recent({ filter = { cwd = true } }) end, desc = "Recent (cwd)" },
			{ "<Leader>,",   function() Snacks.picker.buffers() end,                           desc = "Buffers" },
			{ "<Leader>.",   function() Snacks.picker.smart() end,                             desc = "Smart find files" },
			{ "<Leader>/",   function() Snacks.picker.grep() end,                              desc = "Grep" },
			{ "<Leader>:",   function() Snacks.picker.command_history() end,                   desc = "Command history" },
			{ "<Leader>f",   function() Snacks.picker.files() end,                             desc = "Find files" },
			{ "<Leader>cR",  function() Snacks.rename.rename_file() end,                       desc = "Rename file" },
			{ "<Leader>cl",  function() Snacks.picker.lsp_config() end,                        desc = "LSP info" },
			{ "<Leader>gd",  function() Snacks.picker.git_diff() end,                          desc = "Git diff (hunks)" },
			{ "<Leader>gs",  function() Snacks.picker.git_status() end,                        desc = "Git status" },
			{ "<Leader>gS",  function() Snacks.picker.git_stash() end,                         desc = "Git stash" },
			{ "<Leader>n",   function() Snacks.picker.notifications() end,                     desc = "Notification history" },
			{ "<Leader>s/",  function() Snacks.picker.search_history() end,                    desc = "Search history" },
			{ "<Leader>s\"", function() Snacks.picker.registers() end,                         desc = "Registers" },
			{ "<Leader>sa",  function() Snacks.picker.autocmds() end,                          desc = "Autocmds" },
			{ "<Leader>sb",  function() Snacks.picker.grep_buffers() end,                      desc = "Grep buffers" },
			{ "<Leader>sc",  function() Snacks.picker.commands() end,                          desc = "Commands" },
			{ "<Leader>sd",  function() Snacks.picker.diagnostics() end,                       desc = "Diagnostics" },
			{ "<Leader>sD",  function() Snacks.picker.diagnostics_buffer() end,                desc = "Buffer diagnostics" },
			{ "<Leader>sh",  function() Snacks.picker.help() end,                              desc = "Help pages" },
			{ "<Leader>sH",  function() Snacks.picker.highlights() end,                        desc = "Highlights" },
			{ "<Leader>si",  function() Snacks.picker.icons() end,                             desc = "Icons" },
			{ "<Leader>sj",  function() Snacks.picker.jumps() end,                             desc = "Jumps" },
			{ "<Leader>sk",  function() Snacks.picker.keymaps() end,                           desc = "Keymaps" },
			{ "<Leader>sl",  function() Snacks.picker.loclist() end,                           desc = "Location list" },
			{ "<Leader>sm",  function() Snacks.picker.marks() end,                             desc = "Marks" },
			{ "<Leader>sM",  function() Snacks.picker.man() end,                               desc = "Man pages" },
			{ "<Leader>sp",  function() Snacks.picker.lazy() end,                              desc = "Plugin specs" },
			{ "<Leader>sq",  function() Snacks.picker.qflist() end,                            desc = "Quickfix List" },
			{ "<Leader>sR",  function() Snacks.picker.resume() end,                            desc = "Resume last search" },
			{ "<Leader>ss",  function() Snacks.picker.lsp_symbols() end,                       desc = "LSP symbols" },
			{ "<Leader>sS",  function() Snacks.picker.lsp_workspace_symbols() end,             desc = "LSP workspace symbols" },
			{ "<Leader>su",  function() Snacks.picker.undo() end,                              desc = "Undo history" },
			{ "<Leader>sw",  function() Snacks.picker.grep_word() end,                         desc = "Grep selection or word", mode = { "n", "x" } },
			{ "<Leader>uC",  function() Snacks.picker.colorschemes() end,                      desc = "Colorschemes" },
			{ "<Leader>un",  function() Snacks.picker.notifications() end,                     desc = "Notification history" },
			-- stylua: ignore end
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
		lazy = false,
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
			-- because `cwd` is not set up properly.
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
				desc = "Start Neo-tree with directory",
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then
						return
					else
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == "directory" then
							require("neo-tree")
						end
					end
				end,
			})
		end,
		---@module "neo-tree"
		---@type neotree.Config
		opts = {
			sources = { "filesystem", "buffers", "git_status" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			commands = {
				yank_path = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.fn.setreg("+", path, "c")
				end,
				open_with_os = function(state)
					require("lazy.util").open(state.tree:get_node().path, { system = true })
				end,
			},
			window = {
				position = "left",
				mappings = {
					["<cr>"] = "open_with_window_picker",
					["s"] = "split_with_window_picker",
					["v"] = "vsplit_with_window_picker",
					["l"] = "open",
					["h"] = "close_node",
					["Y"] = "yank_path",
					["O"] = "open_with_os",
				},
			},
			default_component_configs = {
				file_size = { enabled = false },
				last_modified = { enabled = false, format = "relative" },
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						unstaged = "󰄱",
						staged = "󰱒",
					},
				},
			},
		},
		config = function(_, opts)
			local function on_move(data)
				Snacks.rename.on_rename_file(data.source, data.destination)
			end

			local events = require("neo-tree.events")
			opts.event_handlers = opts.event_handlers or {}
			vim.list_extend(opts.event_handlers, {
				{ event = events.FILE_MOVED, handler = on_move },
				{ event = events.FILE_RENAMED, handler = on_move },
			})
			require("neo-tree").setup(opts)
			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*gitui",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
		end,
		keys = {
			{
				"<A-Bslash>",
				function()
					require("neo-tree.command").execute({ reveal = true })
				end,
				desc = "Reveal in explorer",
			},
			{
				"<Leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Toggle explorer",
			},
			{
				"<Leader>ge",
				function()
					require("neo-tree.command").execute({ source = "git_status", toggle = true })
				end,
				desc = "Git explorer",
			},
			{
				"<Leader>be",
				function()
					require("neo-tree.command").execute({ source = "buffers", toggle = true })
				end,
				desc = "Buffer explorer",
			},
		},
	},

	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		name = "window-picker",
		event = "VeryLazy",
		opts = {
			hint = "floating-big-letter",
			show_prompt = false,
			selection_chars = "aoeuidhtnsqjkxbmwvz",
			filter_rules = {
				include_current_win = false,
				autoselect_one = true,
				bo = {
					filetype = { "neo-tree", "neo-tree-popup", "notify", "noice", "snacks_notif", "aerial" },
					buftype = { "terminal", "quickfix" },
				},
			},
			highlights = {
				statusline = {
					focused = "WindowPickerStatusLine",
					unfocused = "WindowPickerStatusLineNC",
				},
				winbar = {
					focused = "WindowPickerWinBar",
					unfocused = "WindowPickerWinBarNC",
				},
			},
		},
		keys = {
			{
				"<Leader>W",
				function()
					local nr = require("window-picker").pick_window()
					if nr ~= nil then
						vim.cmd.wincmd(nr .. " w")
					end
				end,
				desc = "Pick window",
			},
		},
	},

	{
		"j-hui/fidget.nvim", -- lsp status progress
		opts = {
			progress = {
				suppress_on_insert = true,
				ignore_done_already = true,
				ignore_empty_message = true,
				display = {
					render_limit = 2,
				},
			},
		},
	},

	{
		"nvim-mini/mini.icons",
		lazy = true,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts_extend = { "spec" },
		opts = {
			preset = "modern",
			defaults = {},
			spec = {
				{
					mode = { "n", "v" },
					{ "<Leader>a", group = "copilot" },
					{ "<Leader>c", group = "code" },
					{ "<Leader>d", group = "debug" },
					{ "<Leader>g", group = "git" },
					{ "<Leader>gh", group = "hunks" },
					{ "<Leader>q", group = "quit/session" },
					{ "<Leader>s", group = "search" },
					{ "<Leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
					{ "<Leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
					{
						"<Leader>b",
						group = "buffer",
						expand = function()
							return require("which-key.extras").expand.buf()
						end,
					},
					{
						"<Leader>w",
						group = "windows",
						proxy = "<c-w>",
						expand = function()
							return require("which-key.extras").expand.win()
						end,
					},
					{ "gx", desc = "Open with system app" },
				},
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
		end,
		keys = {
			{
				"<Leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
			{
				"<Leader><c-w>",
				function()
					require("which-key").show({ keys = "<c-w>", loop = true })
				end,
				desc = "Window Hydra Mode (which-key)",
			},
		},
	},

	{
		"stevearc/aerial.nvim", -- lsp symbols overview
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		event = "LazyFile",
		opts = {
			attach_mode = "window",
			backends = { "lsp", "treesitter", "markdown", "man" },
			layout = {
				resize_to_content = false,
				win_opts = {
					winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
					signcolumn = "yes",
					statuscolumn = " ",
				},
			},
			show_guides = true,
			guides = {
				mid_item = "├╴",
				last_item = "└╴",
				nested_top = "│ ",
				whitespace = "  ",
			},
			-- HACK: fix lua's weird choice for `Package` for control structures like if/else/for/etc.
			icons = vim.tbl_extend(
				"force",
				{},
				Sqwxl.config.icons.kinds,
				{ Package = Sqwxl.config.icons.kinds.Control }
			),
		},
		keys = {
			{ "<Leader>cs", "<cmd>AerialToggle<cr>", desc = "Symbols panel" },
		},
	},

	{
		"folke/flash.nvim", -- jump around
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			labels = "aoeuidhtnsqjkxbmwvzpyfgcrl",
			jump = { autojump = true },
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
				desc = "Flash treesitter",
				mode = { "n", "o", "x" },
			},
			{
				"r",
				function()
					require("flash").remote()
				end,
				desc = "Remote flash",
				mode = "o",
			},
			{
				"R",
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter search",
				mode = { "o", "x" },
			},
			{
				"<C-s>",
				function()
					require("flash").toggle()
				end,
				desc = "Toggle flash search",
				mode = { "c" },
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "LazyFile",
		opts = function()
			Snacks.toggle({
				name = "Git signs",
				get = function()
					return require("gitsigns.config").config.signcolumn
				end,
				set = function(state)
					require("gitsigns").toggle_signs(state)
				end,
			}):map("<Leader>uG")

			return {
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
				signs_staged = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
				},
				on_attach = function(buffer)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
					end

					map("n", "]h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gs.nav_hunk("next")
						end
					end, "Next hunk")
					map("n", "[h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gs.nav_hunk("prev")
						end
					end, "Prev hunk")
					map("n", "]H", function()
						gs.nav_hunk("last")
					end, "Last hunk")
					map("n", "[H", function()
						gs.nav_hunk("first")
					end, "First hunk")
					map({ "n", "v" }, "<Leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
					map({ "n", "v" }, "<Leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
					map("n", "<Leader>ghS", gs.stage_buffer, "Stage buffer")
					map("n", "<Leader>ghu", gs.undo_stage_hunk, "Undo stage hunk")
					map("n", "<Leader>ghR", gs.reset_buffer, "Reset buffer")
					map("n", "<Leader>ghp", gs.preview_hunk_inline, "Preview hunk inline")
					map("n", "<Leader>ghb", function()
						gs.blame_line({ full = true })
					end, "Blame line")
					map("n", "<Leader>ghB", function()
						gs.blame()
					end, "Blame buffer")
					map("n", "<Leader>ghd", gs.diffthis, "Diff this")
					map("n", "<Leader>ghD", function()
						gs.diffthis("~")
					end, "Diff this ~")
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
				end,
			}
		end,
	},

	{ url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git" },

	{
		"lukas-reineke/indent-blankline.nvim",
		dependencies = "tpope/vim-sleuth", -- set shiftwidth and tabstop automatically.
		event = "LazyFile",
		main = "ibl",
		opts = function()
			Snacks.toggle({
				name = "Indention guides",
				get = function()
					return require("ibl.config").get_config(0).enabled
				end,
				set = function(state)
					require("ibl").setup_buffer(0, { enabled = state })
				end,
			}):map("<leader>ug")

			return {
				indent = {
					char = "│",
					tab_char = "│",
				},
				scope = { show_start = false, show_end = false },
				exclude = {
					filetypes = {
						"Trouble",
						"alpha",
						"dashboard",
						"help",
						"lazy",
						"mason",
						"neo-tree",
						"notify",
						"snacks_dashboard",
						"snacks_notif",
						"snacks_terminal",
						"snacks_win",
						"toggleterm",
						"trouble",
					},
				},
			}
		end,
	},

	{
		"norcalli/nvim-colorizer.lua", -- highlight color strings
		event = "VeryLazy",
		---@module "colorizer"
		opts = { "html", "jinja", "eruby", "htmldjango", "markdown", "css", "scss", "sass" },
		keys = { { "<Leader>uH", "<Cmd>ColorizerToggle<CR>", desc = "Toggle color highlighting" } },
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			highlights = {
				pattern = [[.*<(KEYWORDS)\s*:]],
			},
		},
	},
}
