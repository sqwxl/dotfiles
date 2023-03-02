return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- load this before everything else
    config = function()
      require("gruvbox").setup({
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "soft", -- can be "hard", "soft" or empty string
        dim_inactive = true,
      })
      vim.cmd("colorscheme gruvbox")
    end
  },

  { "j-hui/fidget.nvim", config = true, },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_current_context = true,
      show_trailing_blankline_indent = false,
    }
  },

  { "lewis6991/gitsigns.nvim", config = true },
}
