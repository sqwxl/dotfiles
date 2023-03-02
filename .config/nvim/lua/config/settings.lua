vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.updatetime = 50
vim.opt.timeoutlen = 100

vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.colorcolumn = "80,110"
vim.opt.number = true
vim.opt.signcolumn = "auto"
vim.opt.scrolloff = 10
vim.opt.shortmess:append("c")
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Indenting
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.api.nvim_create_autocmd(
  "TextYankPost",
  {
    pattern = "*",
    callback = function() vim.highlight.on_yank() end
  }
)

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false;
    vim.opt_local.signcolumn = "no"
    vim.cmd('startinsert')
  end
})

vim.g.mapleader = " "

