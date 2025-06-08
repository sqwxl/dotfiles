return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { { "mason-org/mason.nvim" }, "neovim/nvim-lspconfig" },
    },
}
