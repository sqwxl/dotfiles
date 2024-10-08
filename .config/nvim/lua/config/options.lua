vim.g.maplocalleader = ","

vim.g.node_host_prog = "~/.npm-global/bin/neovim-node-host"
-- local node_bin = vim.fn.exepath("node")
-- vim.g.copilot_node_command = node_bin
-- vim.cmd("let $PATH = '" .. node_bin .. ":' . $PATH")

vim.g.python3_host_prog = "~/.virtualenvs/pynvim/bin/python"
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"

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

opt.breakindent = true -- keep indent when wrapping lines
-- opt.colorcolumn = "80,110"
opt.conceallevel = 3 -- hide * markup for bold and italic
opt.exrc = true -- enable local .vimrc files
opt.foldcolumn = "0"
opt.foldenable = false
opt.formatoptions = "jcroqlnt/"
opt.laststatus = 2 -- window statusline visibility (2 == all windows)
opt.pumblend = 0 -- transparency of popup menu (0 = opaque/disabled)
opt.pumheight = 0 -- max number of items in popup menu (0 = use available screen space)
opt.relativenumber = false
opt.scrolloff = 10
opt.secure = true -- disable shell and write commands in local .vimrc files
opt.spell = true
opt.timeoutlen = 300
opt.updatetime = 50 -- swap file update & CursorHold interval

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

require("config.custom")
