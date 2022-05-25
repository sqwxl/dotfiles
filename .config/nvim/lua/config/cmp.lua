local cmp = require 'cmp'
local luasnip = require 'luasnip'

local function check_backspace()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

local feedkeys = vim.fn.feedkeys
local replace_termcodes = vim.api.nvim_replace_termcodes
local backspace_keys = replace_termcodes('<tab>', true, true, true)
local snippet_next_keys = replace_termcodes('<plug>luasnip-expand-or-jump', true, true, true)
local snippet_prev_keys = replace_termcodes('<plug>luasnip-jump-prev', true, true, true)

local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

cmp.setup {
  completion = { completeopt = 'menu,menuone,noinsert' },
  sorting = {
    comparators = {
      -- function(entry1, entry2)
      --   local score1 = entry1.completion_item.score
      --   local score2 = entry2.completion_item.score
      --   if score1 and score2 then
      --     return (score1 - score2) < 0
      --   end
      -- end,

      -- The built-in comparators:
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      -- require('cmp-under-comparator').under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
      return vim_item
    end,
  },
  mapping = {
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<cr>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
    ['<tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        feedkeys(snippet_next_keys, '')
      elseif check_backspace() then
        feedkeys(backspace_keys, 'n')
      else
        fallback()
      end
    end,
    ['<s-tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        feedkeys(snippet_prev_keys, '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp_document_symbol' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'buffer' },
  },
}

-- cmp.setup.cmdline('/', {
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp_document_symbol' },
--   }, {
--     { name = 'buffer' },
--   }),
-- })
-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
--
-- local feedkey = function(key, mode)
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
-- end
--
--
-- cmp.setup({
--     snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body) end},
--     mapping = {
--         ['<C-D>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
--         ['<C-U>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
--         ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
--         ['<C-E>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
--         ['<CR>'] = cmp.mapping.confirm({select = true}),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif vim.fn["vsnip#available"](1) == 1 then
--                 feedkey("<Plug>(vsnip-expand-or-jump)", "")
--             elseif has_words_before() then
--                 cmp.complete()
--             else
--                 fallback()
--             end
--         end, {"i", "s"}),
--         ["<S-Tab>"] = cmp.mapping(function()
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif vim.fn["vsnip#jumpable"](-1) == 1 then
--                 feedkey("<Plug>(vsnip-jump-prev)", "")
--             end
--         end, {"i", "s"})
--     },
--     sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'vsnip'}}, {{name = 'buffer'}})
-- })
--
-- cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})
--
-- cmp.setup.cmdline(':', {sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})})

local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
