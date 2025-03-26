require("plugins.lsp.config")()

return {
  {
    "williamboman/mason.nvim",
    opts = {
      -- PATH = "append", -- So that shell PATH will take precedence
      -- LSP servers are listed above, and are installed by mason-lspconfig; this is for linters & formatters.
      ensure_installed = {
        "biome",
        "djlint",
        "markdownlint",
        "prettierd",
        "rustywind",
        "shellcheck",
        "shfmt",
        "sqlfluff",
      },
    },
  },

  {
    "sqwxl/playdate.nvim",
    opts = {
      playdate_luacats_path = "~/Clones/playdate-luacats",
      server_settings = {
        Lua = {
          format = {
            defaultConfig = {
              call_arg_parentheses = "remove_string_only",
            },
          },
        },
      },
    },
  },
}
