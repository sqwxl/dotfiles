return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(lang, _)
          return lang == "htmldjango"
        end,
        additional_vim_regex_highlighting = false,
      },
      -- matchup = { enable = true },
      endwise = { enable = true },
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
}
