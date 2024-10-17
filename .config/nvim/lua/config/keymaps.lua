local map = vim.keymap.set

-- show top level keymaps
map("n", "<Leader>k", function()
  require("which-key").show()
end, { desc = "Keymaps" })

-- GENERAL
map("n", "<S-CR>", ":")
map({ "", "i" }, "<C-c>", "<Esc>")
map("t", "<Esc>", "<C-Bslash><C-n>")
map("n", "<C-s>", "<Cmd>w<CR>", { desc = "Save" })

-- NAVIGATION
map({ "n", "x", "o" }, "H", "^", { desc = "Move to start of line" })
map({ "n", "x", "o" }, "L", "$", { desc = "Move to end of line" })

-- follow J-K order for paragraph jump
map("", "{", "}")
map("", "}", "{")

-- move lines
map({ "n", "i" }, "<M-S-Up>", "<Cmd>m -2<CR>", { silent = true })
map({ "n", "i" }, "<M-S-Down>", "<Cmd>m +1<CR>", { silent = true })
map({ "v" }, "<M-S-Up>", ":m '<-2<CR>gv=gv", { silent = true })
map({ "v" }, "<M-S-Down>", ":m '>+1<CR>gv=gv", { silent = true })

-- keep cursor centered when scrolling
map("n", "<C-u>", "<C-u>zz", { silent = true })
map("n", "<C-d>", "<C-d>zz", { silent = true })

map("n", "<Leader><Leader>", "<Cmd>e#<CR>", { desc = "Go to last accessed buffer" })
map("n", "<Leader>xj", "<Cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "<Leader>xk", "<Cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

-- tabs
map("n", "<A-t>", "<Cmd>tabnew<CR>", { silent = true, desc = "New tab" })
map("n", "<A-p>", "<Cmd>tabprevious<CR>", { silent = true, desc = "Previous tab" })
map("n", "<A-n>", "<Cmd>tabnext<CR>", { silent = true, desc = "Next tab" })
-- fix tab switching
map("n", "<C-Tab>", function()
  local tabpage = vim.fn.tabpagenr("#")
  if tabpage ~= 0 then
    vim.cmd("tabnext" .. tabpage)
  else
    vim.cmd.tabprevious()
  end
end, { desc = "Go to last accessed tab" })

-- windows
map({ "n", "v" }, "<C-i>", "<Tab>")
map({ "n", "v" }, "<Tab>", "<C-w>w")
map({ "n", "v" }, "<S-Tab>", "<C-w>W")
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
map({ "t", "i" }, "<A-h>", "<C-Bslash><C-N><C-w>h")
map({ "t", "i" }, "<A-j>", "<C-Bslash><C-N><C-w>j")
map({ "t", "i" }, "<A-k>", "<C-Bslash><C-N><C-w>k")
map({ "t", "i" }, "<A-l>", "<C-Bslash><C-N><C-w>l")

map({ "n" }, "<Leader>W", function()
  local picked_window_id = require("window-picker").pick_window()
  if picked_window_id then
    vim.api.nvim_set_current_win(picked_window_id)
  end
end, { desc = "Pick window" })

vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-h>")
vim.keymap.del({ "n", "t" }, "<C-l>")

-- EDITING
-- keep cursor pos when joining lines
map("n", "J", "mzJ`z", { silent = true, desc = "Join lines" })
-- don't delete to register when pasting or deleting
map("x", "<Leader>p", [["_dhp]], { desc = "Paste no yank" })
map("x", "<Leader>P", [["_dP]], { desc = "Paste no yank (before)" })
map({ "n", "v" }, "<Leader>D", [["_d]], { desc = "Delete no yank" })

map("n", "<Leader>R", function()
  local old = vim.fn.expand("<cword>")
  vim.ui.input({ prompt = 'Replace "' .. old .. '" with: ', default = old, completion = "buffer" }, function(new)
    if new ~= nil then
      vim.cmd("%s/\\<" .. old .. "\\>/" .. new .. "/gI")
    end
  end)
end, { desc = "Replace word under cursor" })

-- yank to clipboard
map({ "n", "v" }, "<Leader>y", [["+y]], { desc = "Yank to clipboard" })
map({ "n", "v" }, "<Leader>Y", [["+Y]], { desc = "Yank to clipboard (eol)" })
-- macros
map("n", "Q", "@q")
-- git
-- unmap LazyVim's default lazygit mappings
pcall(vim.keymap.del, "n", "<leader>gf")
pcall(vim.keymap.del, "n", "<leader>gl")
map("n", "<Leader>gu", "<Cmd>diffget LOCAL<CR>", { desc = "Get local hunk" })
map("n", "<Leader>gl", "<Cmd>diffget REMOTE<CR>", { desc = "Get remote hunk" })
map("n", "<Leader>gU", "<Cmd>%diffget LOCAL<CR>", { desc = "Get local hunk (whole file)" })
map("n", "<Leader>gL", "<Cmd>%diffget REMOTE<CR>", { desc = "Get remote hunk (whole file)" })

map("n", "<leader>gG", function()
  LazyVim.terminal.open({ "gitui" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "GitUi (cwd)" })
map("n", "<leader>gg", function()
  LazyVim.terminal.open({ "gitui" }, { cwd = LazyVim.root.get(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "GitUi (Root Dir)" })

-- UI
-- toggle wrap
map("n", "<A-z>", "<Cmd>set wrap!<CR>", { desc = "Toggle wrap" })
-- toggle highlight
map("n", "<Leader>ue", "<Cmd>set hlsearch!<CR>", { desc = "Toggle search highlight" })
-- Clear search with <C-c>
map({ "i", "n" }, "<C-c>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
-- toggle dark/light
map("n", "<Leader>ub", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { desc = "Toggle dark/light" })

-- saner command history (Up/Down consider partial input, now p/n do to!)
map("c", "<C-p>", function()
  return vim.fn.wildmenumode() and "<Up>" or "<C-p>"
end, { expr = true })
map("c", "<C-u>", function()
  return vim.fn.wildmenumode() and "<Down>" or "<C-u>"
end, { expr = true })

-- add empty lines (can add count)
map("n", "[<Space>", "<Cmd>put! =repeat(nr2char(10), v:count1)<CR>", { desc = "Add empty line(s) above" })
map("n", "]<Space>", "<Cmd>put =repeat(nr2char(10), v:count1)<CR>", { desc = "Add empty line(s) below" })

-- cspell
map("n", "<Leader>cw", "<Cmd>CspellLearnWord<CR>", { desc = "Teach current word to cspell" })
map("n", "<Leader>cp", "<Cmd>CspellLearnFile<CR>", { desc = "Teach words in current buffer to cspell" })
