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
      endwise = { enable = true },
    },
  },

  -- complete some structures like if -> end, do -> while
  { "RRethy/nvim-treesitter-endwise", event = "VeryLazy" },
}
