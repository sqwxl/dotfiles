-- change the appearance of terminal window
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
})

-- change to terminal mode when entering terminal window
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- move help window to the left side and resize to 80 columns
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.txt",
  callback = function()
    if vim.o.filetype == "help" then
      vim.opt_local.signcolumn = "no"
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.colorcolumn = ""
      vim.opt_local.wrap = true
      vim.cmd([[ wincmd H | vertical resize 80 ]])
    end
  end,
})

-- use insert mode when entering commit edit
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*COMMIT_EDITMSG",
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- better cursorline
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
