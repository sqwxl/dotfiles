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

-- move help window to the left side and resize to textwidth
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.md", "*.txt" },
  callback = function()
    if vim.o.buftype == "help" then
      vim.o.signcolumn = "no"
      vim.o.foldcolumn = "0"
      vim.o.colorcolumn = ""
      vim.o.wrap = true
      local tw = vim.o.tw + 1
      if not tw or tw == 0 then
        tw = 81
      end
      vim.cmd.wincmd("H")
      local cmd = string.gsub("vertical resize tw", "tw", tw)
      print(cmd)
      vim.cmd(cmd)
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

-- -- better cursorline
-- vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
--   pattern = "*",
--   callback = function()
--     vim.opt_local.cursorline = true
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
--   pattern = "*",
--   callback = function()
--     vim.opt_local.cursorline = false
--   end,
-- })
