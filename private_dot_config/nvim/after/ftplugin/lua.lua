function exists(file)
  local f = io.open(file, "r")
  return f ~= nil and io.close(f)
end

-- Playdate-specific
if exists(vim.fn.getcwd() .. "pdxinfo") then
  vim.cmd("compiler pdc")
end
