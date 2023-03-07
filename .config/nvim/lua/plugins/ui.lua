return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,    -- make sure we load this during startup
    priority = 1000, -- load this before everything else
    config = function()
      require("gruvbox").setup({
        inverse = true,    -- invert background for search, diffs, statuslines and errors
        contrast = "soft", -- can be "hard", "soft" or empty string
        dim_inactive = true,
      })
      vim.cmd("colorscheme gruvbox")
    end
  },

  { "j-hui/fidget.nvim",       config = true, },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_current_context = true,
      show_trailing_blankline_indent = false,
    }
  },

  { "lewis6991/gitsigns.nvim", config = true },

  -- auto-resize windows
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    config = function()
      -- vim.o.winwidth = 10
      -- vim.o.winminwidth = 5
      -- vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
      })
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      local scrollbar = require("scrollbar")
      local gruvbox_cfg = require("gruvbox").config
      local colors = require("gruvbox.palette").get_base_colors(vim.o.background, gruvbox_cfg.contrast)
      scrollbar.setup({
        handle = { color = colors.fg4 },
        excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
        marks = {
          Search = { color = colors.yellow },
          Error = { color = colors.red },
          Warn = { color = colors.yellow },
          Info = { color = colors.blue },
          Hint = { color = colors.aqua },
          Misc = { color = colors.purple },
        },
      })
    end,
  },
}
