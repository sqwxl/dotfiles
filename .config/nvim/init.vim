call plug#begin(stdpath('data') . '/plugged')
  " Enhancements
  Plug 'justinmk/vim-sneak'
    let g:sneak#s_next = 1
  Plug 'andymass/vim-matchup'
  " Plug 'jiangmiao/auto-pairs'
  Plug 'windwp/nvim-autopairs'
  Plug 'windwp/nvim-ts-autotag'
  Plug 'tpope/vim-fugitive'
  " Plug 'tpope/vim-commentary'
  Plug 'numToStr/Comment.nvim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'lewis6991/gitsigns.nvim'
  " Plug 'airblade/vim-rooter'
  " Plug 'folke/trouble.nvim'
  Plug 'github/copilot.vim'

  " Look & feel
  Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 200
  Plug 'morhetz/gruvbox'
  Plug 'folke/lsp-colors.nvim'
  Plug 'vim-airline/vim-airline'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline_powerline_fonts = 1
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'
  Plug 'kyazdani42/nvim-web-devicons'

  " Tools
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-tree.lua'

  " Semantic language support
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp_extensions.nvim'

  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  " Syntactic language support
  Plug 'lbrayner/vim-rzip'
  Plug 'pangloss/vim-javascript'
  Plug 'cespare/vim-toml'
  Plug 'stephpy/vim-yaml'
  Plug 'dag/vim-fish'
  Plug 'plasticboy/vim-markdown'
  " Plug 'rust-lang/rust.vim'
  Plug 'simrat39/rust-tools.nvim'

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
set mouse=a

set updatetime=300
set ttimeoutlen=10
set lazyredraw

set splitright splitbelow

set completeopt=menu,menuone,noselect
set shortmess+=c

set termguicolors
autocmd vimenter * ++nested colorscheme gruvbox
let g:airline_theme = 'base16_gruvbox_dark_medium'

set number relativenumber numberwidth=1
set signcolumn=yes
set colorcolumn=100
set scrolloff=2
set noshowmode

set nowrap
set linebreak
set breakindent
let &showbreak = '﬌ '

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
" autocmd InsertLeave * set nopaste

" Enable type inlay hints
autocmd CursorHold,CursorHoldI * lua require('lsp_extensions').inlay_hints{ only_current_line = true }

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

" ============================================================================
" # Lua configs
" ============================================================================

lua << EOF
  -- require('trouble').setup()
  require('gitsigns').setup()

  require('nvim-treesitter.configs').setup({
    ensure_installed = { 
      "bash",
      "css",
      "dockerfile",
      "fish",
      "glsl",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "make",
      "markdown",
      "nix",
      "pug",
      "python",
      "rust",
      "scss",
      "svelte",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    matchup = {
      enable = true,
    },
    autotag = {
      enable = true,
    }
  })

  require('telescope').setup({
    defaults = {
      initial_mode = 'normal'
    },
  })

  require('nvim-tree').setup()
  require('Comment').setup()

  local lspconfig = require('lspconfig')

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },
    mapping = {
      ['<C-D>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-U>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-E>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    },{
      { name = 'buffer' },
    }),
  })

  cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })

  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })

  require('nvim-autopairs').setup({
    check_ts = true,
  })
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done())

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local servers = { 
    "eslint",
    "jsonls",
    "cssls",
    "vimls",
    "gopls",
    "bashls",
    "pylsp",
    "rnix",
    "tsserver",
    "html",
  }
  for _, server in ipairs(servers) do
    lspconfig[server].setup({
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      }
    })
  end
  
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  lspconfig.sumneko_lua.setup({
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = { 
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  })

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
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy"
          },
        },
      },
    },
  })
EOF

