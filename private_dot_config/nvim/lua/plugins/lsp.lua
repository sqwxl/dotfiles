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
      codelens = { enabled = false },
      diagnostics = { virtual_text = { prefix = "icons" } },
      servers = { -- servers included here get automatically installed by mason
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
        biome = {},
        harper_ls = {
          settings = {
            ["harper-ls"] = {
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
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "append",
      ensure_installed = { -- lsp servers are listed above, this is for other linters & formatters
        "djlint",
        "markdownlint",
        "stylua",
        "rustywind",
        "ruff",
        "basedpyright",
        "shellcheck",
        "shfmt",
      },
    },
  },
}
