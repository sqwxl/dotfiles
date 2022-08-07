return require('packer').startup{
	function(use)
	use { 'wbthomason/packer.nvim' }

	use { 'lewis6991/impatient.nvim' }

	use { 'tpope/vim-surround' }

	use { 'tpope/vim-repeat' }

	use { 'andymass/vim-matchup' }

	use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

	use {
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup {
				check_ts = true,
				disable_in_macro = true
			}
		end
	}

	use { 'windwp/nvim-ts-autotag' }

	use {
		'ggandor/leap.nvim',
		config = function()
			require('leap').set_default_keymaps()
		end
	}

	use {
		'akinsho/toggleterm.nvim',
		config = function()
			require 'toggleterm'.setup {
				open_mapping = [[<leader>o]],
				shade_terminals = false
			}
		end
	}

	-- Git
	use { 'tpope/vim-fugitive', cmd = "Git" }

	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}

	use { 'folke/lua-dev.nvim' }

	-- Look
	use { "ellisonleao/gruvbox.nvim" }

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require 'lualine'.setup {
				tabline = {
					lualine_a = { 'buffers' },
					lualine_z = { 'tabs' }
				},
				sections = { lualine_c = { { 'filename', path = 1 } }, lualine_x = { 'filetype' } },
				extensions = { 'toggleterm', 'nvim-tree', 'fugitive' }
			}
		end
	}

	use {
		'lukas-reineke/indent-blankline.nvim',
		disable = true,
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
		'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-lua/plenary.nvim' },
		},
		setup = function() require 'config.telescope_setup' end,
		config = function() require 'config.telescope' end,
	}

	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'make',
	}
	use { "nvim-telescope/telescope-ui-select.nvim" }

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ":TSUpdate",
	}

	-- LSP
	use {
		'neovim/nvim-lspconfig',
	}

	use {
		'filipdutescu/renamer.nvim',
		branch = 'master',
		requires = { { 'nvim-lua/plenary.nvim' } },
		config = function() require 'renamer'.setup() end,
	}

	-- CMP
	use { 'L3MON4D3/LuaSnip'}
	use {
		'hrsh7th/nvim-cmp',
	}
	use { 'hrsh7th/cmp-nvim-lsp'}
	use { 'hrsh7th/cmp-nvim-lsp-signature-help'}
	use { 'hrsh7th/cmp-buffer'}
	use { 'hrsh7th/cmp-path'}
	use { 'hrsh7th/cmp-nvim-lua'}
	use { 'hrsh7th/cmp-cmdline'}
	use { 'saadparwaiz1/cmp_luasnip'}
	use { 'hrsh7th/cmp-nvim-lsp-document-symbol'}

	use {
		'simrat39/rust-tools.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
	}
end }
