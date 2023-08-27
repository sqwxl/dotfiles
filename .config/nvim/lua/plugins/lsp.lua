return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = ":MasonUpdate",
      },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = false
  },

  -- use 'mfussenegger/nvim-dap'
  -- use { 'mfussenegger/nvim-dap-python',
  --   config = function()
  --     local debugpy_venv = "~/.virtualenvs/debugpy/bin/python"
  --     local f = io.open(debugpy_venv, "r")
  --     if f == nil then
  --       io.close(f)
  --       error(string.format("debugpy virtualenv not found at %s you have to create it", debugpy_venv))
  --     end
  --     require("dap-python").setup(debugpy_venv)
  --   end
  -- }

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup({
        debug = false,
        debounce = 150,
        save_after_format = false,
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.shfmt,
          -- null_ls.builtins.formatting.isort,
          -- null_ls.builtins.diagnostics.mypy
          null_ls.builtins.formatting.jq,
          -- null_ls.builtins.formatting.ruff,
          -- null_ls.builtins.diagnostics.ruff, --handled by lsp-zero
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.pint,
          null_ls.builtins.formatting.blade_formatter,
        },
        on_attach = function(client, bufnr)
          require("config.mappings").on_attach(client, bufnr)
          -- format-on-save
          -- if client.supports_method("textDocument/formatting") then
          --   vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          --   vim.api.nvim_create_autocmd("BufWritePre", {
          --     group = augroup,
          --     buffer = bufnr,
          --     callback = function()
          --       vim.lsp.buf.format({ bufnr = bufnr })
          --     end,
          --   })
          -- end
        end,
      })
    end
  },

  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-tree.lua" },
  },

  {
    "folke/neodev.nvim",
    opts = { library = { plugins = { "nvim-dap-ui" }, types = true } }
  },

  { "simrat39/rust-tools.nvim" },

  { "jwalton512/vim-blade" }, -- "blade" filetype support
}
