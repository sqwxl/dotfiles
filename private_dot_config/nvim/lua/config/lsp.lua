vim.lsp.config("*", {
    -- Anything defined here will serve as a merge base for server configs
})

---@type table<string, vim.lsp.Config>
local servers = {
    -- Bash
    bashls = {},

    -- Fish
    fish_lsp = {},

    -- Docker
    dockerls = {},
    docker_compose_language_service = {},

    -- Python
    basedpyright = {
        {
            settings = {
                basedpyright = {
                    disableOrganizeImports = true, -- Using Ruff
                    disableTaggedHints = true,     -- Using Ruff
                    analysis = {
                        autoImportCompletions = true,
                        diagnosticSeverityOverrides = {
                            reportUndefinedVariable = "none",
                        },
                    },
                },
            },
        }
    },
    ruff = { { settings = { lineLength = { 120 } } } },

    -- JavaScript
    ts_ls = {

        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vim.fs.joinpath(vim.g.npm_global_modules, "@vue/typescript-plugin"),
                    languages = { "javascript", "typescript", "vue" },
                },
            },
        },
        filetypes = {
            "javascript",
            "typescript",
            "vue",
        },
    },

    -- Vue
    volar = {
        init_options = {
            typescript = {
                tsdk = vim.fs.joinpath(vim.g.npm_global_modules, "typescript/lib")
            },
            vue = { hybridMode = true },
        },
        on_new_config = function(new_config, new_root_dir)
            local lib_path = vim.fs.find(vim.fs.joinpath(vim.g.npm_global_modules, "typescript/lib"),
                { path = new_root_dir, upward = true })[1]
            if lib_path then
                new_config.init_options.typescript.tsdk = lib_path
            end
        end
    },

    -- HTML
    html = { { filetypes = { "html", "htmldjango" } } },
    htmx = { { filetypes = { "html", "htmldjango" } } },

    -- Spelling
    harper_ls = {
        settings = {
            ["harper-ls"] = {
                userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
                codeActions = { forceStable = true },
                linters = { avoid_curses = false },
            },
        },
    },


    -- Lua
    lua_ls = {
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
                        call_arg_parenthesese = "remove_string_only"
                    }
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
    },

    -- TOML
    taplo = {},

    -- JSON
    jsonls = {
        -- lazy-load shemastore when needed
        on_new_config = function(new_config)
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

    },

    -- YAML
    yamlls = {},

}

vim.lsp.inlay_hint.enable(false)

vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
    severity_sort = true,
})

for server, config in pairs(servers) do
    config.capabilities = vim.tbl_deep_extend(
        "force",
        {},
        require("blink.cmp").get_lsp_capabilities(config.capabilities),
        { workspace = { fileOperations = { didRename = true, willRename = true } } }
    )
    require "lspconfig"[server].setup(config)
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("sqwxl.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Don't use LSP for syntax highlighting
        client.server_capabilities.semanticTokensProvider = nil
    end,
})
