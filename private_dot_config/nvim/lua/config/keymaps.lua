-- Unmap some defaults
pcall(vim.keymap.del, "n", "<C-k>")
pcall(vim.keymap.del, "n", "<C-j>")
pcall(vim.keymap.del, "n", "<C-h>")
pcall(vim.keymap.del, { "n", "t" }, "<C-l>")
-- LazyVim's default lazygit mappings
pcall(vim.keymap.del, "n", "<leader>gf")
pcall(vim.keymap.del, "n", "<leader>gl")

local map = vim.keymap.set

map("n", "<Leader>k", function()
  require("which-key").show()
end, { desc = "Keymaps" })

-- GENERAL
-- esc
map("n", "<S-CR>", ":", { silent = false, desc = "Command line" })
map({ "", "i" }, "<C-c>", "<Esc>", { expr = true })
map("t", "<Esc>", "<C-Bslash><C-n>")
map("n", "<C-s>", "<Cmd>w<CR>", { desc = "Write buffer to file" })
-- macros
map("n", "Q", "@q")

-- NAVIGATION
map({ "n", "x", "o" }, "H", "^", { desc = "End of line" })
map({ "n", "x", "o" }, "L", "$", { desc = "Start of line" })
-- follow J-K order for paragraph jump
map("", "{", "}")
map("", "}", "{")
-- keep cursor centered when scrolling
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
-- windows & tabs
map("n", "<Leader><Leader>", "<Cmd>e#<CR>", { desc = "Go to last accessed buffer" })
map("n", "<C-Tab>", "<C-W>p", { desc = "Go to last accessed window" })
map("n", "<Leader><C-Tab>", "<Cmd>tabnext #<CR>", { desc = "Go to last accessed tab" })
map("n", "<A-t>", "<Cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<A-p>", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
map("n", "<A-n>", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<Leader>xk", "<Cmd>cprev<CR>zz", { desc = "Previous quickfix item" })
map("n", "<Leader>xj", "<Cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map({ "n", "v" }, "<S-Tab>", "<C-w>W", { desc = "Go to window above/left" })
map({ "n", "v" }, "<Tab>", "<C-w>w", { desc = "Go to window below/right" })
map({ "n", "v" }, "<C-i>", "<Tab>") -- CTRL-I can be mapped separately from <Tab>, on the condition that both keys are mapped, otherwise the mapping applies to both.
map("n", "<A-h>", "<C-w>h", { desc = "Move left" })
map({ "t", "i" }, "<A-h>", "<C-Bslash><C-N><C-w>h", { desc = "Move left" })
map("n", "<A-j>", "<C-w>j", { desc = "Move down" })
map({ "t", "i" }, "<A-j>", "<C-Bslash><C-N><C-w>j", { desc = "Move down" })
map("n", "<A-k>", "<C-w>k", { desc = "Move up" })
map({ "t", "i" }, "<A-k>", "<C-Bslash><C-N><C-w>k", { desc = "Move up" })
map("n", "<A-l>", "<C-w>l", { desc = "Move right" })
map({ "t", "i" }, "<A-l>", "<C-Bslash><C-N><C-w>l", { desc = "Move right" })
map({ "n" }, "<Leader>W", function()
  local nr = require("window-picker").pick_window()
  if nr ~= nil then
    vim.cmd.wincmd(nr .. " w")
  end
end, { desc = "Pick window" })

-- EDITING
-- keep cursor pos when joining lines
map("n", "J", "mzJ`z", { desc = "Join lines" })
-- don't delete to register when pasting or deleting
map("x", "<Leader>p", [["_dhp]], { desc = "Paste no yank" })
map("x", "<Leader>P", [["_dP]], { desc = "Paste no yank (before)" })
map({ "n", "v" }, "<Leader>D", [["_d]], { desc = "Delete no yank" })
-- move lines up & down
map({ "n", "i" }, "<M-S-Up>", "<Cmd>m -2<CR>", { desc = "Move line up" })
map({ "n", "i" }, "<M-S-Down>", "<Cmd>m +1<CR>", { desc = "Move line down" })
map({ "v" }, "<M-S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map({ "v" }, "<M-S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
-- add empty lines (can add count)
map("n", "[<Space>", "<Cmd>put! =repeat(nr2char(10), v:count1)<CR>", { desc = "Add empty line(s) above" })
map("n", "]<Space>", "<Cmd>put =repeat(nr2char(10), v:count1)<CR>", { desc = "Add empty line(s) below" })

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

-- GIT
-- diffs
map("n", "<Leader>gu", "<Cmd>diffget LOCAL<CR>", { desc = "Get LOCAL hunk" })
map("n", "<Leader>gl", "<Cmd>diffget REMOTE<CR>", { desc = "Get REMOTE hunk" })
map("n", "<Leader>gU", "<Cmd>%diffget LOCAL<CR>", { desc = "Get all LOCAL hunks" })
map("n", "<Leader>gL", "<Cmd>%diffget REMOTE<CR>", { desc = "Get all REMOTE hunks (whole file)" })
-- gitui
map("n", "<leader>gG", function()
  LazyVim.terminal.open({ "gitui" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "GitUi (cwd)" })
map("n", "<leader>gg", function()
  LazyVim.terminal.open({ "gitui" }, { cwd = LazyVim.root.get(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "GitUi (Root Dir)" })

-- UI
-- Clear search with <C-c>
map({ "i", "n" }, "<C-c>", "<Cmd>noh<CR><Esc>", { desc = "Escape and clear search highlights" })

-- saner command history
map("c", "<C-p>", function()
  return vim.fn.wildmenumode() and "<Up>" or "<C-p>"
end, { expr = true, silent = false })
map("c", "<C-n>", function()
  return vim.fn.wildmenumode() and "<Down>" or "<C-n>"
end, { expr = true, silent = false })

-- cspell
map("n", "<Leader>cw", "<Cmd>CspellLearnWord<CR>", { desc = "Teach current word to cspell" })
map("n", "<Leader>cp", "<Cmd>CspellLearnFile<CR>", { desc = "Teach words in current buffer to cspell" })
