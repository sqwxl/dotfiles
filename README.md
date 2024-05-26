# new setup

```fish
git init --bare $HOME/.dotfiles
echo 'alias cfg "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' >> $HOME/.config/fish/config.fish
source $HOME/.config/fish/config.fish
cfg config --local status.showUntrackedFiles no
```

# clone on new system

```fish
git clone --bare https://github.com/sqwxl/dotfiles.git $HOME/.dotfiles

alias cfg "git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

source $HOME/.config/fish/config.fish

cfg checkout
if test $status -ne 0
  echo "Backing up pre-existing dotfiles to .config-backup"
  mkdir -p .config-backup
  cfg checkout 2>&1 | grep -E "\s+\." | string trim | xargs -I{} fish -c "cp --parents {} .config-backup/ && rm -rf {}"
  cfg checkout
end
cfg config --local status.showUntrackedFiles no
```

# dotfiles/.config/nvim

<a href="https://dotfyle.com/sqwxl/dotfiles-config-nvim"><img src="https://dotfyle.com/sqwxl/dotfiles-config-nvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/sqwxl/dotfiles-config-nvim"><img src="https://dotfyle.com/sqwxl/dotfiles-config-nvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/sqwxl/dotfiles-config-nvim"><img src="https://dotfyle.com/sqwxl/dotfiles-config-nvim/badges/plugin-manager?style=flat" /></a>


## Install Instructions

 > Install requires Neovim 0.9+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:sqwxl/dotfiles ~/.config/sqwxl/dotfiles
```

Open Neovim with this config:

```sh
NVIM_APPNAME=sqwxl/dotfiles/.config/nvim nvim
```

## Plugins

### ai

+ [sourcegraph/sg.nvim](https://dotfyle.com/plugins/sourcegraph/sg.nvim)
### bars-and-lines

+ [SmiteshP/nvim-navic](https://dotfyle.com/plugins/SmiteshP/nvim-navic)
### colorscheme

+ [catppuccin/nvim](https://dotfyle.com/plugins/catppuccin/nvim)
+ [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)
### comment

+ [echasnovski/mini.comment](https://dotfyle.com/plugins/echasnovski/mini.comment)
+ [danymat/neogen](https://dotfyle.com/plugins/danymat/neogen)
+ [numToStr/Comment.nvim](https://dotfyle.com/plugins/numToStr/Comment.nvim)
### completion

+ [hrsh7th/nvim-cmp](https://dotfyle.com/plugins/hrsh7th/nvim-cmp)
### cursorline

+ [RRethy/vim-illuminate](https://dotfyle.com/plugins/RRethy/vim-illuminate)
### debugging

+ [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)
+ [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
+ [theHamsta/nvim-dap-virtual-text](https://dotfyle.com/plugins/theHamsta/nvim-dap-virtual-text)
### diagnostics

+ [folke/trouble.nvim](https://dotfyle.com/plugins/folke/trouble.nvim)
### editing-support

+ [echasnovski/mini.ai](https://dotfyle.com/plugins/echasnovski/mini.ai)
+ [folke/zen-mode.nvim](https://dotfyle.com/plugins/folke/zen-mode.nvim)
+ [Wansmer/treesj](https://dotfyle.com/plugins/Wansmer/treesj)
+ [cshuaimin/ssr.nvim](https://dotfyle.com/plugins/cshuaimin/ssr.nvim)
+ [windwp/nvim-autopairs](https://dotfyle.com/plugins/windwp/nvim-autopairs)
+ [echasnovski/mini.pairs](https://dotfyle.com/plugins/echasnovski/mini.pairs)
### file-explorer

+ [nvim-neo-tree/neo-tree.nvim](https://dotfyle.com/plugins/nvim-neo-tree/neo-tree.nvim)
+ [kyazdani42/nvim-tree.lua](https://dotfyle.com/plugins/kyazdani42/nvim-tree.lua)
### formatting

+ [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)
### fuzzy-finder

+ [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
### indent

+ [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)
+ [echasnovski/mini.indentscope](https://dotfyle.com/plugins/echasnovski/mini.indentscope)
### keybinding

+ [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)
### lsp

+ [simrat39/symbols-outline.nvim](https://dotfyle.com/plugins/simrat39/symbols-outline.nvim)
+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
+ [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
+ [nvimtools/none-ls.nvim](https://dotfyle.com/plugins/nvimtools/none-ls.nvim)
### lsp-installer

+ [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)
### lua-colorscheme

+ [ellisonleao/gruvbox.nvim](https://dotfyle.com/plugins/ellisonleao/gruvbox.nvim)
### markdown-and-latex

+ [iamcco/markdown-preview.nvim](https://dotfyle.com/plugins/iamcco/markdown-preview.nvim)
### motion

+ [folke/flash.nvim](https://dotfyle.com/plugins/folke/flash.nvim)
### note-taking

+ [nvim-neorg/neorg](https://dotfyle.com/plugins/nvim-neorg/neorg)
### nvim-dev

+ [anuvyklack/animation.nvim](https://dotfyle.com/plugins/anuvyklack/animation.nvim)
+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
### preconfigured

+ [LazyVim/LazyVim](https://dotfyle.com/plugins/LazyVim/LazyVim)
### scrollbar

+ [petertriho/nvim-scrollbar](https://dotfyle.com/plugins/petertriho/nvim-scrollbar)
### session

+ [rmagatti/auto-session](https://dotfyle.com/plugins/rmagatti/auto-session)
### split-and-window

+ [anuvyklack/windows.nvim](https://dotfyle.com/plugins/anuvyklack/windows.nvim)
### startup

+ [goolord/alpha-nvim](https://dotfyle.com/plugins/goolord/alpha-nvim)
### statusline

+ [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)
### syntax

+ [echasnovski/mini.surround](https://dotfyle.com/plugins/echasnovski/mini.surround)
+ [kylechui/nvim-surround](https://dotfyle.com/plugins/kylechui/nvim-surround)
+ [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
### tabline

+ [akinsho/bufferline.nvim](https://dotfyle.com/plugins/akinsho/bufferline.nvim)
### utility

+ [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
+ [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
## Language Servers

+ html
+ taplo


 This readme was generated by [Dotfyle](https://dotfyle.com)
