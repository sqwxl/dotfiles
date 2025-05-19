return {
    "stevearc/conform.nvim",
    lazy = true,
    cmd = "ConformInfo",
    ---@type conform.setupOpts
    opts = {
        default_format_opts = {
            timeout_ms = 3000,
            async = false,           -- not recommended to change
            quiet = false,           -- not recommended to change
            lsp_format = "fallback", -- not recommended to change
        },
        format_after_save = {
            async = true,
            lsp_format = "fallback",
            stop_after_first = true,
        },
        notify_on_error = true,
        formatters_by_ft = {
            css = { "prettierd" },
            dockerfile = { "hadolint" },
            fish = { "fish_indent" },
            go = { "gofmt" },
            html = { "prettierd", "rustywind" },
            htmldjango = { "djlint", "rustywind" },
            jinja = { "djlint" },
            just = { "just" },
            -- lua = { "stylua" },
            markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
            ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
            nix = { "alejandra" },
            php = { "pint" },
            scss = { "prettierd" },
            sh = { "shfmt" },
            sql = { "sqlfluff" },
            toml = { "taplo" },
            javascript = { "biome-check" },
            javascriptreact = { "biome-check" },
            json = { "biome-check" },
            jsonc = { "biome-check" },
            typescript = { "biome-check" },
            ["typescript.tsx"] = { "biome-check" },
            typescriptreact = { "biome-check" },
            xml = { "xmlformat" },
            yaml = { "yamlfix" },
        },
        formatters = {
            injected = { options = { ignore_errors = true } },
            sqlfluff = { args = { "format", "--dialect=postgres", "-" } },
            ["markdownlint-cli2"] = {
                condition = function(_, ctx)
                    local diag = vim.tbl_filter(function(d)
                        return d.source == "markdownlint"
                    end, vim.diagnostic.get(ctx.buf))
                    return #diag > 0
                end,
            },
        },
    },
}
