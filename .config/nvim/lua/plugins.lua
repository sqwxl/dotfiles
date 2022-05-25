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


return require('packer').startup(
  function(use)
    local function use_cond(args)
      if type(args) == 'string' then
        args = {
          args
        }
      end

      args["cond"] = function()
        return not vim.g.vscode
      end

      use(args)
    end

    use { 'wbthomason/packer.nvim' }

    use { 'lewis6991/impatient.nvim' }

    use_cond { 'nathom/filetype.nvim', disable = true }

    use { 'lbrayner/vim-rzip', disable = true }

    use { 'tpope/vim-surround' }

    use { 'tpope/vim-repeat' }

    use { 'andymass/vim-matchup' }

    use { 'ludovicchabant/vim-gutentags', disable = true }

    use_cond { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

    use_cond {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup {
          check_ts = true,
          disable_in_macro = true
        }
      end
    }

    use_cond { 'windwp/nvim-ts-autotag' }

    use_cond {
      'ggandor/leap.nvim',
      config = function()
        require('leap').set_default_keymaps()
      end
    }

    use_cond {
      'akinsho/toggleterm.nvim',
      config = function()
        require 'toggleterm'.setup {
          open_mapping = [[<leader>o]],
          shade_terminals = false
        }
      end
    }

    use_cond {
      'kevinhwang91/nvim-bqf',
      disable = true,
      keys = "<C-;>",
      ft = "qf",
      config = function()
        vim.api.nvim_set_keymap("n", "<C-;>", require "utils".toggle_qf, { silent = true })
      end
    }

    -- Git
    use_cond { 'tpope/vim-fugitive', cmd = "Git" }

    use_cond {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }

    use_cond { 'folke/lua-dev.nvim' }

    -- Look
    use_cond { "ellisonleao/gruvbox.nvim" }

    use_cond { 'folke/lsp-colors.nvim' }

    use_cond {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require 'lualine'.setup {
          tabline = {
            lualine_a = { 'buffers' },
            lualine_z = { 'tabs' }
          },
          -- sections = { lualine_c = { { 'filename', path = 1 } }, lualine_x = { 'filetype' } },
          extensions = { 'quickfix', 'toggleterm', 'nvim-tree', 'fugitive' }
        }
      end
    }

    use_cond {
      "akinsho/bufferline.nvim",
      disable = true,
      tag = "v2.*",
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require("bufferline").setup {
          options = {
            numbers = "none",
            diagnostics = "nvim-lsp",
            tab_size = 18,
            show_close_icon = false,
            show_buffer_close_icons = false,
            separator_style = "thin",
            enforce_regular_tabs = false,
          },
        }
      end,
    }

    use_cond {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup {
          show_current_context = true,
          show_current_context_start = true,
          filetype_exclude = { 'help', 'packer' },
          buftype_exclude = { 'terminal', 'nofile' },
          show_trailing_blankline_indent = false,
        }
        require('config.indentline')
      end
    }

    -- Tools
    use_cond {
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
    use_cond {
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/plenary.nvim' },
      },
      setup = function() require 'config.telescope_setup' end,
      config = function() require 'config.telescope' end,
    }

    use_cond {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      config = function()
        require("telescope").load_extension("fzf")
      end
    }

    -- Treesitter
    use_cond {
      'nvim-treesitter/nvim-treesitter',
      run = ":TSUpdate",
      config = function()
        require('config.treesitter')
      end
    }

    -- LSP
    use_cond {
      'neovim/nvim-lspconfig',
      config = function()
        require('config.lsp')
      end
    }

    use_cond {
      'filipdutescu/renamer.nvim',
      branch = 'master',
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function() require 'renamer'.setup() end,
    }

    -- CMP
    use_cond {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'L3MON4D3/LuaSnip', after =  "nvim-cmp" },
        { 'hrsh7th/cmp-nvim-lsp', after = "nvim-cmp" },
        { 'hrsh7th/cmp-nvim-lsp-signature-help', after = "nvim-cmp" },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
      },
      config = function() require "config.cmp" end,
      -- event = 'InsertEnter *',
    }

    use_cond {
      'simrat39/rust-tools.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function() require "rust-tools".setup() end
    }


    if Packer_Bootstrap then
      require('packer').sync()
    end

  end)
