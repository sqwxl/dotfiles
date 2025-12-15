return {
	{
		-- highlighting for chezmoi template files
		"alker0/chezmoi.vim",
		init = function()
			vim.g["chezmoi#use_tmp_buffer"] = 1
			vim.g["chezmoi#source_dir_path"] = vim.env.HOME .. "/.local/share/chezmoi"
		end,
	},

	{
		"xvzc/chezmoi.nvim",
		cmd = { "ChezmoiEdit" },
		init = function()
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = { vim.env.HOME .. "/.local/share/chezmoi/*" },
				callback = function()
					vim.schedule(require("chezmoi.commands.__edit").watch)
				end,
			})
		end,
		opts = {
			edit = {
				watch = false,
				force = false,
			},
			notification = {
				on_open = true,
				on_apply = true,
				on_watch = false,
			},
			telescope = {
				select = { "<CR>" },
			},
		},
		keys = {
			{
				"<leader>sz",
				function()
					require("chezmoi.pick").snacks()
				end,
				desc = "Chezmoi",
			},
			{
				"<leader>sZ",
				function()
					require("chezmoi.pick").snacks(vim.fn.stdpath("config"))
				end,
				desc = "Chezmoi (nvim)",
			},
		},
	},

	{
		"folke/snacks.nvim",
		optional = true,
		opts = function(_, opts)
			local chezmoi_entry = {
				icon = " ",
				key = "c",
				desc = "Config",
				action = function()
					require("chezmoi.pick").snacks()
				end,
			}
			local config_index
			for i = #opts.dashboard.preset.keys, 1, -1 do
				if opts.dashboard.preset.keys[i].key == "c" then
					table.remove(opts.dashboard.preset.keys, i)
					config_index = i
					break
				end
			end
			table.insert(opts.dashboard.preset.keys, config_index, chezmoi_entry)
		end,
	},

	-- Filetype icons
	{
		"nvim-mini/mini.icons",
		optional = true,
		opts = {
			file = {
				[".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" },
				[".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" },
				[".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" },
				[".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" },
				["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
				["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
				["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
				["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
				["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
				["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
				["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
			},
		},
	},
}
