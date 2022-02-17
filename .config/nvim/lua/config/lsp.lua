local lspconfig = require 'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require "cmp_nvim_lsp".update_capabilities(capabilities)

capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function()
    require "lsp_signature".on_attach()
    vim.cmd [[autocmd ColorScheme * :lua require('vim.diagnostic')._define_default_signs_and_highlights()]]
end

lspconfig.rust_analyzer.setup { on_attach = on_attach, capabilities = capabilities }

local luadev = require "lua-dev".setup {
  lspconfig = {
    cmd = { "lua-language-server"},
    capabilities = capabilities
  }
}

lspconfig.sumneko_lua.setup(luadev)

local servers = {"eslint", "jsonls", "cssls", "vimls", "gopls", "bashls", "pylsp", "rnix", "tsserver", "html"}
for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {debounce_text_changes = 150}
  })
end

-- lspconfig.efm.setup {
--     init_options = {documentFormatting = true},
--     filetypes = {"lua"},
--     settings = {
--         rootMarkers = {".git/"},
--         languages = {lua = {{formatCommand = "lua-format -i --column-limit=120", formatStdin = true}}}
--     }
-- }

