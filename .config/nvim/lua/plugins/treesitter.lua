return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "fish",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      -- indent = { enable = true, disable = { "python" } }, -- indentation for the "=" operator
      matchup = { enable = true },
      endwise = { enable = true },
      autotag = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "<CR>",
          node_decremental = "<M-CR>",
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },

  { "RRethy/nvim-treesitter-endwise" }, -- complete some structures like if -> end, do -> while

  { "IndianBoy42/tree-sitter-just", config = true },
}
