local lsp = require('lsp-zero')
lsp.preset('recommended')


lsp.ensure_installed({
  'tsserver',
  'lua_ls',
  'rust_analyzer',
  'pylsp'
})

-- disable pyright
-- lsp.skip_server_setup("pyright")
lsp.configure("pyright", {
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        useLibraryCodeForTypes = true
      }
    }
  }
})
-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
lsp.skip_server_setup("pylsp")
-- lsp.configure("pylsp", {
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           maxLineLength = 110
--         }
--       }
--     }
--   }
-- })
--

lsp.skip_server_setup("efm")

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

-- Initialize rust_analyzer with rust-tools
lsp.skip_server_setup({ "rust_analyzer" })
require("rust-tools").setup({ server = lsp.build_options("rust_analyzer", {}) })

lsp.set_preferences({
  suggest_lsp_servers = false,
})

local mappings = require("config.mappings")

lsp.setup_nvim_cmp({
  mappings = lsp.defaults.cmp_mappings(mappings.cmp_mappings)
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()


lsp.on_attach(mappings.on_attach)

lsp.setup()

-- disabel copilot suggestion when completion menu is opened
local cmp = require("cmp")
cmp.event:on("menu_opened", function()
  vim.b.copilot_suggestion_hidden = true
end)
cmp.event:on("menu_closed", function()
  vim.b.copilot_suggestion_hidden = false
end)

vim.diagnostic.config({
  virtual_text = true
})
