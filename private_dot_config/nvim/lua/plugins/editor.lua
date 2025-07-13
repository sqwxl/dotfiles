return {
	{

		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
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
	},

	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		opts = {
			hint = "floating-big-letter",
			show_prompt = false,
			selection_chars = "aoeuidhtnsqjkxbmwvz",
			filter_rules = {
				include_current_win = false,
				autoselect_one = true,
				bo = {
					filetype = { "neo-tree", "neo-tree-popup", "notify", "noice", "snacks_notif", "aerial" },
					buftype = { "terminal" },
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
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
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
		---@type neotree.Config?
		opts = {
			sources = { "filesystem", "buffers", "git_status" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				position = "left",
				mappings = {
					["<cr>"] = "open_with_window_picker",
					["s"] = "split_with_window_picker",
					["v"] = "vsplit_with_window_picker",
					["l"] = "open",
					["h"] = "close_node",
					["<space>"] = "none",
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							local path = node:get_id()
							vim.fn.setreg("+", path, "c")
						end,
						desc = "Copy Path to Clipboard",
					},
					["O"] = {
						function(state)
							require("lazy.util").open(state.tree:get_node().path, { system = true })
						end,
						desc = "Open with System Application",
					},
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
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
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
	},

	{
		"j-hui/fidget.nvim", -- lsp status progress
		opts = {},
	},

	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
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
					{ "<leader><tab>", group = "tabs" },
					{ "<leader>c", group = "code" },
					{ "<leader>d", group = "debug" },
					{ "<leader>dp", group = "profiler" },
					{ "<leader>f", group = "file/find" },
					{ "<leader>g", group = "git" },
					{ "<leader>gh", group = "hunks" },
					{ "<leader>q", group = "quit/session" },
					{ "<leader>s", group = "search" },
					{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
					{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
					{
						"<leader>b",
						group = "buffer",
						expand = function()
							return require("which-key.extras").expand.buf()
						end,
					},
					{
						"<leader>w",
						group = "windows",
						proxy = "<c-w>",
						expand = function()
							return require("which-key.extras").expand.win()
						end,
					},
					-- better descriptions
					{ "gx", desc = "Open with system app" },
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
			{
				"<leader><c-w>",
				function()
					require("which-key").show({ keys = "<c-w>", loop = true })
				end,
				desc = "Window Hydra Mode (which-key)",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
		end,
	},

	{
		"stevearc/aerial.nvim", -- lsp symbols overview
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
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
			icons = vim.tbl_extend("force", {}, Sqwxl.icons.kinds, { Package = Sqwxl.icons.kinds.Control }),
		},
		keys = {
			{ "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
		},
	},

	{
		"folke/flash.nvim", -- jump around
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
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
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
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				map("n", "]g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]G", function()
					gs.nav_hunk("last")
				end, "Last Hunk")
				map("n", "[G", function()
					gs.nav_hunk("first")
				end, "First Hunk")
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>ghB", function()
					gs.blame()
				end, "Blame Buffer")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
	{
		"gitsigns.nvim",
		opts = function()
			Snacks.toggle({
				name = "Git Signs",
				get = function()
					return require("gitsigns.config").config.signcolumn
				end,
				set = function(state)
					require("gitsigns").toggle_signs(state)
				end,
			}):map("<leader>uG")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		-- For setting shiftwidth and tabstop automatically.
		dependencies = "tpope/vim-sleuth",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},

	{
		url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
	},

	{
		"norcalli/nvim-colorizer.lua", -- highlight color strings
		event = "VeryLazy",
		opts = {
			"html",
			"jinja",
			"eruby",
			"htmldjango",
			"markdown",
			"css",
			"scss",
			"sass",
		},
	},

	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		---@module "gruvbox"
		---@type GruvboxConfig
		opts = {
			contrast = "",
			dim_inactive = false,
			transparent_mode = false,
			overrides = {
				-- NeoTreeDirectoryName = { link = "GruvboxBlueBold" },
				-- NeoTreeDirectoryIcon = { link = "NeoTreeDirectoryName" },
				-- NeoTreeRootName = { link = "GruvboxAquaBold" },
				-- NeoTreeModified = { link = "GruvboxYellow" },
				-- NeoTreeGitAdded = { link = "GruvboxOrange" },
				-- NeoTreeFilterTerm = { link = "GruvboxGreenBold" },
				WindowPickerStatusLine = { link = "GruvboxBlueBold" },
				WindowPickerStatusLineNC = { link = "GruvboxAqua" },
				WindowPickerWinBar = { link = "GruvboxBlueBold" },
				WindowPickerWinBarNC = { link = "GruvboxAqua" },
			},
		},
	},
}
