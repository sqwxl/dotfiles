return {
  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        css = { "prettierd" },
        fish = { "fish_indent" },
        go = { "gofmt" },
        html = { "prettierd", "rustywind" },
        htmldjango = { "djlint", "rustywind" },
        just = { "just" },
        lua = { "stylua" },
        markdown = { "prettierd" },
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
        sqlfluff = { args = { "format", "--dialect=postgres", "-" } },
        -- sql_formatter = { prepend_args = { "--language=postgresql" } },
        -- sqlfmt = { prepend_args = { "-l", "120" } },
      },
    },
  },
}
