return {
	-- complete some structures like if -> end, do -> while
	{
		"RRethy/nvim-treesitter-endwise",
		event = "VeryLazy",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = ":TSUpdate",
		event = { "LazyFile", "VeryLazy" },
		cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
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

			setmetatable(require("nvim-treesitter.install"), {})

			-- some quick sanity checks
			if not TS.get_installed then
				return Sqwxl.error("Please use `:Lazy` and update `nvim-treesitter`")
			elseif type(opts.ensure_installed) ~= "table" then
				return Sqwxl.error("`nvim-treesitter` opts.ensure_installed must be a table")
			end

			-- setup treesitter
			TS.setup(opts)
			Sqwxl.treesitter.get_installed(true) -- initialize the installed langs

			-- install missing parsers
			local install = vim.tbl_filter(function(lang)
				return not Sqwxl.treesitter.have(lang)
			end, opts.ensure_installed or {})
			if #install > 0 then
				Sqwxl.treesitter.ensure_treesitter_cli(function()
					TS.install(install, { summary = true }):await(function()
						Sqwxl.treesitter.get_installed(true) -- refresh the installed langs
					end)
				end)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("sqwxl_treesitter", { clear = true }),
				callback = function(ev)
					local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
					if not Sqwxl.treesitter.have(ft) then
						return
					end

					local function enabled(feat, query)
						local f = opts[feat] or {}
						return f.enable ~= false
							and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
							and Sqwxl.treesitter.have(ft, query)
					end

					-- highlighting
					if enabled("highlight", "highlights") then
						pcall(vim.treesitter.start, ev.buf)
					end

					-- indents
					if enabled("indent", "indents") then
						Sqwxl.set_default("indentexpr", "v:lua.require'nvim-treesitter'.indentexpr()")
					end

					-- folds
					if enabled("folds", "folds") then
						if Sqwxl.set_default("foldmethod", "expr") then
							Sqwxl.set_default("foldexpr", "v:lua.vim.treesitter.foldexpr()")
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
				keys = {
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
		},
		config = function(_, opts)
			local TS = require("nvim-treesitter-textobjects")
			if not TS.setup then
				Sqwxl.error("Please use `:Lazy` and update `nvim-treesitter`")
				return
			end
			TS.setup(opts)

			local function attach(buf)
				local ft = vim.bo[buf].filetype
				if not (vim.tbl_get(opts, "move", "enable") and Sqwxl.treesitter.have(ft, "textobjects")) then
					return
				end
				---@type table<string, table<string, string>>
				local moves = vim.tbl_get(opts, "move", "keys") or {}

				for method, keymaps in pairs(moves) do
					for key, query in pairs(keymaps) do
						local queries = type(query) == "table" and query or { query }
						local parts = {}
						for _, q in ipairs(queries) do
							local part = q:gsub("@", ""):gsub("%..*", "")
							part = part:sub(1, 1):upper() .. part:sub(2)
							table.insert(parts, part)
						end
						local desc = table.concat(parts, " or ")
						desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
						desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
						if not (vim.wo.diff and key:find("[cC]")) then
							vim.keymap.set({ "n", "x", "o" }, key, function()
								require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
							end, {
								buffer = buf,
								desc = desc,
								silent = true,
							})
						end
					end
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
				callback = function(ev)
					attach(ev.buf)
				end,
			})
			vim.tbl_map(attach, vim.api.nvim_list_bufs())
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "LazyFile",
	},
}
