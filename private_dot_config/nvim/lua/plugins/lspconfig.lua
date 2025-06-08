return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {{"mason-org/mason.nvim", opts = {}}, "neovim/nvim-lspconfig"},
    }
}
