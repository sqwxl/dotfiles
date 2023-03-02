return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
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
  { "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "folke/neodev.nvim",
    config = true
  },
  { "simrat39/rust-tools.nvim" },
}
