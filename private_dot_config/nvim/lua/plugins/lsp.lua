return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        update_in_insert = false,
      },
      servers = {
        ada_ls = {},
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true, -- Using Ruff
              disableTaggedHints = true, -- Using Ruff
              analysis = {
                autoImportCompletions = true,
                diagnosticSeverityOverrides = {
                  reportUndefinedVariable = "none",
                },
              },
            },
          },
        },
        ruff = {
          settings = {
            lineLength = { 120 },
          },
        },
        bashls = {},
        html = {
          filetypes = { "html", "htmldjango" },
        },
        harper_ls = {
          root_dir = function(fname)
            -- Only run Harper in Normcore projects
            if string.match(fname, "^.*[nN]ormcore.*$") == nil then
              return nil
            end

            return require("lspconfig").harper_ls.config_def.default_config.root_dir(fname)
          end,
          single_file_support = false, -- If this is true, then the rood_dir function above will have no effect
          settings = {
            ["harper-ls"] = {
              userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
              codeActions = { forceStable = true },
              linters = {
                avoid_curses = false,
              },
            },
          },
        },
        htmx = {
          filetypes = { "html", "htmldjango" },
        },
        biome = {
          autostart = false,
        },
        lua_ls = {
          settings = {
            Lua = {
              codelens = { enabled = false },
              diagnostics = {
                disable = { "redefined-local", "lowercase-global" },
              },
              format = {
                defaultConfig = {
                  call_arg_parentheses = "remove_string_only",
                },
              },
            },
          },
        },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      -- PATH = "append", -- So that shell PATH will take precedence
      -- LSP servers are listed above, and are installed by mason-lspconfig; this is for linters & formatters.
      ensure_installed = {
        "biome",
        "djlint",
        "markdownlint",
        "prettierd",
        "rustywind",
        "shellcheck",
        "shfmt",
        "sqlfluff",
      },
    },
  },

  {
    "sqwxl/playdate.nvim",
    opts = {
      playdate_luacats_path = "~/Clones/playdate-luacats",
      server_settings = {
        Lua = {
          format = {
            defaultConfig = {
              call_arg_parentheses = "remove_string_only",
            },
          },
        },
      },
    },
  },
}
