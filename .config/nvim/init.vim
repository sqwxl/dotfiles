call plug#begin(stdpath('data') . '/plugged')
	" Enhancements
  Plug 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
	Plug 'justinmk/vim-sneak'
    let g:sneak#s_next = 1
	Plug 'andymass/vim-matchup'
	" Plug 'tpope/vim-sleuth'
	Plug 'szw/vim-maximizer'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tpope/vim-fugitive'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'airblade/vim-rooter'
	Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 200
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  Plug 'folke/trouble.nvim'

  " Look & feel
	Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'
    let g:webdevicons_conceal_nerdtree_brackets = 1
  Plug 'RRethy/nvim-base16'
  Plug 'folke/lsp-colors.nvim'
  if !exists('g:started_by_firenvim')
    Plug 'vim-airline/vim-airline'
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tmuxline#enabled = 1
      let g:airline_powerline_fonts = 1
    Plug 'vim-airline/vim-airline-themes'
      let g:airline_theme = 'base16_default_dark'
    Plug 'edkolev/tmuxline.vim'
  end

  " Editing
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'sbdchd/neoformat'

  " Tools
	Plug 'kassio/neoterm'
    let g:neoterm_default_mod = 'vertical'
    let g:neoterm_size = 80
    let g:neoterm_autoinsert = 1
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-telescope/telescope.nvim'
  Plug 'preservim/nerdtree'

	" Semantic language support
	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
	Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp_extensions.nvim'

	" Syntactic language support
	Plug 'pangloss/vim-javascript'
	Plug 'cespare/vim-toml'
	Plug 'stephpy/vim-yaml'
	Plug 'dag/vim-fish'
  Plug 'plasticboy/vim-markdown'
	Plug 'rust-lang/rust.vim'
    let g:rustfmt_autosave = 1
    let g:rustfmt_emit_files = 1
    let g:rustfmt_fail_silently = 0
    let g:rust_clip_command = 'xclip -selection clipboard'

	" Debugging
	Plug 'mfussenegger/nvim-dap'

call plug#end()

let g:netrw_banner=0

" =============================================================================
" # Basics
" =============================================================================

" don't bother imitating vi
set nocompatible
filetype plugin indent on

" Fish doesn't play all that well with others
" set shell=/bin/bash

set termguicolors
colorscheme base16-default-dark

syntax enable
set synmaxcol=500

set mouse=a " Enable mouse usage (all modes) in terminals

set ignorecase
set smartcase
set incsearch
set gdefault

set spelllang=en_us

set completeopt=menu,menuone,noinsert,noselect
set shortmess+=c

set relativenumber
set number " Also show current absolute line

set splitright " Open vertical splits to the right
set splitbelow " Open horizontal splits below

set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

set linebreak
set showbreak=\\\ 
set breakindent
set nojoinspaces
set backspace=2 " Backspace over newlines

if exists('g:started_by_firenvim')
  set laststatus=0
else
  set laststatus=2
endif

set cmdheight=1
set showcmd " Show (partial) command in status line.
set inccommand=nosplit
set noshowmode " We have airline for that

set updatetime=100
set timeoutlen=250
set lazyredraw

set diffopt+=vertical

set guioptions-=T " Remove toolbar
set guifont=JetBrainsMono_Nerd_Font_Mono:h10
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait200-blinkoff125-blinkon150-Cursor/lCursor

set scrolloff=2
set hidden
set colorcolumn=120 " and give me a colored column

set encoding=UTF-8
set printencoding=UTF-8
set printoptions=paper:letter
set signcolumn=yes

set undodir=~/.vimdid
set undofile

set listchars=tab:→·,nbsp:·,extends:»,precedes:«,trail:~

set clipboard+=unnamedplus

if executable('rg')
	set grepprg=rg\ --vimgrep\ --smart-case
	set grepformat=%f:%l:%c:%m
endif

let mapleader = " "

" =============================================================================
" # Autocommands
" =============================================================================
"
 " Toggle 'relativenumber' on insert.
augroup numbertoggle
	autocmd!
	autocmd InsertEnter,BufLeave,WinLeave,FocusLost * nested
				\ if &l:number && empty(&buftype) |
				\ setlocal norelativenumber |
				\ endif
	autocmd InsertLeave,BufEnter,WinEnter,FocusGained * nested
				\ if &l:number && mode() != 'i' && empty(&buftype) |
				\ setlocal relativenumber |
				\ endif
augroup END

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

" Jump to last edit position on opening file
autocmd BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Follow Rust code style rules
autocmd Filetype rust source ~/.config/nvim/scripts/spacetab.vim
autocmd Filetype rust set colorcolumn=100

" =============================================================================
" # Keyboard shortcuts
" =============================================================================

nnoremap ; :

" undo breaks before deletes
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

nnoremap Y y$

" Move fast
noremap H ^
noremap L $

" Move by line
nnoremap j gj
nnoremap k gk
" nnoremap <expr> j v:count ? 'j' : 'gj'
" nnoremap <expr> k v:count ? 'k' : 'gk'

nnoremap Q @q

noremap aj <Esc>
noremap! aj <Esc>
inoremap aj <Esc>
lnoremap aj <Esc>
tnoremap aj <Esc>

tnoremap <Esc> <C-\><C-n>

noremap <leader>w :w<CR>

noremap <leader>m :MaximizerToggle!<CR>

noremap <leader>t :NERDTreeToggle<CR>

" wordwise edit
noremap <leader>c ciw
noremap <leader>d diw
noremap <leader>y yiw
noremap <leader>v viw

" Open hotkeys
nnoremap <C-q> :Ttoggle<CR>
inoremap <C-q> <Esc>:Ttoggle<CR>
tnoremap <C-q> <C-\><C-n>:Ttoggle<CR>

nnoremap <leader>F :Neoformat prettier<CR>


nnoremap <Tab>   >>
nnoremap <S-Tab> <<

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" <leader><leader> toggles between buffers
nnoremap <leader><leader> <C-^>

" shows/hides hidden characters
nnoremap <leader>, :set invlist<CR>

" shows stats
noremap <leader>i g<C-g>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" =============================================================================
" # Lua configs
" =============================================================================

lua << EOF
  -- require'trouble'.setup()
  -- require'gitsigns'.setup()
  -- Integrate vim-matchup with treesitter
  require'nvim-treesitter.configs'.setup {
    matchup = {
      enable = true,
    },
  }

  require'telescope'.setup {
    defaults = {
      initial_mode = 'normal'
      },
    }
  
  local lspconfig = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <C-x><C-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  end

  local servers = { 
    "rust_analyzer",
    "gopls",
    "vimls",
    "bashls", 
    "tsserver",
    "pylsp",
    "rnix",
    }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
        }
      }
  end
EOF
