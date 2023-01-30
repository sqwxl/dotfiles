local opt = vim.opt

opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.updatetime = 50

opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

if not vim.g.vscode then
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  opt.termguicolors = true
  opt.background = "dark"
  vim.cmd([[colorscheme gruvbox]])
end

vim.api.nvim_create_autocmd(
  "TextYankPost",
  {
    pattern = "*",
    callback = function() vim.highlight.on_yank() end
  }
)
opt.completeopt = "menuone,noinsert,noselect"
opt.wrap = false
opt.cursorline = true
opt.colorcolumn = "80"
opt.number = true
opt.signcolumn = "auto"
opt.scrolloff = 10
opt.shortmess:append "c" 
opt.splitbelow = true

-- Indenting
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

