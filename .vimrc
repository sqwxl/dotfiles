" Fish doesn't play all that well with others
set shell=/bin/bash
let mapleader = "\<Space>"

" =============================================================================
" # PLUGINS
" =============================================================================

" don't bother imitating vi
set nocompatible

call plug#begin(stdpath('data') . '/plugged')

" Vim enhancements
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" GUI
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'preservim/nerdtree'
Plug 'chriskempson/base16-vim'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
"Plug 'fatih/vim-go'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'

Plug 'alvan/vim-closetag'

call plug#end()

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua << END
local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

--Enable completion triggered by <C-x><C-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'm', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
buf_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
buf_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)

-- Forward to other plugins
require'completion'.on_attach(client)
end

local servers = { 
	"rust_analyzer",
	"gopls",
	"vimls",
	"bashls", 
	"rnix",
	"tsserver",
	"pylsp"
	}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
			}
		}
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	update_in_insert = true,
	}
)
END

if executable('rg')
	set grepprg=rg\ --vimgrep\ --smart-case
	set grepformat=%f:%l:%c:%m
endif

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

let g:closetag_filenames = '*.html,*.xhtml,*.gohtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,gohtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
			\ 'typescript.tsx': 'jsxRegion,tsxRegion',
			\ 'javascript.jsx': 'jsxRegion',
			\ 'typescriptreact': 'jsxRegion,tsxRegion',
			\ 'javascriptreact': 'jsxRegion',
			\ }
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

let g:sneak#s_next = 1
" =============================================================================
" # Editor settings
" =============================================================================


" syntax highlighting
syntax enable

filetype plugin indent on
set autoindent
set updatetime=300
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set completeopt=menu,noinsert,noselect
set shortmess+=c
set inccommand=nosplit
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait200-blinkoff125-blinkon150-Cursor/lCursor
set scrolloff=5
set hidden
set linebreak
set breakindent
set showbreak=\\\ 
set nojoinspaces
set printencoding=utf-8
set printoptions=paper:letter

set signcolumn=yes

set undodir=~/.vimdid
set undofile

" Use wide tabs
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Wrapping options
set formatoptions=tcrnbj " wrap text and comments using textwidth

set ignorecase
set smartcase
set gdefault

" undo breaks before deletes
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Centered search results
" nnoremap <silent> n nzz
" nnoremap <silent> N Nzz
" nnoremap <silent> * *zz
" nnoremap <silent> # #zz
" nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

set spelllang=en_us

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.
let g:obvious_resize_run_tmux = 1 " Enable Tmux resizing integration.

" fzf
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)

function! s:list_cmd()
	let base = fnamemodify(expand('%'), ':h:.:S')
	return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
			\                               'options': '--tiebreak=index'}, <bang>0)
"
" =============================================================================
" # GUI settings
" =============================================================================

set termguicolors
let g:airline_theme='base16_onedark'
colorscheme base16-onedark

set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set lazyredraw
set synmaxcol=500
set relativenumber " Relative line numbers
set number " Also show current absolute line
augroup numbertoggle " Toggle 'relativenumber' on insert.
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

set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals

set listchars=tab:→·,nbsp:·,extends:»,precedes:«,trail:~
let g:indentLine_char = '┊' " Use a small line to show space-based indentation.


" =============================================================================
" # Keyboard shortcuts
" =============================================================================

nnoremap ; :

noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

" Move fast
noremap H ^
noremap J }
noremap K {
noremap L $

" Move by line
nnoremap j gj
nnoremap k gk

noremap <C-J> <Esc>
noremap! <C-J> <Esc>
inoremap <C-J> <Esc>
lnoremap <C-J> <Esc>
tnoremap <C-J> <Esc>

tnoremap <Esc> <C-\><C-N>

noremap <C-H> :nohlsearch<CR>

noremap <C-Q> :confirm qall<CR>
noremap <leader>w :w<CR>

" X clipboard integration
set clipboard+=unnamedplus
" noremap <leader>y "+y
" noremap <leader>p "+p

" wordwise
noremap <leader>c ciw
noremap <leader>d diw
noremap <leader>v viw
noremap <leader>y yiw

" Open hotkeys
nnoremap <C-P> :Files<CR>
nnoremap <leader>; :Buffers<CR>
nnoremap <leader>s :Rg<CR>
" nnoremap <silent> <C-f> :Files<CR>
" nnoremap <silent> <Leader>f :Rg<CR>
" nnoremap <silent> <Leader>/ :BLines<CR>
" nnoremap <silent> <Leader>' :Marks<CR>
" nnoremap <silent> <Leader>g :Commits<CR>
" nnoremap <silent> <Leader>H :Helptags<CR>
" nnoremap <silent> <Leader>hh :History<CR>
" nnoremap <silent> <Leader>h: :History:<CR>
" nnoremap <silent> <Leader>h/ :History/<CR>

nnoremap Q @q

nnoremap Y y$

" Indenting
nmap >> <Nop>
nmap << <Nop>
vmap >> <Nop>
vmap << <Nop>

nnoremap <Tab>   >>
nnoremap <S-Tab> <<

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <C-^>

" windows
nnoremap <C-_> <C-w>n
nnoremap <C-\> :vnew<CR>

" shows/hides hidden characters
nnoremap <leader>, :set invlist<CR>

" shows stats
noremap <leader>i g<C-G>

nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>
" =============================================================================
" # Autocommands
" =============================================================================

" Prevent accidental writes to buffers that shouldn't be edited
" autocmd BufRead *.orig set readonly
" autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
	" https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
	au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Follow Rust code style rules
au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby

" =============================================================================
" # Footer
" =============================================================================

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif

