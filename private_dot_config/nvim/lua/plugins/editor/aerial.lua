return {
    "stevearc/aerial.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        show_guides = true,
        layout = {
            resize_to_content = false,
            win_opts = {
                winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
                signcolumn = "yes",
                statuscolumn = " ",
            },
        },
        guides = {
            mid_item   = "├╴",
            last_item  = "└╴",
            nested_top = "│ ",
            whitespace = "  ",
        },
    }
}
