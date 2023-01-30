vim.g.mapleader = " "

local noremap_silent = { noremap=true, silent=true }

vim.keymap.set("n", "<C-s>", ":w<CR>")

-- move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", noremap_silent)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", noremap_silent)

-- keep cursor pos when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- don't delete to register when pasting or deleting
vim.keymap.set("x", "<leader>p", [["_dP]], noremap_silent)
vim.keymap.set("n", "<leader>d", [["_d]], noremap_silent)
vim.keymap.set("v", "<leader>d", [["_d]], noremap_silent)

-- yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("i", "<C-c>", "<Esc>", noremap_silent)

-- replace word under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", ";", ":", { noremap=true })
vim.keymap.set("n", "Q", "@q", noremap_silent)

-- switch to last used buffer
vim.keymap.set("n", "<leader><leader>", ":b#<CR>", noremap_silent)

vim.keymap.set("n", "<leader>h", ":nohl<CR>", noremap_silent)

vim.keymap.set("n", "<M-z>", ":set wrap!<CR>", noremap_silent)

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, noremap_silent)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, noremap_silent)
vim.keymap.set("i", "<C-f>", [[copilot#Accept("")]], { expr=true, silent=true })

local telescope = require('telescope.builtin')
if telescope then
  vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
  vim.keymap.set("n", "<C-p>", telescope.git_files, {})
  vim.keymap.set("n", "<C-f>", telescope.live_grep, {})
  vim.keymap.set("n", "<leader>bb", telescope.buffers, {})
  vim.keymap.set("n", "<leader>fh", telescope.help_tags, {})
end

if not vim.g.vscode then
  vim.keymap.set("n", "<C-;>", ":NvimTreeToggle<CR>", noremap_silent)
end

