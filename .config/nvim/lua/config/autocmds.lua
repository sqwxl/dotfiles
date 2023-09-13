-- change the appearance of terminal window
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false;
    vim.opt_local.signcolumn = "no"
    vim.cmd('startinsert')
  end
})

-- change to terminal mode when entering terminal window
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd('startinsert')
  end
})

-- move help window to the left side and resize to 80 columns
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.txt",
  callback = function()
    if vim.o.filetype == "help" then
      vim.cmd([[ wincmd H | vertical resize 80 ]])
    end
  end
})

-- use insert mode when entering commit edit
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*COMMIT_EDITMSG",
  callback = function()
    vim.cmd('startinsert')
  end
})
