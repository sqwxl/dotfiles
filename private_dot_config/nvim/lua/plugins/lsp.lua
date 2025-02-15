return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      vim.list_extend(keys, {
        {
          "gd",
          function()
            require("fzf-lua").lsp_definitions({
              jump_to_single_result = true,
              jump_to_single_result_action = require("fzf-lua.actions").file_switch_or_edit,
              ignore_current_line = true,
            })
          end,
          desc = "Go to definition",
          has = "definition",
        },
        {
          "gV",
          function()
            require("fzf-lua").lsp_definitions({
              jump_to_single_result = true,
              jump_to_single_result_action = require("fzf-lua.actions").file_vsplit,
              ignore_current_line = true,
            })
          end,
          desc = "Go to definition in vsplit",
          has = "definition",
        },
        {
          "gr",
          function()
            require("fzf-lua").lsp_references({
              jump_to_single_result = true,
              ignore_current_line = true,
              includeDeclaration = false,
            })
          end,
          desc = "References",
          nowait = true,
        },
        { "<Leader>r", vim.lsp.buf.rename, desc = "Rename" },
      })
    end,

    opts = {
      inlay_hints = { enabled = false },
      document_highlight = { enabled = false }, -- Enable LSP cursor word highlighting
      servers = {
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
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        biome = {
          mason = false,
          autostart = false,
        },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "append", -- So that shell PATH will take precedence
      -- LSP servers are listed above, and are installed by mason-lspconfig; this is for linters & formatters.
      ensure_installed = {
        "djlint",
        "markdownlint",
        "prettierd",
        "rustywind",
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
}
