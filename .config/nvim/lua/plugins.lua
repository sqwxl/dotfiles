local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_Bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
  use { 'wbthomason/packer.nvim' }
  -- Speedup
  use { 'lewis6991/impatient.nvim' }

  -- Enhancements
  use { 'lbrayner/vim-rzip', disable = true }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat' }
  use { 'andymass/vim-matchup' }
  use { 'numToStr/Comment.nvim', config = function() require 'Comment'.setup() end }
  use {
    'windwp/nvim-autopairs',
    config = function() require 'nvim-autopairs'.setup { check_ts = true, disable_in_macro = true } end
  }
  use { 'windwp/nvim-ts-autotag' }
  use {
    'ggandor/leap.nvim',
    config = function ()
      require("leap").set_default_keymaps()
     end
  }
  use {
    'akinsho/toggleterm.nvim',
    disable = true,
    config = function()
      require 'toggleterm'.setup {
        open_mapping = '<C-$>',
        shade_terminals = false
      }
    end
  }
  use {
    'kevinhwang91/nvim-bqf',
    disable = true,
    keys = "<C-;>",
    ft = "qf",
    config = function()
      vim.api.nvim_set_keymap("n", "<C-;>", require "utils".toggle_qf, { silent = true })
    end
  }

  -- Git
  use { 'tpope/vim-fugitive' }
  -- use {
  --   'TimUntersberger/neogit',
  --   disable = true,
  --   requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
  --   keys = "<A-n>",
  --   config = function()
  --     require "neogit".setup {
  --       integrations = { diffview = true }
  --     }
  --     vim.api.nvim_set_keymap("n", "<A-n>", [[<cmd>Neogit<CR>]], {silent = true})
  --   end
  -- }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  use 'folke/lua-dev.nvim'

  -- Look
  use { 'ellisonleao/gruvbox.nvim' }
  use { 'folke/lsp-colors.nvim' }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require 'lualine'.setup {
        options = { theme = 'gruvbox', globalstatus = true },
        sections = { lualine_c = { { 'filename', path = 1 } }, lualine_x = { 'filetype' } },
        extensions = { 'quickfix', 'toggleterm', 'nvim-tree', 'fugitive' }
      }
    end
  }
  use {
    'kdheepak/tabline.nvim',
    config = function()
      require'tabline'.setup {
      }
      vim.cmd[[
        set guioptions-=e " Use showtabline in gui vim
        set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]
    end,
    requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
  }
  use {
    "akinsho/bufferline.nvim",
    disable = true,
    config = function()
      require("bufferline").setup {
        options = {
          numbers = function(opts)
            return opts.ordinal
          end,
          tab_size = 18,
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = "thin",
          enforce_regular_tabs = true,
        },
      }
    end,
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    disable = true,
    config = function()
      vim.g.indent_blankline_show_current_context = true
      require 'indent_blankline'.setup {
        filetype_exclude = { 'help', 'packer' },
        buftype_exclude = { 'terminal', 'nofile' },
        show_trailing_blankline_indent = false
      }
      require("config.indentline")
    end
  }

  -- Tools
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      vim.g.nvim_tree_highlight_opened_files = 1
      require 'nvim-tree'.setup {
        hijack_cursor = true,
        diagnostics = { enable = true },
        view = { signcolumn = "yes" },
        renderer = {
          indent_markers = {
            enable = true
          }
        }
      }
    end
  }

  -- Telescope
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'telescope-fzf-native.nvim',
      },
      wants = {
        'plenary.nvim',
        'telescope-fzf-native.nvim',
      },
      setup = function() require 'config.telescope_setup' end,
      config = function() require 'config.telescope' end,
      cmd = 'Telescope',
      module = 'telescope',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
    },
    config = function ()
            require("config.treesitter")
    end,
    run = ":TSUpdate",
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    requires = {
      {
        'filipdutescu/renamer.nvim',
        branch = 'master',
        config = function() require 'renamer'.setup() end,
        requires = { { 'nvim-lua/plenary.nvim' } },
      }
    },
    config = function() require("config.lsp") end
  }

  -- CMP
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
    },
    config = function() require "config.cmp" end,
    event = 'InsertEnter *',
  }

  use {
    'simrat39/rust-tools.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require "rust-tools".setup() end
  }

  if Packer_Bootstrap then
    require('packer').sync()
  end
end)
