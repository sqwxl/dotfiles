return function()
  vim.lsp.inlay_hint.enable(false)

  -- Bash
  vim.lsp.enabl("bashls")

  -- Python
  vim.lsp.config("basedpyright", {
    settings = {
      basedpyright = {
        disableOrganizeImports = true, -- Using Ruff
        disableTaggedHints = true, -- Using Ruff
        analysis = {
          autoImportCompletions = true,
          diagnosticSeverityOverrides = {
            reportUndefinedVariable = "none",
          },
        },
      },
    },
  })
  vim.lsp.enable("basedpyright")
  vim.lsp.config("ruff", { settings = { lineLength = { 120 } } })
  vim.lsp.enable("ruff")

  -- HTML
  vim.lsp.config("html", { filetypes = { "html", "htmldjango" } })
  vim.lsp.enable("html")
  vim.lsp.config("htmx", { filetypes = { "html", "htmldjango" } })
  vim.lsp.enable("htmx")

  -- Spelling
  vim.lsp.config("harper_ls", {
    settings = {
      ["harper-ls"] = {
        userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
        codeActions = { forceStable = true },
        linters = {
          avoid_curses = false,
        },
      },
    },
  })
  vim.lsp.enable("harper_ls")

  -- Lua
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        codelens = { enabled = false },
        diagnostics = {
          disable = { "redefined-local", "lowercase-global" },
        },
      },
    },
  })
  vim.lsp.enable("lua_ls")
end
