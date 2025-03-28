vim.g.leader = " "
vim.g.maplocalleader = "\\"

vim.g.node_host_prog = "~/.npm-global/bin/neovim-node-host"
vim.g.python3_host_prog = "~/.virtualenvs/pynvim/bin/python"

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
vim.g.ai_cmp = true -- add AI sources to blink.cmp

vim.g.snacks_animate = false

local opt = vim.opt

opt.autowrite = true
opt.breakindent = true -- keep indent when wrapping lines
opt.diffopt:append("iwhite") -- ignore whitespace
opt.diffopt:append("algorithm:histogram")
opt.diffopt:append("indent-heuristic")
opt.exrc = true -- enable local .init.lua files
opt.foldcolumn = "0"
opt.foldenable = false
opt.formatoptions = "jcroqlnt/"
opt.laststatus = 2 -- statusline visibility (2 = all windows)
opt.listchars = "tab:> ,trail:·,nbsp:+"
opt.pumblend = 0 -- transparency of popup menu (0 = opaque/disabled)
opt.pumheight = 0 -- max number of items in popup menu (0 = use available screen space)
opt.relativenumber = false
opt.scrolloff = 10
opt.secure = true -- disable shell and write commands in local .vimrc files
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "globals", "skiprtp", "folds" }
opt.spell = false
opt.timeoutlen = 300
opt.updatetime = 50 -- swap file update & CursorHold interval

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

if vim.g.neovide then
  vim.o.guifont = "JetBrains_Mono,Symbols_Nerd_Font,Noto_Color_Emoji:h13"
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_padding_top = 8
  vim.g.neovide_padding_bottom = 8
  vim.g.neovide_padding_right = 8
  vim.g.neovide_padding_left = 8

  vim.keymap.set("n", "<C-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<C-S-c>", '"+y') -- Copy
  vim.keymap.set("n", "<C-S-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<C-S-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<C-S-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<C-S-v>", '<ESC>l"+Pli') -- Paste insert mode

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
