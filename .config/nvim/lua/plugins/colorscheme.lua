return {
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "soft", -- can be "hard", "soft" or empty string
        -- dim_inactive = true,
      })
      -- vim.cmd("colorscheme gruvbox")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox" },
  },
}
