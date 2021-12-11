call plug#begin(stdpath('data') . '/plugged')
  " Enhancements
  Plug 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']
  Plug 'justinmk/vim-sneak'
    let g:sneak#s_next = 1
  Plug 'andymass/vim-matchup'
  Plug 'jiangmiao/auto-pairs'
  Plug 'szw/vim-maximizer'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'airblade/vim-rooter'
  Plug 'folke/trouble.nvim'
  Plug 'mattn/webapi-vim'

  " Look & feel
  Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 200
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'
  Plug 'RRethy/nvim-base16'
  Plug 'folke/lsp-colors.nvim'
  Plug 'vim-airline/vim-airline'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline#extensions#tmuxline#enabled = 1
    let g:airline_powerline_fonts = 1
  Plug 'vim-airline/vim-airline-themes'
  Plug 'edkolev/tmuxline.vim'

  " Tools
  Plug 'kassio/neoterm'
    let g:neoterm_default_mod = 'vertical'
    let g:neoterm_size = 80
    let g:neoterm_autoinsert = 1
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'preservim/nerdtree'
    let g:webdevicons_conceal_nerdtree_brackets = 1

  " Semantic language support
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp_extensions.nvim'

  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'lbrayner/vim-rzip'

  " Syntactic language support
  Plug 'simrat39/rust-tools.nvim'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'pangloss/vim-javascript'
  Plug 'cespare/vim-toml'
  Plug 'stephpy/vim-yaml'
  Plug 'dag/vim-fish'
  Plug 'plasticboy/vim-markdown'
  Plug 'rust-lang/rust.vim'

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

set updatetime=300
set ttimeoutlen=10
" set timeoutlen=350
set lazyredraw

set splitright splitbelow

set completeopt=menu,menuone,noinsert,noselect
set shortmess+=c

set termguicolors
colorscheme base16-dracula
let g:airline_theme = 'base16_dracula'

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
set guicursor+=a:blinkwait200-blinkoff125-blinkon150-Cursor/lCursor
if has('ide')
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

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Enable type inlay hints
autocmd CursorHold,CursorHoldI * lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

" Jump to last edit position on opening file
autocmd BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Follow Rust code style rules
autocmd Filetype rust source ~/.config/nvim/scripts/spacetab.vim
autocmd Filetype rust set colorcolumn=100

let g:rust_recommended_style = 1
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 1
let g:rust_clip_command = 'xclip -selection clipboard'
let g:rust_keep_autopairs_default = 0
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
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
noremap <M-K> <C-Y>
noremap <M-J> <C-E>
noremap <C-N> <C-D>
noremap <C-M> <C-U>
<<<<<<< HEAD
noremap <C-U> <C-F>
noremap <C-I> <C-B>
noremap <C-E> :noh<CR>
=======
noremap <C-F> <C-F>
noremap <C-G> <C-B>
noremap <M-j> <C-E>
noremap <M-k> <C-Y>
noremap <C-E> :noh<CR>
inoremap <C-J> <Nop>
>>>>>>> ca0c9e1f9283f639f8b9a8554666ea6b69fd3f6e

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

noremap <C-X> :bw<CR>

nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >
vnoremap <S-Tab> <
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-M>" : "\<S-Tab>"

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <C-^>

" shows/hides hidden characters
nnoremap <leader>, :set invlist<CR>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <leader>t <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-K>      <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> gi        <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <leader>wa        <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
" nnoremap <silent> <leader>wr        <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
" nnoremap <silent> <leader>wl        <cmd>lua vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
" nnoremap <silent> <leader>r        <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <silent> <leader>n        <cmd>lua vim.lsp.buf.code_action()<CR>
" nnoremap <silent> <leader>R        <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g[        <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> g]        <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <silent> <leader>f        <cmd>lua vim.lsp.buf.formatting()<CR>
" nnoremap <silent> <leader>q        <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>

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
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    --Enable completion triggered by <C-x><C-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<space>k', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>p', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<space>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
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
      ['<CR>'] = cmp.mapping.confirm({ 
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
  })

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local servers = {
    "gopls",
    "vimls",
    "bashls",
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

  lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
      }
    }

  -- rust
  require('rust-tools').setup({
    tools = {
      autoSetHints = true,
      hover_with_actions = true,
      inlay_hints = {
        show_parameter_hints = false,
        parameter_hints_prefix = "",
        other_hints_prefix = "",
      },
    },
    
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            command = 'clippy'
          },
        },
      },
    }
  })
EOF

