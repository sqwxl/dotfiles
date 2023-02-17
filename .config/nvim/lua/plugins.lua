local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require("packer")

packer.init {
  compile_path = vim.fn.stdpath('config') .. "/lua/packer_compiled.lua"
}

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-endwise"
  use "tpope/vim-abolish"
  use "tpope/vim-fugitive"

  use {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end
  }

  use {
    "github/copilot.vim",
    disable = true,
    config = function()
      vim.g.copilot_no_tab_map = true
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  }

  use "ellisonleao/gruvbox.nvim"


  use {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  }

  use {
    'antosha417/nvim-lsp-file-operations',
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "kyazdani42/nvim-tree.lua" },
    },
    config = function() require("lsp-file-operations") end,
  }

  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {
        check_ts = true
      }
    end,
  }

  use {
    "j-hui/fidget.nvim",
    config = function() require("fidget").setup() end,
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
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
    }
  }

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

  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function() require("trouble").setup() end
  }

  use "jose-elias-alvarez/null-ls.nvim"


  use "nvim-lua/popup.nvim"


  use "nvim-lua/plenary.nvim"


  use "nvim-telescope/telescope.nvim"


  use "simrat39/rust-tools.nvim"


  use 'eandrju/cellular-automaton.nvim'

  if packer_bootstrap then
    require("packer").sync()
    return
  end
end)
