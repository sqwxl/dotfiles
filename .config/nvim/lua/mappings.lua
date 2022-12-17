local opts = { noremap=true, silent=true }
vim.keymap.set("n", ";", ":", { noremap=true })
vim.keymap.set("n", "Q", "@q", ops)
vim.keymap.set("n", '<leader><leader>', ":b#<CR>", opts)
vim.keymap.set("n", '<leader>h', ":nohl<CR>", opts)
vim.keymap.set("n", "<M-z>", ":set wrap!<CR>", opts)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
if not vim.g.vscode then
  vim.keymap.set('n', '<escape>', ":NvimTreeToggle<CR>", opts)
end

