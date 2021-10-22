call plug#begin(stdpath('data') . '/plugged')
	" Enhancements
  Plug 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
	Plug 'justinmk/vim-sneak' " https://github.com/justinmk/vim-sneak
    let g:sneak#s_next = 1
	Plug 'andymass/vim-matchup' " https://github.com/andymass/vim-matchup
	Plug 'tpope/vim-repeat' " https://github.com/tpope/vim-repeat
	Plug 'tpope/vim-sleuth'
	Plug 'szw/vim-maximizer'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter' " https://github.com/airblade/vim-gitgutter
  Plug 'airblade/vim-rooter' " https://github.com/airblade/vim-rooter
	Plug 'machakann/vim-highlightedyank'

  " Editing
	Plug 'tpope/vim-commentary' " https://github.com/tpope/vim-commentary
	Plug 'tpope/vim-surround' " https://github.com/tpope/vim-surround
	Plug 'sbdchd/neoformat' " https://github.com/sbdchd/neoformat

  " Tools
	Plug 'kassio/neoterm'
    let g:neoterm_default_mod = 'vertical'
    let g:neoterm_size = 80
    let g:neoterm_autoinsert = 1
	Plug 'vim-airline/vim-airline' " https://github.com/vim-airline/vim-airline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-telescope/telescope.nvim' " https://github.com/nvim-telescope/telescope.nvim
  Plug 'ms-jpq/chadtree', { 'branch': 'chad', 'do': 'python3 -m chadtree deps' }

  " Look & feel
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'chriskempson/base16-vim'
	Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='base16_default_dark'
	" Semantic language support
	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
	Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp_extensions.nvim'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    let g:coq_settings = { 'auto_start': v:true }

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

" don't bother imitating vi
set nocompatible
filetype plugin indent on

" Fish doesn't play all that well with others
" set shell=/bin/bash

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

set cmdheight=1
set showcmd " Show (partial) command in status line.
set noshowmode " We have airline for that

set updatetime=500
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set lazyredraw

set diffopt+=vertical

set termguicolors
set inccommand=nosplit
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait200-blinkoff125-blinkon150-Cursor/lCursor

set scrolloff=2
set hidden
set colorcolumn=120 " and give me a colored column

set encoding=utf-8
set printencoding=utf-8
set printoptions=paper:letter
set signcolumn=yes

set undodir=~/.vimdid
set undofile

" Wrapping options
" set formatoptions=tcrnbj " wrap text and comments using textwidth

set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps

set listchars=tab:→·,nbsp:·,extends:»,precedes:«,trail:~
" X clipboard integration
set clipboard+=unnamedplus

if executable('rg')
	set grepprg=rg\ --vimgrep\ --smart-case
	set grepformat=%f:%l:%c:%m
endif


let mapleader = " "

" =============================================================================

lua << EOF
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

-- Integrate vim-matchup with treesitter
require'nvim-treesitter.configs'.setup {
  matchup = {
    enable = true,
  },
}

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

" =============================================================================


" =============================================================================
" # Keyboard shortcuts
" =============================================================================

nnoremap ; :

" undo breaks before deletes
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

" Move fast
noremap H ^
noremap L $

" Move by line
nnoremap j gj
nnoremap k gk
" nnoremap <expr> j v:count ? 'j' : 'gj'
" nnoremap <expr> k v:count ? 'k' : 'gk'

nnoremap Q @q

noremap <C-J> <Esc>
noremap! <C-J> <Esc>
inoremap <C-J> <Esc>
lnoremap <C-J> <Esc>
tnoremap <C-J> <Esc>

tnoremap <Esc> <C-\><C-N>

noremap <leader>w :w<CR>
noremap <leader>v :e $MYVIMRC<CR>
noremap <leader>m :MaximizerToggle!<CR>
noremap <leader>t :CHADopen<CR>

" wordwise
noremap <leader>c ciw
noremap <leader>d diw
noremap <leader>y yiw

" Open hotkeys
nnoremap <C-Q> :Ttoggle<CR>
inoremap <C-Q> <Esc>:Ttoggle<CR>
tnoremap <C-Q> <C-\><C-N>:Ttoggle<CR>

nnoremap <leader>F :Neoformat prettier<CR>

nnoremap Y y$

nnoremap <Tab>   >>
nnoremap <S-Tab> <<

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"


" <leader><leader> toggles between buffers
nnoremap <leader><leader> <C-^>

" shows/hides hidden characters
nnoremap <leader>, :set invlist<CR>

" shows stats
noremap <leader>i g<C-G>

nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
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

