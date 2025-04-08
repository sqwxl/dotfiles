local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp("codeAction") end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, { silent = true, buffer = bufnr })
