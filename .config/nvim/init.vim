" ============================================================================
" # Basics
" ============================================================================
lua require('plugins')

filetype plugin indent on
syntax enable
set noswapfile
set hidden
set undofile undodir=~/.vimdid
set clipboard+=unnamedplus
set mouse=a

set updatetime=300
set ttimeoutlen=10
set lazyredraw

set splitright splitbelow

set completeopt=menu,menuone,noselect
set shortmess+=c

set termguicolors
autocmd vimenter * ++nested colorscheme gruvbox

set number relativenumber numberwidth=1
set signcolumn=yes
set colorcolumn=100
set scrolloff=2
set noshowmode

set nowrap
set linebreak breakindent showbreak=﬌\ 

set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
set listchars=tab:→·,nbsp:·,extends:»,precedes:«,trail:~

set ignorecase smartcase
set gdefault

set backspace=indent,eol,start

set diffopt+=vertical

set guioptions-=T " Remove toolbar
set guifont=JetBrainsMono_Nerd_Font_Mono:h10
set guicursor+=a:blinkwait200-blinkoff125-blinkon150-Cursor/lCursor
if has('ide') " jetbrains
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
endif

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

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

augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

" Jump to last edit position on opening file
" autocmd BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" lua syntax highlighting inside .vim
let g:vimsyn_embed = 'l'

let g:rustfmt_autosave = 1

autocmd BufWritePre *.[jt]s,*[jt]sx :EslintFixAll

" ============================================================================
" # Keyboard shortcuts
" ============================================================================

let mapleader = " "

nnoremap ; :

nnoremap Y y$
nnoremap Q @q

" MOVEMENT
nnoremap j gj
nnoremap k gk
noremap H ^
noremap L $

" noremap <C-N> <C-D>
" noremap <C-M> <C-U>
" noremap <C-U> <C-F>
" noremap <C-I> <C-B>
" noremap <M-j> <C-E>
" noremap <M-k> <C-Y>

nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

noremap <Leader>h :noh<CR>

inoremap <C-J> <Nop>
" imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true
nnoremap <S-J> <Nop>

" undo breaks before deletes
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

noremap! fj <Esc>
noremap! jf <Esc>
noremap! jj <Esc>
tnoremap <Esc> <C-\><C-N>

noremap <Leader>w :w<CR>

nnoremap <Leader>t :NvimTreeToggle<CR>

nnoremap <C-Q> :confirm quitall<CR>

noremap <C-X> :bw<CR>

nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >
vnoremap <S-Tab> <

" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-N>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-M>" : "\<S-Tab>"

" <leader><leader> toggles between buffers
nnoremap <Leader><Leader> <C-^>

" shows/hides hidden characters
nnoremap <Leader>, :set invlist<CR>

nnoremap <Leader>ff <Cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>fg <Cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <Leader>fb <Cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>fh <Cmd>lua require('telescope.builtin').help_tags()<CR>

nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap J <Cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap <Leader>k <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <Leader>d <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Space>p <cmd>lua vim.lsp.buf.type_definition()<CR>

nnoremap gi <Cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <Space>s <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <Space>wa <Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <Space>wr <Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <Space>wl <Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <Space>r <Cmd>lua vim.lsp.buf.rename()<CR>
nnoremap gr <Cmd>lua vim.lsp.buf.references()<CR>
nnoremap <Space>f <Cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap E <Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap [d <Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]d <Cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <Space>q <Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>

