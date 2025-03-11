-- https://git.sr.ht/~stephanmax/dotfiles/tree/main/item/.config/nvim/after/compiler/pdc.lua
if vim.g.current_compiler ~= nil then
  return
end
vim.g.current_compiler = "pdc"

-- Create build folder
local cwd = vim.fn.getcwd()
local project = vim.fn.fnamemodify(cwd, ":t")
vim.fn.mkdir(cwd .. "/build", "p") -- If exists, exits silently

local errorformat = {
  "%t%*[^:]: %f:%l:%m",
}

local input = cwd .. "/src"
local output = cwd .. "/build/" .. project .. ".pdx"

vim.o.makeprg = "pdc "
  .. input
  .. " "
  .. output
  .. " && "
  .. vim.env.PLAYDATE_SDK_PATH
  .. "/bin/PlaydateSimulator "
  .. output
vim.o.errorformat = table.concat(errorformat, ",")
