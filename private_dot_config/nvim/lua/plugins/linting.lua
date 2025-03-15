return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        css = { "stylelint" },
        fish = { "fish" },
        html = { "htmlhint" },
        htmldjango = { "djlint" },
        -- markdown = { "markdownlint" },
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
        linters = {
          selene = {
            condition = function(ctx)
              local root = LazyVim.root.get({ normalize = true })
              if root ~= vim.uv.cwd() then
                return false
              end
              return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
            end,
          },
          luacheck = {
            condition = function(ctx)
              local root = LazyVim.root.get({ normalize = true })
              if root ~= vim.uv.cwd() then
                return false
              end
              return vim.fs.find({ ".luacheckrc" }, { path = root, upward = true })[1]
            end,
          },
        },
      },
    },
  },
}
