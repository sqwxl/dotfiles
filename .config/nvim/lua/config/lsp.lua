local lspconfig = require 'lspconfig'

local noremap_silent = { noremap = true, silent = true }
local map = vim.api.nvim_buf_set_keymap

local function on_attach(client)
    vim.cmd [[autocmd ColorScheme * :lua require('vim.diagnostic')._define_default_signs_and_highlights()]]
    map(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', noremap_silent)
    map(0, 'n', 'J', '<cmd>lua vim.lsp.buf.code_action()<CR>', noremap_silent)
    map(0, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.declaration()<CR>', noremap_silent)
    map(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', noremap_silent)
    map(0, 'n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', noremap_silent)
    map(0, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', noremap_silent)
    map(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', noremap_silent)
    map(0, 'n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', noremap_silent)
    map(0, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', noremap_silent)
    map(0, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', noremap_silent)
    map(0, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', noremap_silent)
    map(0, 'n', 'E', '<cmd>lua vim.diagnostic.open_float()<CR>', noremap_silent)
    map(0, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', noremap_silent)
    map(0, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', noremap_silent)
    map(0, 'n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', noremap_silent)

    if client.server_capabilities.documentFormattingProvider then
      map(0, 'n', '<M-F>', '<cmd>lua vim.lsp.buf.format()<cr>', noremap_silent)
    end

end


local servers = {
  clangd = {},
  eslint = { cmd = { 'vscode-eslint-language-server', '--stdio' }},
  jsonls = { cmd = { 'vscode-json-language-server', '--stdio' } },
  cssls = {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less', 'sass' },
    root_dir = lspconfig.util.root_pattern('package.json', '.git'),
  },
  gopls = {},
  bashls = {},
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          black = {
            enabled = true
          }
        }
      }
    }
  },
  rnix = {},
  html = { cmd = { 'vscode-html-language-server', '--stdio' }},
  sumneko_lua = {
    settings = {
      cmd = { 'lua-language-server' },
      Lua = {
        diagnostics = { globals = { 'vim' } },
        runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        }
      }
    }
  },
  rust_analyzer = {},
  tsserver = {},
  vimls = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' }
}
capabilities = require "cmp_nvim_lsp".update_capabilities(capabilities)

for server, config in pairs(servers) do
  if type(config) == 'function' then
    config = config()
  end

  config.on_attach = on_attach
  config.capabilities = vim.tbl_deep_extend(
    'keep',
    config.capabilities or {},
    capabilities
  )

  lspconfig[server].setup(config)
end

-- lspconfig.efm.setup {
--     init_options = {documentFormatting = true},
--     filetypes = {"lua"},
--     settings = {
--         rootMarkers = {".git/"},
--         languages = {lua = {{formatCommand = "lua-format -i --column-limit=120", formatStdin = true}}}
--     }
-- }

