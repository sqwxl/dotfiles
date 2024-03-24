vim.g.mapleader = " "

vim.g.node_host_prog = vim.fn.system({ "npm", "get", "-g", "prefix" }):gsub("\n", "") .. "/bin/neovim-node-host"
-- local node_bin = vim.fn.exepath("node")
-- vim.g.copilot_node_command = node_bin
-- vim.cmd("let $PATH = '" .. node_bin .. ":' . $PATH")

vim.g.python3_host_prog = "~/.virtualenvs/pynvim/bin/python"

if vim.g.neovide then
  vim.o.guifont = "FantasqueSansM Nerd Font Mono,Noto Color Emoji:h12"
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.keymap.set("n", "<C-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<C-S-c>", '"+y') -- Copy
  vim.keymap.set("n", "<C-S-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<C-S-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<C-S-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<C-S-v>", '<ESC>l"+Pli') -- Paste insert mode

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-+>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)
end

local opt = vim.opt

opt.exrc = true -- enable local .vimrc files
opt.secure = true -- disable shell and write commands in local .vimrc files

opt.autowrite = false -- save when switching buffers
-- opt.syntax = "off"
opt.spell = false
opt.hlsearch = false
opt.ignorecase = true -- ignore case letters when searching
opt.smartcase = true -- override ignorecase if search contains uppercase letters
opt.mouse = "a" -- enable mouse support
opt.updatetime = 50 -- swap file update & CursorHold interval
opt.timeoutlen = 500

opt.undofile = true
opt.undolevels = 10000
opt.clipboard = ""
opt.conceallevel = 3 -- hide * markup for bold and italic

-- UI
opt.termguicolors = true
opt.background = "dark"
opt.completeopt = "menu,menuone,noselect"
opt.list = false -- show whitespace indicators
opt.wrap = false
opt.cursorline = true
-- opt.colorcolumn = "80,110"
opt.number = true
opt.pumblend = 0 -- transparency of popup menu (0 = opaque/disabled)
opt.pumheight = 0 -- max number of items in popup menu (0 = use available screen space)
opt.relativenumber = false
opt.sessionoptions = { "blank", "buffers", "curdir", "help", "tabpages", "winsize", "winpos", "localoptions" }
opt.signcolumn = "yes" -- always show sign column to avoid shifting text
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.laststatus = 2 -- window statusline visibility (2 == all windows)
opt.shortmess:remove("W")
opt.shortmess:append({ c = true, I = true })
opt.showmode = true
opt.splitright = true
opt.splitbelow = true
opt.wildmode = "longest:full,full" -- command-line completion mode

-- Indenting
-- opt.autoindent = true -- copy indent from current line when starting a new line
opt.smartindent = true -- insert indents automatically
opt.breakindent = true -- keep indent when wrapping lines
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2
opt.shiftround = false
opt.tabstop = 2

opt.formatoptions = "tcro/qnlj"
-- folds
-- opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.foldcolumn = "0"
-- opt.foldlevel = 99
-- opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

-- if vim.g.started_by_firenvim then
--   opt.laststatus = 0
--   opt.number = false
--   opt_local.signcolumn = "no"
--   opt.background = "light"
--   opt_local.cursorline = false
--
--   vim.g.firenvim_config = {
--     localSettings = {
--           [".*"] = {
--         selector = "textarea",
--         takeover = "never"
--       }
--     }
--   }
-- end
