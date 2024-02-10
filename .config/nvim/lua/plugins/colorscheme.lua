return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox" },
  },

  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      local colors = require("gruvbox").palette
      require("gruvbox").setup({
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        dim_inactive = true,
        overrides = {
          -- CursorLine = { bg = colors.dark2 },
          NormalNC = { bg = "#2c2c2c" },
          TelescopeNormal = { bg = colors.dark0 },
          NeoTreeDirectoryName = { link = "GruvboxBlueBold" },
          NeoTreeDirectoryIcon = { link = "NeoTreeDirectoryName" },
          -- NeoTreeNormal = { fg = C.text, bg = active_bg },
          NeoTreeNormalNC = { bg = colors.dark0 },
          -- NeoTreeExpander = { fg = colors.light2 },
          -- NeoTreeIndentMarker = { fg = C.overlay0 },
          NeoTreeRootName = { fg = colors.bright_aqua, bold = true, italic = true },
          -- NeoTreeSymbolicLinkTarget = { fg = C.pink },
          NeoTreeModified = { fg = colors.neutral_green },
          -- NeoTreeCursorLine = { bg = colors.light1 },
          --
          NeoTreeGitAdded = { fg = colors.bright_green },
          -- NeoTreeGitConflict = { fg = C.red },
          -- NeoTreeGitDeleted = { fg = C.red },
          -- NeoTreeGitIgnored = { fg = C.overlay0 },
          -- NeoTreeGitModified = { fg = C.yellow },
          -- NeoTreeGitUnstaged = { fg = C.red },
          -- NeoTreeGitUntracked = { fg = C.mauve },
          -- NeoTreeGitStaged = { fg = C.green },
          --
          -- NeoTreeFloatBorder = { link = "FloatBorder" },
          -- NeoTreeFloatTitle = { link = "FloatTitle" },
          -- NeoTreeTitleBar = { fg = C.mantle, bg = C.blue },
          --
          -- NeoTreeFileNameOpened = { fg = C.pink },
          -- NeoTreeDimText = { fg = colors.light3 },
          NeoTreeFilterTerm = { fg = colors.bright_green, bold = true },
          -- NeoTreeTabActive = { bg = active_bg, fg = C.lavender, style = { "bold" } },
          -- NeoTreeTabInactive = { bg = inactive_bg, fg = C.overlay0 },
          -- NeoTreeTabSeparatorActive = { fg = active_bg, bg = active_bg },
          -- NeoTreeTabSeparatorInactive = { fg = inactive_bg, bg = inactive_bg },
          -- NeoTreeVertSplit = { fg = C.base, bg = inactive_bg },
          -- NeoTreeStatusLineNC = { fg = C.mantle, bg = C.mantle },
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
