-- change the appearance of terminal window
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = false
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
local resize_to_tw = function()
  local tw = vim.o.tw + 2
  if not tw or tw == 0 then
    tw = 82
  end
  vim.cmd(string.gsub("vertical resize tw", "tw", tw))
end
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*.md", "*.txt" },
  callback = function(t)
    if vim.o.buftype == "help" then
      vim.o.signcolumn = "no"
      vim.o.foldcolumn = "0"
      vim.o.colorcolumn = ""
      vim.o.wrap = true
      vim.opt_local.spell = false
      vim.diagnostic.disable(t.buf)
      vim.cmd.wincmd("H")
      resize_to_tw()
    end
  end,
})
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = { "*.md", "*.txt" },
  callback = function()
    if vim.o.buftype == "help" then
      resize_to_tw()
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
vim.cmd([[" disable syntax highlighting in big files
function DisableSyntaxTreesitter()
    echo("Big file, disabling syntax, treesitter and folding")
    if exists(':TSBufDisable')
        exec 'TSBufDisable autotag'
        exec 'TSBufDisable highlight'
        " etc...
    endif

    set foldmethod=manual
    syntax clear
    syntax off    " hmmm, which one to use?
    filetype off
    set noundofile
    set noswapfile
    set noloadplugins
endfunction

augroup BigFileDisable
    autocmd!
    autocmd BufWinEnter * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
augroup END
]])
