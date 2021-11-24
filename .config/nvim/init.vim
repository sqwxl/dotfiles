call plug#begin(stdpath('data') . '/plugged')
  " Enhancements
  Plug 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
  Plug 'justinmk/vim-sneak'
    let g:sneak#s_next = 1
  Plug 'andymass/vim-matchup'
  Plug 'szw/vim-maximizer'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'airblade/vim-rooter'
  Plug 'folke/trouble.nvim'

  " Look & feel
  Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 200
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'
  Plug 'RRethy/nvim-base16'
  Plug 'folke/lsp-colors.nvim'
  Plug 'vim-airline/vim-airline'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tmuxline#enabled = 1
    let g:airline_powerline_fonts = 1
  Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme = 'base16_default_dark'
  Plug 'edkolev/tmuxline.vim'

  " Tools
  Plug 'kassio/neoterm'
    let g:neoterm_default_mod = 'vertical'
    let g:neoterm_size = 80
    let g:neoterm_autoinsert = 1
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'preservim/nerdtree'
    let g:webdevicons_conceal_nerdtree_brackets = 1

  " Semantic language support
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp_extensions.nvim'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'

  " For vsnip users.
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

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

call plug#end()

" ============================================================================
" # Basics
" ============================================================================

set nocompatible
filetype plugin indent on
syntax enable
set noswapfile
set hidden
set undofile undodir=~/.vimdid
set clipboard+=unnamedplus
set mouse=a " Enable mouse usage (all modes) in terminals

set updatetime=100
set timeoutlen=350
set lazyredraw

set splitright splitbelow

set completeopt=menu,menuone,noinsert,noselect
set shortmess+=c

set termguicolors
colorscheme base16-default-dark

set number relativenumber numberwidth=1
set signcolumn=yes
set colorcolumn=100 " and give me a colored column
set scrolloff=2
set noshowmode " We have airline for that

set nowrap
set nolinebreak
set breakindent
let &showbreak = '\ '

set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
set listchars=tab:→·,nbsp:·,extends:»,precedes:«,trail:~

set inccommand=nosplit
set incsearch
set ignorecase smartcase
set gdefault

set backspace=indent,eol,start
set nojoinspaces

set diffopt+=vertical

set guioptions-=T " Remove toolbar
set guifont=JetBrainsMono_Nerd_Font_Mono:h10
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait200-blinkoff125-blinkon150-Cursor/lCursor

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

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

" Jump to last edit position on opening file
autocmd BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Follow Rust code style rules
autocmd Filetype rust source ~/.config/nvim/scripts/spacetab.vim
autocmd Filetype rust set colorcolumn=100

" ============================================================================
" # Keyboard shortcuts
" ============================================================================

let mapleader = " "

nnoremap ; :

nnoremap Y y$
nnoremap Q @q

nnoremap j gj
nnoremap k gk
noremap H ^
noremap L $
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
noremap <C-N> <C-D>
noremap <C-M> <C-U>
noremap <C-F> <C-F>
noremap <C-G> <C-B>

" undo breaks before deletes
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

inoremap fj <Esc>
inoremap jf <Esc>
inoremap jj <Esc>
inoremap ff <Esc>
tnoremap <Esc> <C-\><C-N>

noremap <leader>w :w<CR>
noremap <leader>m :MaximizerToggle!<CR>

function! ToggleNT()
    NERDTreeToggle
    silent NERDTreeMirror
endfunction
  
noremap <leader>t :call ToggleNT()<CR>
noremap <leader>c ciw
noremap <leader>d diw
noremap <leader>y yiw
noremap <leader>v viw

nnoremap <C-Q> :Ttoggle<CR>
inoremap <C-Q> <Esc>:Ttoggle<CR>
tnoremap <C-Q> <C-\><C-N>:Ttoggle<CR>

nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >
vnoremap <S-Tab> <
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <C-^>

" shows/hides hidden characters
nnoremap <leader>, :set invlist<CR>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" ============================================================================
" # Lua configs
" ============================================================================

lua << EOF
  require'trouble'.setup()
  require'gitsigns'.setup()

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

  local lspconfig = require'lspconfig'
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

  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    },
    {
      { name = 'buffer' },
    })
  })

  local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

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
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
        }
      }
  end
EOF

