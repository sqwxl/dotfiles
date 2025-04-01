return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    ---@type GruvboxConfig
    opts = {
        contrast = "", -- can be "hard", "soft" or empty string
        dim_inactive = false,
        transparent_mode = false,
        overrides = {
            NeoTreeDirectoryName = { link = "GruvboxBlueBold" },
            NeoTreeDirectoryIcon = { link = "NeoTreeDirectoryName" },
            NeoTreeRootName = { link = "GruvboxAquaBold" },
            NeoTreeModified = { link = "GruvboxYellow" },
            NeoTreeGitAdded = { link = "GruvboxOrange" },
            NeoTreeFilterTerm = { link = "GruvboxGreenBold" },
            WindowPickerStatusLine = { link = "GruvboxBlueBold" },
            WindowPickerStatusLineNC = { link = "GruvboxAqua" },
            WindowPickerWinBar = { link = "GruvboxBlueBold" },
            WindowPickerWinBarNC = { link = "GruvboxAqua" },
            -- Disable document highlights
            LspReferenceText = {},
            LspReferenceWrite = {},
            LspReferenceRead = {},
        },
    }
}
