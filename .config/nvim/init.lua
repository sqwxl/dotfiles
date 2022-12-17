if not vim.g.vscode then
  require "plugins"
else
  require "plugins_vscode"
end
require "settings"
require "mappings"

if not vim.g.vscode then
  require "packer_compiled"
else
  require "packer_compiled_vscode"
end

