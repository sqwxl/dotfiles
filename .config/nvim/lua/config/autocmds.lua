-- change the appearance of terminal window
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = false
    vim.cmd.startinsert()
  end,
})

-- change to terminal mode when entering terminal window
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd.startinsert()
  end,
})

-- move help window to the left side and resize to textwidth
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = { "*.md", "*.txt" },
  callback = function(ev)
    if vim.o.buftype == "help" then
      vim.wo.signcolumn = "no"
      vim.wo.foldcolumn = "0"
      vim.wo.colorcolumn = ""
      vim.wo.spell = false
      vim.diagnostic.enable(false, { bufnr = ev.buf })
      vim.cmd("wincmd H")
    end
  end,
})
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter", "BufLeave" }, {
  pattern = { "*.md", "*.txt" },
  callback = function(ev)
    if vim.o.buftype == "help" then
      local tw = (vim.bo[ev.buf].textwidth or 80)
      local width = math.max(tw, 80)
      vim.cmd("vert resize " .. width)
    end
  end,
})

-- show cursorline only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  desc = "Restore cursor position",
  pattern = "*",
  once = true,
  callback = function()
    local ft_ignore = { "gitcommit", "gitrebase", "neo-tree" }
    local bt_ignore = { "nofile", "quickfix", "help" }

    local line = vim.fn.line([['"]])
    if line >= 1 and line <= vim.fn.line("$") then
      local ft = vim.cmd("set filetype")
      if not vim.tbl_contains(ft_ignore, ft) then
        local bt = vim.cmd("set buftype")
        if not vim.tbl_contains(bt_ignore, bt) then
          vim.cmd('keepjumps normal! g`"')
        end
      end
    end
  end,
})
