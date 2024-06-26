return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(lang, bufnr)
          return lang == "htmldjango" or vim.api.nvim_buf_line_count(bufnr) > 5000
        end,
        additional_vim_regex_highlighting = false,
      },
      -- indent = { enable = true, disable = { "python" } }, -- indentation for the "=" operator
      matchup = { enable = true },
      endwise = { enable = true },
      autotag = { enable = true, filetypes = { "html", "htmldjango", "javascriptreact", "typescriptreact" } },
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
