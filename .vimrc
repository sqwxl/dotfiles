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
