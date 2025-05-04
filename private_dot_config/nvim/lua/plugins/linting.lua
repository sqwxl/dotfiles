return {
    "mfussenegger/nvim-lint",
    opts = {
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
            text = nil,
            css = { "stylelint" },
            fish = { "fish" },
            html = { "htmlhint" },
            htmldjango = { "djlint" },
            markdown = { "markdownlint-cli2" },
            sass = { "stylelint" },
            sh = { "shellcheck" },
            sql = { "sqlfluff" },
            json = { "biomejs" },
            jsonc = { "biomejs" },
            javascript = { "biomejs" },
            javascriptreact = { "biomejs" },
            typescript = { "biomejs" },
            typescriptreact = { "biomejs" },
            -- lua = { "selene", "luacheck" },
            -- ["*"] = { "cspell" },
        },
        linters = {
            sqlfluff = { args = { "lint", "--format=json", "--dialect=postgres" } },
            stylelint = {
                stream = "stderr",
            },
            -- cspell = {
            --   args = {
            --     "lint",
            --     "-c",
            --     vim.env.HOME .. "/.config/cspell/cspell.yaml",
            --     "--no-color",
            --     "--no-progress",
            --     "--no-summary",
            --   },
            -- },
        },
    },
    config = function(_, opts)
        vim.cmd [[au BufWritePost * lua require('lint').try_lint()]]
    end,
}
