-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require 'packer'.use

require 'packer'.startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  -- Enhancements
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'andymass/vim-matchup'
  use 'ludovicchabant/vim-gutentags'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require 'Comment'.setup()
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'nvim-autopairs'.setup {
        check_ts = true,
        disable_in_macro = true,
      }
    end
  }

  use 'windwp/nvim-ts-autotag'

  use 'ggandor/lightspeed.nvim'
  -- use 'github/copilot.vim'

  -- Look & fel
  use 'morhetz/gruvbox'
  use 'folke/lsp-colors.nvim'

  -- Tools
  use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function() require 'nvim-tree'.setup {
          hijack_cursor = true,
          diagnostics = {
            enable = true,
          },
          view = {
            signcolumn = "no",
          },
        }
      end
  }

  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require 'lualine'.setup {
        tabline = {
          lualine_a = {
            'buffers'
          }
        },
        sections = {
          lualine_c = {
            {
              'filename',
              path = 1,
            }
          },
          lualine_x = { 'filetype' },
        },
        inactive_sections = { lualine_x = {} },
        extensions = { 'quickfix', 'toggleterm', 'nvim-tree' },
      }
    end
  }

  use {
    'akinsho/toggleterm.nvim',
    config = function ()
      require 'toggleterm'.setup {
        open_mapping = '<A-Space>',
        shade_terminals = false,
      }
    end
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'indent_blankline'.setup {
        filetype_exclude = { 'help', 'packer' },
        buftype_exclude = { 'terminal', 'nofile' },
        show_trailing_blankline_indent = false,
      }
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'gitsigns'.setup {
        signs = {
          add = { hl = 'GitGutterAdd', text = '+' },
          change = { hl = 'GitGutterChange', text = '~' },
          delete = { hl = 'GitGutterDelete', text = '_' },
          topdelete = { hl = 'GitGutterDelete', text = '‾' },
          changedelete = { hl = 'GitGutterChange', text = '~' },
        },
      }
    end
  }

  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use 'simrat39/rust-tools.nvim'

end)

require 'config.telescope'
require 'config.treesitter'
-- require 'config.autopairs'
require 'config.lsp'
