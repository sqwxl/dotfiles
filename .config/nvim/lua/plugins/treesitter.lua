return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "css", "fish", "rust", "scss" },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true, disable = { "htmldjango" } },
      -- indent = { enable = true, disable = { "python" } }, -- indentation for the "=" operator
      matchup = { enable = true },
      endwise = { enable = true },
      autotag = { enable = true, filetypes = { "html", "htmldjango" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "<CR>",
          node_decremental = "<M-CR>",
        },
      },
    },
  },

  { "RRethy/nvim-treesitter-endwise" }, -- complete some structures like if -> end, do -> while

  { "IndianBoy42/tree-sitter-just", config = true },
}
