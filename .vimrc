set nocompatible


filetype plugin indent on
syntax enable

set termguicolors
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox

set swapfile
set directory^=~/.vim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" consolidate the writebackups -- not a big
" deal either way, since they usually get deleted
set backupdir^=~/.vim/backup//

" persist the undo tree for each file
set undofile
set undodir^=~/.vim/undo//

set belloff=all

" set shell-like tab completion
set wildmode=longest,list,full
set wildmenu
set completeopt=menu,menuone,noselect
set shortmess+=c

set hidden

set clipboard+=unnamedplus
set mouse=a

set updatetime=250
set ttimeoutlen=10
set lazyredraw

" splits default positions
set splitright splitbelow

" show subfolders as ascii tree
let g:netrw_liststyle = 3
" hide help banner (show with 'I')
let g:netrw_banner = 0

" use a more readable diff algo
set diffopt+=internal,algorithm:patience

set number relativenumber numberwidth=1
set signcolumn=auto
set colorcolumn=80
set scrolloff=10
set noruler " use <C-g> instead
set cursorline " highlight current line

set nowrap
set linebreak breakindent showbreak=﬌\ 

set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
set listchars=tab:→·,nbsp:·,extends:»,precedes:«,trail:~

" search options
set hlsearch incsearch ignorecase smartcase gdefault

set backspace=indent,eol,start

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

map ; :
nmap <C-s> :w<CR>
imap uu <Esc>
imap hh <Esc>
nmap Y y$
nmap Q @q
nmap <A-j> :m .+1<CR>
nmap <A-k> :m .-2<CR>
imap <A-j> <Esc>:m .+1<CR>==gi
imap <A-k> <Esc>:m .-2<CR>==gi
vmap <A-j> :m '>+1<CR>gv=gv
vmap <A-k> :m '<-2<CR>gv=gv
nmap <Leader><Leader> <C-^>
