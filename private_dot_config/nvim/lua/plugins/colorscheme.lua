return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = function(_, opts)
        local colors = require("gruvbox").palette
        vim.tbl_deep_extend('force', opts, {
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
}
