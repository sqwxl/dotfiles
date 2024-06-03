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
      diagnostics = { virtual_text = { prefix = "icons" } },
      servers = { -- servers included here get automatically installed via mason.nvim
        -- n.b. some servers are set up via lazyvim.plugins.extras.lang.*
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
        tsserver = {
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

  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        fish = { "fish_indent" },
        go = { "gofmt" },
        json = { "jq" },
        just = { "just" },
        lua = { "stylua" },
        cpp = { "clang-format" },
        markdown = { { "prettierd", "prettier" } },
        nix = { "alejandra" },
        php = { "pint" },
        sh = { "shfmt" },
        sql = { "sqlfmt" },
        toml = { "taplo" },
        yaml = { "yamlfix" },
        -- css
        css = { "prettierd" },
        scss = { "prettierd" },
        -- templating
        html = { "prettierd", "rustywind" },
        htmldjango = { "djlint", "rustywind" },
        -- js
        javascript = { "biome" },
        -- javascriptreact = { "eslint_d" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        xml = { "xmlformat" },
      },
      formatters = {
        sql_formatter = { prepend_args = { "--language=postgresql" } },
        sqlfmt = { prepend_args = { "-l", "120" } },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        css = { "stylelint" },
        sass = { "stylelint" },
        fish = { "fish" },
        markdown = { "markdownlint" },
        sh = { "shellcheck" },
        html = { "htmlhint" },
        htmldjango = { "djlint" },
        javascript = { "biomejs" },
        typescript = { "biomejs" },
        typescriptreact = { "biomejs" },
        sql = { "sqlfluff" },
      },
      linters = {
        sqlfluff = { args = { "lint", "--format=json", "--dialect=postgres" } },
        stylelint = {
          stream = "stderr",
        },
      },
    },
  },
}
