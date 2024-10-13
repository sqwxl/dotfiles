return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(lang, _)
          return lang == "htmldjango"
        end,
        additional_vim_regex_highlighting = { "htmldjango" },
      },
      -- matchup = { enable = true },
      endwise = { enable = true },
    },
  },

  { "RRethy/nvim-treesitter-endwise" }, -- complete some structures like if -> end, do -> while
}
