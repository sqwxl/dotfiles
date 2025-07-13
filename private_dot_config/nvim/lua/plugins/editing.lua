return {
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
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
	},

	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "ys",
				normal_cur = "yss",
				normal_line = "yS",
				normal_cur_line = "ySS",
				visual = "S",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
				change_line = "cS",
			},
			aliases = {
				["a"] = ">",
				["b"] = ")",
				["B"] = "}",
				["r"] = "]",
				["q"] = { '"', "'", "`" },
				["s"] = { "}", "]", ")", ">", '"', "'", "`" },
			},
			highlight = {
				duration = 0,
			},
			move_cursor = "begin",
			indent_lines = function(start, stop)
				local b = vim.bo
				-- Only re-indent the selection if a formatter is set up already
				if
					start < stop and (b.equalprg ~= "" or b.indentexpr ~= "" or b.cindent or b.smartindent or b.lisp)
				then
					vim.cmd(string.format("silent normal! %dG=%dG", start, stop))
					require("nvim-surround.cache").set_callback("")
				end
			end,
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			fast_wrap = {}, -- bound to <A-e> by default
		},
	},

	{
		"danymat/neogen",
		cmd = "Neogen",
		opts = {
			snippet_engin = "nvim",
		},
	},

	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					g = function(ai_type)
						local start_line, end_line = 1, vim.fn.line("$")
						if ai_type == "i" then
							-- Skip first and last blank lines for `i` textobject
							local first_nonblank, last_nonblank =
								vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
							-- Do nothing for buffer with all blanks
							if first_nonblank == 0 or last_nonblank == 0 then
								return { from = { line = start_line, col = 1 } }
							end
							start_line, end_line = first_nonblank, last_nonblank
						end

						local to_col = math.max(vim.fn.getline(end_line):len(), 1)
						return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
					end,
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
			require("sqwxl.plugins").on_load("which-key.nvim", function()
				vim.schedule(function()
					local objects = {
						{ " ", desc = "whitespace" },
						{ '"', desc = '" string' },
						{ "'", desc = "' string" },
						{ "(", desc = "() block" },
						{ ")", desc = "() block with ws" },
						{ "<", desc = "<> block" },
						{ ">", desc = "<> block with ws" },
						{ "?", desc = "user prompt" },
						{ "U", desc = "use/call without dot" },
						{ "[", desc = "[] block" },
						{ "]", desc = "[] block with ws" },
						{ "_", desc = "underscore" },
						{ "`", desc = "` string" },
						{ "a", desc = "argument" },
						{ "b", desc = ")]} block" },
						{ "c", desc = "class" },
						{ "d", desc = "digit(s)" },
						{ "e", desc = "CamelCase / snake_case" },
						{ "f", desc = "function" },
						{ "g", desc = "entire file" },
						{ "i", desc = "indent" },
						{ "o", desc = "block, conditional, loop" },
						{ "q", desc = "quote `\"'" },
						{ "t", desc = "tag" },
						{ "u", desc = "use/call" },
						{ "{", desc = "{} block" },
						{ "}", desc = "{} with ws" },
					}

					---@type wk.Spec[]
					local ret = { mode = { "o", "x" } }
					---@type table<string, string>
					local mappings = vim.tbl_extend("force", {}, {
						around = "a",
						inside = "i",
						around_next = "an",
						inside_next = "in",
						around_last = "al",
						inside_last = "il",
					}, opts.mappings or {})
					mappings.goto_left = nil
					mappings.goto_right = nil

					for name, prefix in pairs(mappings) do
						name = name:gsub("^around_", ""):gsub("^inside_", "")
						ret[#ret + 1] = { prefix, group = name }
						for _, obj in ipairs(objects) do
							local desc = obj.desc
							if prefix:sub(1, 1) == "i" then
								desc = desc:gsub(" with ws", "")
							end
							ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
						end
					end
					require("which-key").add(ret, { notify = false })
				end)
			end)
		end,
	},
}
