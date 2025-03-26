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
map({ "", "i" }, "<C-c>", "<Cmd>noh<CR><Esc>", { desc = "Escape and clear search highlights" })
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
map("n", "gV", function()
  vim.lsp.buf.definition({ reuse_win = true })
end, { desc = "Go to definiton in split" })

-- EDITING
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

-- GIT
-- diffs
map("n", "<Leader>gu", "<Cmd>diffget LOCAL<CR>", { desc = "Get LOCAL hunk" })
map("n", "<Leader>gl", "<Cmd>diffget REMOTE<CR>", { desc = "Get REMOTE hunk" })
map("n", "<Leader>gU", "<Cmd>%diffget LOCAL<CR>", { desc = "Get all LOCAL hunks" })
map("n", "<Leader>gL", "<Cmd>%diffget REMOTE<CR>", { desc = "Get all REMOTE hunks" })
map("n", "<leader>gG", function()
  Snacks.terminal({ "gitui" })
end, { desc = "GitUi (cwd)" })
map("n", "<leader>gg", function()
  Snacks.terminal({ "gitui" }, { cwd = LazyVim.root.get() })
end, { desc = "GitUi (Root Dir)" })

-- UI
-- saner command history
map("c", "<C-p>", function()
  return vim.fn.wildmenumode() and "<Up>" or "<C-p>"
end, { expr = true, silent = false })
map("c", "<C-n>", function()
  return vim.fn.wildmenumode() and "<Down>" or "<C-n>"
end, { expr = true, silent = false })
