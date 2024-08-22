return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      --   -- disable lsp watcher. Too slow on linux
      --   local ok, wf = pcall(require, "vim.lsp._watchfiles")
      --   if ok then
      --     wf._watchfunc = function()
      --       return function() end
      --     end
      --   end
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      keys[#keys + 1] = {
        "gV",
        function()
          require("telescope.builtin").lsp_definitions({ jump_type = "vsplit", reuse_win = true })
        end,
        desc = "Open definition in vsplit",
      }
      keys[#keys + 1] = { "<Leader>r", vim.lsp.buf.rename, desc = "Rename" }
    end,
    opts = {
      inlay_hints = { enabled = false },
      document_highlight = { enabled = false }, -- Enable LSP cursor word highlighting
      codelens = { enabled = false },
      diagnostics = { virtual_text = { prefix = "icons" } },
      servers = { -- servers included here get automatically installed by mason
        bashls = {},
        html = {
          filetypes = { "html", "htmldjango" },
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
        biome = {},
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
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    keys = {
      {
        "<leader>gG",
        function()
          require("lazyvim.util").terminal.open({ "gitui" }, { esc_esc = false, ctrl_hjkl = false })
        end,
        desc = "gitui (cwd)",
      },
      {
        "<leader>gg",
        function()
          require("lazyvim.util").terminal.open(
            { "gitui" },
            { cwd = require("lazyvim.util").root.get(), esc_esc = false, ctrl_hjkl = false }
          )
        end,
        desc = "gitui (root dir)",
      },
    },
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
