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
      inlay_hints = { enabled = vim.fn.has("nvim-0.10") },
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
        ruff_lsp = {
          init_options = {
            settings = {
              args = {
                "--ignore",
                "E501", -- line length
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
        "gitui",
        "markdownlint",
        "stylua",
        "rustywind",
        "ruff",
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
        python = { "ruff_format" },
        sh = { "shfmt" },
        sql = { "sqlfmt" },
        toml = { "taplo" },
        yaml = { "yamlfix" },
        -- css
        css = { "prettierd" },
        scss = { "prettierd" },
        sass = { "stylelint" },
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
        fish = { "fish" },
        markdown = { "markdownlint" },
        sh = { "shellcheck" },
        htmldjango = { "djlint" },
        javascript = { "biomejs" },
        typescript = { "biomejs" },
        typescriptreact = { "biomejs" },
        sql = { "sqlfluff" },
      },
      linters = {
        sqlfluff = { args = { "lint", "--format=json", "--dialect=postgres" } },
      },
    },
    -- opts = {
    --   linters_by_ft = {
    --     fish = { "fish" },
    --     go = { "golangci-lint" },
    --     html = { "tidy" },
    --     json = { "jsonlint" },
    --     -- lua = { "luacheck", "selene" },
    --     markdown = { "markdownlint" },
    --     nix = { "nix" },
    --     php = { "php", "phpcs", "phpstan" },
    --     python = {
    --       "bandit",
    --       -- "ruff",
    --     },
    --     sh = { "shfmt", "shellcheck" },
    --     yaml = { "yamllint" },
    --     -- css
    --     css = { "stylelint" },
    --     scss = { "stylelint" },
    --     sass = { "stylelint" },
    --     -- templating
    --     htmldjango = { "djlint" },
    --     jinja = { "djlint" },
    --     -- js
    --     -- javascript = { "eslint_d" },
    --     -- javascriptreact = { "eslint_d" },
    --     -- typescript = { "eslint_d" },
    --     -- typescriptreact = { "eslint_d" },
    --   },
    -- },
  },

  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     vim.tbl_deep_extend("force", opts or {}, {
  --       debug = false,
  --       debounce = 150,
  --       save_after_format = false,
  --       sources = {
  --         nls.builtins.formatting.black,
  --         nls.builtins.formatting.shfmt,
  --         nls.builtins.diagnostics.shellcheck,
  --         nls.builtins.code_actions.shellcheck,
  --         -- nls.builtins.formatting.isort,
  --         -- nls.builtins.diagnostics.mypy
  --         nls.builtins.formatting.jq,
  --         nls.builtins.formatting.ruff,
  --         nls.builtins.diagnostics.ruff, --handled by lsp-zero
  --         nls.builtins.code_actions.eslint_d,
  --         nls.builtins.diagnostics.eslint_d,
  --         nls.builtins.formatting.eslint_d,
  --         nls.builtins.formatting.prettier.with({ filetypes = { "markdown" } }),
  --         nls.builtins.diagnostics.markdownlint,
  --         nls.builtins.formatting.pint,
  --         nls.builtins.formatting.blade_formatter,
  --       },
  --     })
  --   end,
  -- },

  -- {
  --   "antosha417/nvim-lsp-file-operations",
  --   dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-tree.lua" },
  -- },

  -- { "jwalton512/vim-blade" }, -- "blade" filetype support
}
