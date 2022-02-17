local o = vim.opt

o.shortmess:append "I"
o.swapfile = false
o.hidden = true
o.undofile = true

o.inccommand = "nosplit"
o.clipboard = "unnamedplus"

o.mouse = 'a'

o.updatetime = 250
o.ttimeoutlen = 10
o.lazyredraw = false

o.splitbelow = true
o.splitright = true

o.completeopt = 'menu,menuone,noselect'
o.shortmess:append('c')

-- Color
o.termguicolors = true
vim.cmd("autocmd vimenter * ++nested colorscheme gruvbox")
o.cursorline = true

-- Number column
o.signcolumn = 'auto'
o.number = true
o.relativenumber = true
o.numberwidth = 1
o.scrolloff = 10

o.laststatus = 0

o.showcmd = true
o.showmode = false

-- Wrapping
o.wrap = false
o.linebreak = true
o.breakindent = true
o.showbreak = [[﬌ ]]

-- Indentation
local indent = 2
o.shiftwidth = indent
o.tabstop = indent
o.softtabstop = indent
o.expandtab = true
o.autoindent = true
o.smartindent = false
o.listchars = 'tab:→·,nbsp:·,extends:»,precedes:«,trail:~'

-- Search
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.gdefault = true

o.backspace = [[indent,eol,start]]

o.diffopt:append('vertical')

o.guifont = 'JetBrains_Mono:h10'
o.guicursor = o.guicursor + 'a:blinkwait200-blinkoff125-blinkon150-Cursor/lCursor'
if vim.fn.has('ide') then
  o.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50'
end

if vim.fn.executable('rg') then
  o.grepprg = 'rg --vimgrep --smart-case'
  o.grepformat = '%f:%l:%c:%m'
end

vim.g.rustfmt_autosave = 1

vim.cmd([[
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
]])

vim.cmd([[
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]])

vim.cmd('autocmd BufWritePre *.[jt]s,*[jt]sx :EslintFixAll')
