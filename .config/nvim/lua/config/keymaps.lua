local map = vim.keymap.set

-- show top level keymaps
map("n", "<Leader>k", "<Cmd>WhichKey<CR>", { desc = "Keymaps" })

-- GENERAL
map("n", ";", ":", { noremap = true })
map("i", "<C-c>", "<Esc>", { silent = true })
map("t", "<Esc>", "<C-Bslash><C-n>")
map("n", "<C-s>", ":w<CR>")

-- NAVIGATION
map({ "n", "x", "o" }, "H", "^", { desc = "Move to start of line" })
map({ "n", "x", "o" }, "L", "$", { desc = "Move to end of line" })
-- follow J-K order for paragraph jump
map("", "{", "}", { noremap = true })
map("", "}", "{", { noremap = true })
-- move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- keep cursor centered when scrolling
map("n", "<C-u>", "<C-u>zz", { silent = true })
map("n", "<C-d>", "<C-d>zz", { silent = true })
map("n", "<Leader><Leader>", ":b#<CR>", { desc = "Switch to last used buffer" })
map("n", "<Leader>xj", ":cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "<Leader>xk", ":cprev<CR>zz", { desc = "Previous quickfix item" })
-- tabs
map("n", "<A-t>", ":tabnew<CR>", { silent = true, desc = "New tab" })
map("n", "<A-p>", ":tabprevious<CR>", { silent = true, desc = "Previous tab" })
map("n", "<A-n>", ":tabnext<CR>", { silent = true, desc = "Next tab" })
-- windows
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
map({ "t", "i" }, "<A-h>", "<C-Bslash><C-N><C-w>h")
map({ "t", "i" }, "<A-j>", "<C-Bslash><C-N><C-w>j")
map({ "t", "i" }, "<A-k>", "<C-Bslash><C-N><C-w>k")
map({ "t", "i" }, "<A-l>", "<C-Bslash><C-N><C-w>l")
map("n", "<Left>", "<C-w>h", { noremap = true })
map("n", "<Down>", "<C-w>j", { noremap = true })
map("n", "<Up>", "<C-w>k", { noremap = true })
map("n", "<Right>", "<C-w>l", { noremap = true })
map("t", "<Left>", "<C-Bslash><C-N><C-w>h", { noremap = true })
map("t", "<Down>", "<C-Bslash><C-N><C-w>j", { noremap = true })
map("t", "<Up>", "<C-Bslash><C-N><C-w>k", { noremap = true })
map("t", "<Right>", "<C-Bslash><C-N><C-w>l", { noremap = true })
-- repeat movement with ,
local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- ensure ; goes forward and , goes backward regardless of the last direction
-- map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
-- vim way: goes to the direction you were moving.
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move)
-- map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
-- make builtin f, F, t, T also repeatable with ; and ,
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

-- EDITING
-- keep cursor pos when joining lines
map("n", "J", "mzJ`z", { noremap = true, silent = true, desc = "Join lines" })
-- don't delete to register when pasting or deleting
map("x", "<Leader>p", [["_dhp]], { desc = "Paste no yank" })
map("x", "<Leader>P", [["_dP]], { desc = "Paste no yank (before)" })
map({ "n", "v" }, "<Leader>d", [["_d]], { desc = "Delete no yank" })
map("n", "<Leader>cs", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word" })
-- yank to clipboard
map({ "n", "v" }, "<Leader>y", [["+y]], { desc = "Yank to clipboard" })
map({ "n", "v" }, "<Leader>Y", [["+Y]], { desc = "Yank to clipboard (eol)" })
-- macros
map("n", "Q", "@q", { noremap = true })
-- git
map("n", "<Leader>gh", "<Cmd>diffget //2<CR>", { desc = "Get left hunk (nvimdiff)" })
map("n", "<Leader>gl", "<Cmd>diffget //3<CR>", { desc = "Get right hunk (nvimdiff)" })

-- UI
-- toggle wrap
map("n", "<A-z>", ":set wrap!<CR>", { desc = "Toggle wrap" })
-- toggle highlight
map("n", "<Leader>uh", ":set hlsearch!<CR>", { desc = "Toggle search highlight" })
-- toggle dark/light
map("n", "<Leader>ub", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { desc = "Toggle dark/light" })
