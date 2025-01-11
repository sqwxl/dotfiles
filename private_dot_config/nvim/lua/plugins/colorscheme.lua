return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local colors = require("gruvbox").palette
      require("gruvbox").setup({
        contrast = "", -- can be "hard", "soft" or empty string
        overrides = {
          TelescopeNormal = { bg = colors.dark0 },
          NeoTreeDirectoryName = { link = "GruvboxBlueBold" },
          NeoTreeDirectoryIcon = { link = "NeoTreeDirectoryName" },
          NeoTreeRootName = { fg = colors.bright_aqua, bold = true, italic = true },
          NeoTreeModified = { fg = colors.neutral_green },
          NeoTreeGitAdded = { fg = colors.bright_green },
          NeoTreeFilterTerm = { fg = colors.bright_green, bold = true },
          WindowPickerStatusLine = { link = "GruvboxBlueBold" },
          WindowPickerStatusLineNC = { link = "GruvboxAqua" },
          WindowPickerWinBar = { link = "GruvboxBlueBold" },
          WindowPickerWinBarNC = { link = "GruvboxAqua" },
          SpellBad = { fg = colors.bright_red, undercurl = true },
          SpellRare = { fg = colors.bright_purple, undercurl = true },
        },
      })
    end,
  },

  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    opts = {
      color_overrides = {
        mocha = {
          rosewater = "#ffc6be",
          flamingo = "#d79921",
          pink = "#d3869b",
          mauve = "#b16286",
          red = "#fb4934",
          maroon = "#fe8019",
          peach = "#d65d0e",
          yellow = "#fabd2f",
          green = "#b8bb26",
          teal = "#8ec07c",
          sky = "#689d6a",
          sapphire = "#83a598",
          blue = "#458588",
          lavender = "#ebdbb2",
          text = "#fbf1c7",
          subtext1 = "#ebdbb2",
          subtext0 = "#d5c4a1",
          overlay2 = "#bdae93",
          overlay1 = "#a89984",
          overlay0 = "#929181",
          surface2 = "#7c6f64",
          surface1 = "#665c54",
          surface0 = "#504945",
          base = "#32302f",
          mantle = "#282828",
          crust = "#1d2021",
        },
      },
      highlight_overrides = {
        mocha = function(mocha)
          return {
            TreesitterContextBottom = { sp = mocha.mantle, style = {} },
          }
        end,
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
}
