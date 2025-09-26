local fts = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx" }

vim.lsp.config("ts_ls", {
	init_options = {
		-- plugins = {
		-- 	{
		-- 		name = "@vue/typescript-plugin",
		-- 		location = vim.fs.joinpath(vim.g.npm_global_modules, "@vue/typescript-plugin"),
		-- 		languages = { "javascript", "typescript", "vue" },
		-- 	},
		-- },
	},
	filetypes = fts,
})
vim.lsp.enable("ts_ls")

return {
	{
		"mason-org/mason.nvim",
		optional = true,
		opts = {
			ensure_installed = { "js-debug-adapter", "typescript-language-server" },
		},
	},

	-- {
	-- 	"mfussenegger/nvim-lint",
	-- 	optional = true,
	-- 	opts = function(_, opts)
	-- 		for _, ft in ipairs(fts) do
	-- 			opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
	-- 			table.insert(opts.linters_by_ft[ft], "biomejs")
	-- 		end
	-- 	end,
	-- },

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = function(_, opts)
			for _, ft in ipairs(fts) do
				opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
				table.insert(opts.formatters_by_ft[ft], "prettierd")
			end
		end,
	},

	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = { "mason-org/mason.nvim" },
		opts = function()
			local dap = require("dap")
			if not dap.adapters["pwa-node"] then
				require("dap").adapters["pwa-node"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = {
							vim.fs.joinpath(
								vim.fn.stdpath("data"),
								"mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
							),
							"${port}",
						},
					},
				}
			end
			if not dap.adapters["node"] then
				dap.adapters["node"] = function(cb, config)
					if config.type == "node" then
						config.type = "pwa-node"
					end
					local nativeAdapter = dap.adapters["pwa-node"]
					if type(nativeAdapter) == "function" then
						nativeAdapter(cb, config)
					else
						cb(nativeAdapter)
					end
				end
			end

			local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

			local vscode = require("dap.ext.vscode")
			vscode.type_to_filetypes["node"] = js_filetypes
			vscode.type_to_filetypes["pwa-node"] = js_filetypes

			for _, language in ipairs(js_filetypes) do
				if not dap.configurations[language] then
					dap.configurations[language] = {
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							cwd = "${workspaceFolder}",
						},
						{
							type = "pwa-node",
							request = "attach",
							name = "Attach",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
						},
					}
				end
			end
		end,
	},

	{
		"echasnovski/mini.icons",
		optional = true,
		opts = {
			file = {
				[".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
				[".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
				[".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
				[".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
				["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
				["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
				["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
				["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
				["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
			},
		},
	},
}
