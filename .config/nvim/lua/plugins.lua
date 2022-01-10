local modules = {
  {'wbthomason/packer.nvim'},
  -- Speedup
  {'lewis6991/impatient.nvim'},
  {'nathom/filetype.nvim'},

  -- Enhancements
  {'lbrayner/vim-rzip', disable = true},
  {'tpope/vim-surround', event = "InsertEnter"},
  {'tpope/vim-repeat', envent = "InsertEnter"},
  {'andymass/vim-matchup'},
  {'ludovicchabant/vim-gutentags', disable = true},
  {'numToStr/Comment.nvim', config = function() require'Comment'.setup() end},
  {
    'windwp/nvim-autopairs',
    config = function() require'nvim-autopairs'.setup {check_ts = true, disable_in_macro = true} end
  },
  {'windwp/nvim-ts-autotag'},
  {
    'ggandor/lightspeed.nvim',
    after = "gruvbox",
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require'toggleterm'.setup {
        open_mapping = '<A-Space>',
        shade_terminals = false
      }
    end
  },
  {
    'kevinhwang91/nvim-bqf',
    keys = "<C-q>",
    ft = "qf",
    config = function()
      vim.api.nvim_set_keymap("n", "<C-q>", require"utils".toggle_qf, {silent = true})
    end
  },

  -- Git
  {'tpope/vim-fugitive', cmd = "Git"},
  {
    'TimUntersberger/neogit',
    requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
    keys = "<A-n>",
    config = function()
      require "neogit".setup {
        integrations = { diffview = true }
      }
      vim.api.nvim_set_keymap("n", "<A-n>", [[<cmd>Neogit<CR>]], {silent = true})
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      vim.schedule(function()
        require"gitsigns".setup()
      end)
    end
  },

  -- Look
  {'morhetz/gruvbox'},
  {'folke/lsp-colors.nvim'},
  {
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
  },
  {
    "akinsho/nvim-bufferline.lua",
    after = "gruvbox",
    config = function()
      require("bufferline").setup {
        options = {
          view = "multiwindow",
          numbers = function(opts)
            return opts.raise(opts.ordinal)
          end,
          tab_size = 18,
          show_buffer_close_icons = false,
          separator_style = "thin",
          enforce_regular_tabs = true,
        },
      }
      for i = 1, 9 do
        i = tostring(i)
        vim.api.nvim_set_keymap("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { silent = true })
      end
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.g.indent_blankline_show_current_context = true
      require'indent_blankline'.setup {
        filetype_exclude = {'help', 'packer'},
        buftype_exclude = {'terminal', 'nofile'},
        show_trailing_blankline_indent = false
      }
    end
  },

  -- Tools
  {
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
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
    config = function()
      require "config.telescope"
    end,
  },
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
  {'nvim-telescope/telescope-ui-select.nvim'},

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    requires = {
      {'nvim-treesitter/nvim-treesitter-textobjects'},
    },
    config = function()
      require 'config.treesitter'
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    requires = {
      {'ray-x/lsp_signature.nvim'},
      {'folke/lua-dev.nvim'},
      {
        'filipdutescu/renamer.nvim',
        branch = 'master',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = function ()
          require "renamer".setup()
        end
      }
    },
    config = function() require "config.lsp" end
  },

  -- CMP
  {
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
  },
  {
    'simrat39/rust-tools.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require "rust-tools".setup() end
  },
}

require "packer".startup {
  modules,
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
  }
}
--
-- vim.cmd 'source /home/nilueps/.config/nvim/vimscript/rzip.vim'
