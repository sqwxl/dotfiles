local packer = nil

local function init()
  if packer == nil then
    packer = require "packer"
    packer.init { disable_commands = true }
  end

  local use = packer.use
  packer.reset()

  use {'wbthomason/packer.nvim'}
  -- Speedup
  use {'lewis6991/impatient.nvim'}
  use {'nathom/filetype.nvim'}

  -- Enhancements
  use {'lbrayner/vim-rzip', disable = true}
  use {'tpope/vim-surround', event = "InsertEnter"}
  use {'tpope/vim-repeat', envent = "InsertEnter"}
  use {'andymass/vim-matchup'}
  use {'ludovicchabant/vim-gutentags', disable = true}
  use {'numToStr/Comment.nvim', config = function() require'Comment'.setup() end}
  use {
    'windwp/nvim-autopairs',
    config = function() require'nvim-autopairs'.setup {check_ts = true, disable_in_macro = true} end
  }
  use {'windwp/nvim-ts-autotag'}
  use {
    'ggandor/lightspeed.nvim',
    after = "gruvbox",
  }
  use {
    'akinsho/toggleterm.nvim',
    disable = true,
    config = function()
      require'toggleterm'.setup {
        open_mapping = '<A-Space>',
        shade_terminals = false
      }
    end
  }
  use {
    'kevinhwang91/nvim-bqf',
    disable = true,
    keys = "<C-q>",
    ft = "qf",
    config = function()
      vim.api.nvim_set_keymap("n", "<C-q>", require"utils".toggle_qf, {silent = true})
    end
  }

  -- Git
  use {'tpope/vim-fugitive', cmd = "Git"}
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

  -- Look
  use {'morhetz/gruvbox'}
  use {'folke/lsp-colors.nvim'}
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require'lualine'.setup {
        -- tabline = {lualine_a = {'buffers'}, lualine_z = {'tabs'}},
        sections = {lualine_c = {{'filename', path = 1}}, lualine_x = {'filetype'}},
        inactive_sections = {lualine_x = {}},
        extensions = {'quickfix', 'toggleterm', 'nvim-tree'}
      }
    end
  }

  use {
    "akinsho/bufferline.nvim",
    after = "gruvbox",
    config = function()
      require("bufferline").setup {
        options = {
          numbers = function(opts)
            return opts.ordinal
          end,
          tab_size = 18,
          show_buffer_close_icons = true,
          show_close_icon = false,
          separator_style = "thin",
          enforce_regular_tabs = true,
        },
      }
    end,
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.g.indent_blankline_show_current_context = true
      require'indent_blankline'.setup {
        filetype_exclude = {'help', 'packer'},
        buftype_exclude = {'terminal', 'nofile'},
        show_trailing_blankline_indent = false
      }
    end
  }

  -- Tools
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      vim.g.nvim_tree_indent_markers = 1
      vim.g.nvim_tree_highlight_opened_files = 1
      require'nvim-tree'.setup {
        hijack_cursor = true,
        diagnostics = {enable = true},
        view = {signcolumn = "yes"}
      }
    end
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
    config = function()
      require "config.telescope"
    end,
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'nvim-telescope/telescope-ui-select.nvim'}

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    requires = {
      {'nvim-treesitter/nvim-treesitter-textobjects'},
    },
    config = function()
      require 'config.treesitter'
    end,
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    requires = {
      {'ray-x/lsp_signature.nvim'},
      {'folke/lua-dev.nvim'},
      {
        'filipdutescu/renamer.nvim',
        branch = 'master',
        requires = { {'nvim-lua/plenary.nvim'} },
      }
    },
    config = function() require "config.lsp" end
  }

  -- CMP
  use {
    'hrsh7th/nvim-cmp',
    after = "gruvbox",
    requires = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'hrsh7th/cmp-vsnip'},
      {'hrsh7th/vim-vsnip'},
    },
    config = function ()
      require "config.cmp"
    end
  }
  use {
    'simrat39/rust-tools.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require "rust-tools".setup() end
  }
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
-- require "packer".startup {
--   modules,
--   config = {
--     compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
--   }
-- }
--
-- vim.cmd 'source /home/nilueps/.config/nvim/vimscript/rzip.vim'
