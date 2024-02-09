return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-mocha" },
  },

  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
    config = function()
      require("gruvbox").setup({
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        dim_inactive = false,
      })
      -- vim.cmd("colorscheme gruvbox")
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      color_overrides = {
        mocha = {
          rosewater = "#ffc6be",
          flamingo = "#fb4934",
          pink = "#ff75a0",
          mauve = "#f2594b",
          red = "#f2594b",
          maroon = "#fe8019",
          peach = "#FFAD7D",
          yellow = "#e9b143",
          green = "#b0b846",
          teal = "#8bba7f",
          sky = "#7daea3",
          sapphire = "#689d6a",
          blue = "#80aa9e",
          lavender = "#e2cca9",
          text = "#e2cca9",
          subtext1 = "#e2cca9",
          subtext0 = "#e2cca9",
          overlay2 = "#8C7A58",
          overlay1 = "#735F3F",
          overlay0 = "#806234",
          surface2 = "#665c54",
          surface1 = "#3c3836",
          surface0 = "#32302f",
          base = "#282828",
          mantle = "#1d2021",
          crust = "#1b1b1b",
        },
      },
    },
  },
}
