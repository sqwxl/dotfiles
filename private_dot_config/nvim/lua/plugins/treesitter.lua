return {
	-- complete some structures like if -> end, do -> while
	{
		"RRethy/nvim-treesitter-endwise",
		event = "VeryLazy",
	},

	-- Automatically add closing tags for HTML and JSX
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = { aliases = { htmldjango = "html" } },
	},

	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		cmd = { "TSUpdate", "TSInstall", "TSUpdateSync" },
		opts_extend = { "ensure_installed" },
		---@class TSConfig
		opts = {
			endwise = { enable = true },
			indent = { enable = true },
			folds = { enable = true },
			highlight = {
				enable = true,
				disable = function(lang, _)
					return lang == "htmldjango"
				end,
				additional_vim_regex_highlighting = { "htmldjango" },
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			auto_install = true,
			sync_install = false,
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
		},
		config = function(_, opts)
			local TS = require("nvim-treesitter")

			setmetatable(require("nvim-treesitter.install"), {
				__newindex = function(_, k)
					if k == "compilers" then
						vim.schedule(function()
							vim.notify(
								"Setting custom compilers for `nvim-treesitter` is no longer supported.\nFor more info, see: https://docs.rs/cc/latest/cc/#compile-time-requirements",
								"error"
							)
						end)
					end
				end,
			})

			-- some quick sanity checks
			if not TS.get_installed then
				return vim.notify("Please use `:Lazy` and update `nvim-treesitter`", "error")
			elseif type(opts.ensure_installed) ~= "table" then
				return vim.notify("`nvim-treesitter` opts.ensure_installed must be a table", "error")
			end

			-- setup treesitter
			TS.setup(opts)
			Util.treesitter.get_installed(true) -- initialize the installed langs

			-- install missing parsers
			local install = vim.tbl_filter(function(lang)
				return not Util.treesitter.have(lang)
			end, opts.ensure_installed or {})
			if #install > 0 then
				Util.treesitter.ensure_treesitter_cli(function()
					TS.install(install, { summary = true }):await(function()
						Util.treesitter.get_installed(true) -- refresh the installed langs
					end)
				end)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("sqwxl_treesitter", { clear = true }),
				callback = function(ev)
					if not Util.treesitter.have(ev.match) then
						return
					end

					-- highlighting
					if vim.tbl_get(opts, "highlight", "enable") ~= false then
						pcall(vim.treesitter.start)
					end

					-- indents
					if vim.tbl_get(opts, "indent", "enable") ~= false and Util.treesitter.have(ev.match, "indents") then
						Util.set_default("indentexpr", "nvim_treesitter#indentexpr()")
					end

					-- folds
					if vim.tbl_get(opts, "folds", "enable") ~= false and Util.treesitter.have(ev.match, "folds") then
						if Util.set_default("foldmethod", "expr") then
							Util.set_default("foldexpr", "nvim_treesitter#foldexpr()")
						end
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		opts = {
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
					["]a"] = "@parameter.inner",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.inner",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]C"] = "@class.outer",
					["]A"] = "@parameter.inner",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[C"] = "@class.outer",
					["[A"] = "@parameter.inner",
				},
			},
		},
		config = function(_, opts)
			local TS = require("nvim-treesitter-textobjects")
			if not TS.setup then
				vim.notify("Please use `:Lazy` and update `nvim-treesitter`", "error")
				return
			end
			TS.setup(opts)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
				callback = function(ev)
					if not (vim.tbl_get(opts, "move", "enable") and Util.treesitter.have(ev.match, "textobjects")) then
						return
					end

					---@type table<string, table<string, string>>
					local moves = vim.tbl_get(opts, "move", "keys") or {}

					-- When in diff mode, we want to use the default
					-- vim text objects c & C instead of the treesitter ones.
					for method, keymaps in pairs(moves) do
						for key, query in pairs(keymaps) do
							local desc = query:gsub("@", ""):gsub("%..*", "")
							desc = desc:sub(1, 1):upper() .. desc:sub(2)
							desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
							desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
							if not (vim.wo.diff and key:find("[cC]")) then
								vim.keymap.set({ "n", "x", "o" }, key, function()
									require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
								end, {
									buffer = ev.buf,
									desc = desc,
									silent = true,
								})
							end
						end
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	},
}
