return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        css = { "stylelint" },
        fish = { "fish" },
        html = { "htmlhint" },
        htmldjango = { "djlint" },
        javascript = { "biomejs" },
        json = { "biomejs" },
        jsonc = { "biomejs" },
        markdown = { "markdownlint" },
        sass = { "stylelint" },
        sh = { "shellcheck" },
        sql = { "sqlfluff" },
        typescript = { "biomejs" },
        typescriptreact = { "biomejs" },
      },
      linters = {
        sqlfluff = { args = { "lint", "--format=json", "--dialect=postgres" } },
        stylelint = {
          stream = "stderr",
        },
      },
    },
  },
}
