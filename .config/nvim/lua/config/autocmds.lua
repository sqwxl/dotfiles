-- run cspell everywhere
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  callback = function()
    require("lint").try_lint("cspell")
  end,
})

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
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = { "*.md", "*.txt" },
  callback = function(ev)
    if vim.o.buftype == "help" then
      vim.wo.signcolumn = "no"
      vim.wo.foldcolumn = "0"
      vim.wo.colorcolumn = ""
      vim.wo.wrap = true
      vim.wo.spell = false
      vim.diagnostic.enable(false, { bufnr = ev.buf })
      vim.cmd.wincmd("H")
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufNew", "BufWinEnter", "BufEnter", "BufLeave" }, {
  pattern = { "*.md", "*.txt" },
  callback = function(ev)
    if vim.o.buftype == "help" then
      local tw = (vim.bo[ev.buf].textwidth or 80) + 2
      vim.api.nvim_win_set_width(0, tw)
    end
  end,
})

-- use insert mode when entering commit edit
--[[ vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*COMMIT_EDITMSG",
  callback = function()
    vim.cmd("startinsert")
  end,
}) ]]

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

vim.api.nvim_create_autocmd("BufRead", {
  desc = "Restore cursor position",
  pattern = "*",
  once = true,
  callback = function(event)
    local ftignore = { "gitcommit", "gitrebase", "neo-tree" }
    local bufignore = { "nofile", "quickfix", "help" }

    local line = vim.fn.line([['"]])
    if line >= 1 and line <= vim.fn.line("$") then
      local ft = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
      if not vim.tbl_contains(ftignore, ft) then
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = event.buf })
        if not vim.tbl_contains(bufignore, buftype) then
          vim.cmd([[keepjumps normal! g`"]])
        end
      end
    end
  end,
})
