" don't try to imitate vi
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
set undodir=~/.vim/undo//

set history=1000

" autoload file changes
set autoread

" ask to save rather than fail
set confirm

set visualbell

" set shell-like tab completion
set wildmode=longest,list,full
set wildmenu
set completeopt=menu,menuone,noselect
set shortmess+=c

" show partial cmds
set showcmd

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" let me work with hidden, unsaved buffers
set hidden

set clipboard+=unnamedplus
set mouse=a

set updatetime=250

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

set complete-=i
set lazyredraw

" splits default positions
set splitright splitbelow

" show subfolders as ascii tree
let g:netrw_liststyle = 3
" hide help banner (show with 'I')
let g:netrw_banner = 0

" use a more readable diff algo
set diffopt+=internal,algorithm:patience

set number numberwidth=1
set signcolumn=auto
set colorcolumn=80
set scrolloff=10
set noruler " use <C-g> instead
set cursorline " highlight current line

set nowrap
set linebreak breakindent showbreak=﬌\ 

set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent smarttab
set listchars=tab:→·,nbsp:·,extends:»,precedes:«,trail:~

" dont go to very first char
set nostartofline

" search options
set hlsearch incsearch ignorecase smartcase gdefault

set backspace=indent,eol,start

set laststatus=2 " show statusline on last window
set statusline=%<%f\ %h%m%r\ %{FugitiveStatusline()}%=%P

" load built-in plugin
packadd! matchit

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

map ; :
nmap <C-S> :w<CR>
nnoremap <C-L> :noh<CR><C-L>
nmap Y y$
nmap Q @q
" nunmap <C-K>
nmap <A-J> :m .+1<CR>
nmap <A-K> :m .-2<CR>
imap <A-J> <Esc>:m .+1<CR>==gi
imap <A-K> <Esc>:m .-2<CR>==gi
vmap <A-J> :m '>+1<CR>gv=gv
vmap <A-K> :m '<-2<CR>gv=gv
nmap <Leader><Leader> <C-^>

" start new change, otherwise un-undoable
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
