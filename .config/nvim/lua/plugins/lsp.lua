return {

  {
    "williamboman/mason.nvim",
    -- opts = {
    --   ensure_installed ={
    --     "black",
    --     "selene",
    --     'shellcheck',
    --     'shfmt',
    --     "stylua",
    --     "ruff",
    --     "sourcery",
    --   }
    -- }
  },

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
          vim.cmd("vsplit")
          vim.lsp.buf.definition()
        end,
        { desc = "Open definition in vsplit" },
      }
      keys[#keys + 1] = { "<Leader>r", vim.lsp.buf.rename, { desc = "Rename" } }
      keys[#keys + 1] = {
        "<A-F>",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        { desc = "Format document" },
      }
    end,
    opts = {
      inlay_hints = { enabled = vim.fn.has("nvim-0.10") },
      diagnostics = { virtual_text = { prefix = "icons" } },
      servers = {
        bashls = {},
        clangd = {},
        cssls = {},
        dockerls = {},
        pyright = {},
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
                "E501", -- ignore line length (gets autoformatted w/ black)
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
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.tbl_deep_extend("force", opts or {}, {
        debug = false,
        debounce = 150,
        save_after_format = false,
        sources = {
          nls.builtins.formatting.black,
          nls.builtins.formatting.shfmt,
          -- nls.builtins.formatting.isort,
          -- nls.builtins.diagnostics.mypy
          nls.builtins.formatting.jq,
          nls.builtins.formatting.ruff,
          nls.builtins.diagnostics.ruff, --handled by lsp-zero
          nls.builtins.code_actions.eslint_d,
          nls.builtins.diagnostics.eslint_d,
          nls.builtins.formatting.eslint_d,
          nls.builtins.formatting.prettier.with({ filetypes = { "markdown" } }),
          nls.builtins.diagnostics.markdownlint,
          nls.builtins.formatting.pint,
          nls.builtins.formatting.blade_formatter,
        },
      })
    end,
  },

  -- {
  --   "antosha417/nvim-lsp-file-operations",
  --   dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-tree.lua" },
  -- },

  {
    "simrat39/rust-tools.nvim",
    opts = {
      tools = {
        -- nvim >= 0.10 has native inlay hint support
        inlay_hints = { auto = not vim.fn.has("nvim-0.10") },
      },
      server = {
        settings = {
          rust_analyzer = {
            check = {
              command = "clippy",
              -- extraArgs = { "--workspace", "--", "-W", "clippy::all" },
            },
          },
        },
      },
    },
  },

  -- { "jwalton512/vim-blade" }, -- "blade" filetype support
}
