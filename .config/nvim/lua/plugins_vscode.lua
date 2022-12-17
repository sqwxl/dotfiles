
local packer = require("packer")

packer.init {
  compile_path = vim.fn.stdpath('config') .. "/lua/packer_compiled_vscode.lua"
}

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "tpope/vim-surround"

  use "tpope/vim-repeat"

  use "tpope/vim-endwise"

  use "tpope/vim-fugitive"

  use {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end
  }

end)

