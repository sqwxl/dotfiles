return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        css = { "stylelint" },
        fish = { "fish" },
        html = { "htmlhint" },
        htmldjango = { "djlint" },
        -- javascript = { "biomejs" },
        json = { "biomejs" },
        jsonc = { "biomejs" },
        -- markdown = { "markdownlint" },
        sass = { "stylelint" },
        sh = { "shellcheck" },
        sql = { "sqlfluff" },
        -- typescript = { "biomejs" },
        -- typescriptreact = { "biomejs" },
        -- ["*"] = { "cspell" },
      },
      linters = {
        sqlfluff = { args = { "lint", "--format=json", "--dialect=postgres" } },
        stylelint = {
          stream = "stderr",
        },
        cspell = {
          args = {
            "lint",
            "-c",
            vim.env.HOME .. "/.config/cspell/cspell.yaml",
            "--no-color",
            "--no-progress",
            "--no-summary",
          },
        },
      },
    },
  },
}
