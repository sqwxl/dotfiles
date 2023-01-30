require("nvim-treesitter.configs").setup {
  ensure_installed = { "bash", "fish", "lua", "python", "rust" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "<CR>",
      node_decremental = "<M-CR>"
    }
  }
}
