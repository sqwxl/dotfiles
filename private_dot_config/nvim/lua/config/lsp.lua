-- vim.lsp.inlay_hint.enable(false)
--
vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = function(diagnostic)
			local icons = Sqwxl.config.icons.diagnostics
			for d, icon in pairs(icons) do
				if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
					return icon
				end
			end
			return "●"
		end,
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = Sqwxl.config.icons.diagnostics.Error,
			[vim.diagnostic.severity.WARN] = Sqwxl.config.icons.diagnostics.Warn,
			[vim.diagnostic.severity.HINT] = Sqwxl.config.icons.diagnostics.Hint,
			[vim.diagnostic.severity.INFO] = Sqwxl.config.icons.diagnostics.Info,
		},
	},
})

vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			disableOrganizeImports = true, -- Using Ruff
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				diagnosticSeverityOverrides = {
					reportAny = "none",
					reportUnknownVariableType = "none",
					reportUnknownMemberType = "none",
					reportUnknownArgumentType = "none",
					reportUnusedExpression = "none",
					reportUnusedCallResult = "none",
				},
			},
		},
	},
})

vim.lsp.config("harper_ls", {
	settings = {
		["harper-ls"] = {
			userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
			codeActions = { forceStable = true },
			linters = { avoid_curses = false },
		},
	},
})

vim.lsp.config("jsonls", {
	-- lazy-load schemastore when needed
	before_init = function(_, new_config)
		new_config.settings.json.schemas = new_config.settings.json.schemas or {}
		vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
	end,
	settings = {
		json = {
			format = {
				enable = true,
			},
			validate = { enable = true },
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			codelens = { enabled = false },
			diagnostics = {
				disable = { "redefined-local", "lowercase-global" },
			},
			format = {
				enabled = true,
				defaultConfig = {
					quote_style = "double",
					call_arg_parenthesese = "remove_string_only",
				},
			},
			hint = {
				enable = true,
				setType = false,
				paramType = true,
				paramName = "Disable",
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
			workspace = {
				checkThirdParty = false,
			},
		},
	},
})

vim.lsp.config("ruby_lsp", {
	init_options = {
		formatter = "standard",
		linters = { "standard" },
	},
	reuse_client = function(client, config)
		return client.config.root_dir == config.root_dir
	end,
})

vim.lsp.config("ruff", {
	init_options = {
		settings = {
			lineLength = 160,
		},
	},
})

vim.lsp.config("ts_ls", {
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx" },
})

vim.lsp.config("yamlls", {
	-- Have to add this for yamlls to understand that we support line folding
	capabilities = {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	},
	-- lazy-load schemastore when needed
	before_init = function(_, new_config)
		new_config.settings.yaml.schemas =
			vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
	end,
	settings = {
		redhat = { telemetry = { enabled = false } },
		yaml = {
			keyOrdering = false,
			format = { enable = true },
			validate = true,
			schemaStore = {
				-- Must disable built-in schemaStore support to use
				-- schemas from SchemaStore.nvim plugin
				enable = false,
				-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
				url = "",
			},
		},
	},
})

vim.lsp.enable({
	"basedpyright",
	"bashls",
	"cssls",
	"docker_compose_language_service",
	"dockerls",
	"fish_lsp",
	"fsautocomplete",
	"jsonls",
	"lua_ls",
	"ruby_lsp",
	"ruff",
	"taplo",
	"terraformls",
	"ts_ls",
	"yamlls",
})

-- harper_ls is configured but left disabled; enable per-session as needed.
vim.lsp.enable("harper_ls", false)

-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("sqwxl.lsp", {}),
-- callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--
--     -- Don't use LSP for syntax highlighting
--     client.server_capabilities.semanticTokensProvider = nil
-- end,
-- })
