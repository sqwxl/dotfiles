local sql_ft = { "sql", "mysql", "plsql" }

return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = { ensure_installed = { "sql" } },
	},

	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "sqlfluff" } },
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = function(_, opts)
			for _, ft in ipairs(sql_ft) do
				opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
				table.insert(opts.linters_by_ft[ft], "sqlfluff")
			end
			opts.linters.sqlfluff = { args = { "lint", "--format=json", "--dialect=postgres" } }
		end,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = function(_, opts)
			opts.formatters.sqlfluff = {
				args = { "format", "--dialect=postgres", "-" },
				require_cwd = false,
			}
			for _, ft in ipairs(sql_ft) do
				opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
				table.insert(opts.formatters_by_ft[ft], "sqlfluff")
			end
		end,
	},

	{
		"tpope/vim-dadbod",
		cmd = "DB",
	},

	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = "vim-dadbod",
		ft = sql_ft,
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		dependencies = "vim-dadbod",
		keys = {
			{ "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
		},
		init = function()
			local data_path = vim.fn.stdpath("data")

			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
			vim.g.db_ui_show_database_icon = true
			vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
			vim.g.db_ui_use_nerd_fonts = true
			vim.g.db_ui_use_nvim_notify = true

			-- NOTE: The default behavior of auto-execution of queries on save is disabled
			-- this is useful when you have a big query that you don't want to run every time
			-- you save the file running those queries can crash neovim to run use the
			-- default keymap: <leader>S
			vim.g.db_ui_execute_on_save = false
		end,
	},

	-- blink.cmp integration
	{
		"saghen/blink.cmp",
		optional = true,
		opts = {
			sources = {
				default = { "dadbod" },
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
		},
		dependencies = {
			"kristijanhusak/vim-dadbod-completion",
		},
	},
}
