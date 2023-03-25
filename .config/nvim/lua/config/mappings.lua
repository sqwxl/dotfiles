local noremap_silent = { noremap = true, silent = true }

-- GENERAL
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("i", "<C-c>", "<Esc>", noremap_silent)
vim.keymap.set("t", "<Esc>", "<C-Bslash><C-n>")
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- NAVIGATION
-- move to start/end of line
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "$")
-- follow J-K order for paragraph jump
vim.keymap.set("", "{", "}", noremap_silent)
vim.keymap.set("", "}", "{", noremap_silent)
-- move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", noremap_silent)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", noremap_silent)
-- switch to last used buffer
vim.keymap.set("n", "<Leader><Leader>", ":b#<CR>", noremap_silent)
-- quickfix, locationlist navigation
vim.keymap.set("n", "<Leader>j", ":cnext<CR>zz")
vim.keymap.set("n", "<Leader>k", ":cprev<CR>zz")
vim.keymap.set("n", "<C-j>", ":lnext<CR>zz")
vim.keymap.set("n", "<C-k>", ":lprev<CR>zz")
-- tabs
vim.keymap.set("n", "<A-n>", ":tabnext<CR>", noremap_silent)
vim.keymap.set("n", "<A-t>", ":tabnew<CR>", noremap_silent)
vim.keymap.set("n", "<A-p>", ":tabprevious<CR>", noremap_silent)
-- windows
vim.keymap.set("n", "<A-h>", "<C-w>h", noremap_silent)
vim.keymap.set("n", "<A-j>", "<C-w>j", noremap_silent)
vim.keymap.set("n", "<A-k>", "<C-w>k", noremap_silent)
vim.keymap.set("n", "<A-l>", "<C-w>l", noremap_silent)
vim.keymap.set({ "t", "i" }, "<A-h>", "<C-Bslash><C-N><C-w>h", noremap_silent)
vim.keymap.set({ "t", "i" }, "<A-j>", "<C-Bslash><C-N><C-w>j", noremap_silent)
vim.keymap.set({ "t", "i" }, "<A-k>", "<C-Bslash><C-N><C-w>k", noremap_silent)
vim.keymap.set({ "t", "i" }, "<A-l>", "<C-Bslash><C-N><C-w>l", noremap_silent)
vim.keymap.set("n", "<Left>", "<C-w>h", noremap_silent)
vim.keymap.set("n", "<Down>", "<C-w>j", noremap_silent)
vim.keymap.set("n", "<Up>", "<C-w>k", noremap_silent)
vim.keymap.set("n", "<Right>", "<C-w>l", noremap_silent)
vim.keymap.set("t", "<Left>", "<C-Bslash><C-N><C-w>h", noremap_silent)
vim.keymap.set("t", "<Down>", "<C-Bslash><C-N><C-w>j", noremap_silent)
vim.keymap.set("t", "<Up>", "<C-Bslash><C-N><C-w>k", noremap_silent)
vim.keymap.set("t", "<Right>", "<C-Bslash><C-N><C-w>l", noremap_silent)
-- repeat movement with ,
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
-- ensure ; goes forward and , goes backward regardless of the last direction
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
-- vim way: goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
-- make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

-- EDITING
-- keep cursor pos when joining lines
vim.keymap.set("n", "J", "mzJ`z")
-- don't delete to register when pasting or deleting
vim.keymap.set("x", "<Leader>p", [["_dp]], noremap_silent)
vim.keymap.set("x", "<Leader>P", [["_dP]], noremap_silent)
vim.keymap.set({ "n", "v" }, "<Leader>d", [["_d]], noremap_silent)
-- replace word under cursor
vim.keymap.set("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- structural replace
vim.keymap.set("n", "<Leader>S", ":lua require('ssr').open()", noremap_silent)
-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<Leader>Y", [["+Y]])
-- macros
vim.keymap.set("n", "Q", "@q", noremap_silent)
-- copilot
-- vim.keymap.set("i", "<C-f>", function() require("copilot.suggestion").accept() end, noremap_silent)
-- vim.keymap.set("i", "<A-f>", function() require("copilot.suggestion").accept_word() end, noremap_silent)
-- vim.keymap.set("i", "<C-e>", function() require("copilot.suggestion").dismiss() end, noremap_silent)
-- fold/unfold table/array
vim.keymap.set("n", "<A-a>", vim.cmd.TSJToggle, noremap_silent)
-- documentation comment
vim.keymap.set("n", "gC", ":lua require('neogen').generate()<CR>", noremap_silent)
-- refactoring
vim.keymap.set("v", "<Leader>o", ":lua require('refactoring').select_refactor()<CR>", noremap_silent)
vim.keymap.set({ "n", "v" }, "<leader>ri", ":lua require('refactoring').refactor('Inline Variable')<CR>", noremap_silent)

-- UI
-- toggle wrap
vim.keymap.set("n", "<A-z>", ":set wrap!<CR>", noremap_silent)
-- toggle highlight
vim.keymap.set("n", "<Leader>h", ":set hlsearch!<CR>", noremap_silent)
-- file tree
vim.keymap.set("n", "<Bslash>", ":Neotree toggle=true position=right<CR>", noremap_silent)
vim.keymap.set("n", "<A-Bslash>", ":Neotree reveal=true position=right<CR>", noremap_silent)
-- windows
vim.keymap.set("n", "<Leader>z", vim.cmd.ZenMode, noremap_silent)
vim.keymap.set("n", "<Leader>m", vim.cmd.WindowsMaximize, noremap_silent)
-- toggle quickfix list
vim.keymap.set("n", "<Leader>q", "empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen<CR>' : ':cclose<CR>'", { expr = true, noremap = true })

-- PLUGIN COMMANDS
-- telescope
local telescope = require('telescope.builtin')
vim.keymap.set("n", "<Leader>u", function() telescope.find_files({ no_ignore = true }) end, {})
vim.keymap.set("n", "<C-p>", telescope.git_files, {})
vim.keymap.set("n", "<Leader>g", telescope.live_grep, {})
vim.keymap.set("n", "<Leader>b", telescope.buffers, {})
vim.keymap.set("n", "<Leader>i", telescope.help_tags, {})
vim.keymap.set("n", "<Leader>e", telescope.lsp_document_symbols, {})
-- document structure
vim.keymap.set("n", "<Leader>E", vim.cmd.SymbolsOutline, noremap_silent)
-- git
-- vim.keymap.set("n", "<Leader>v", vim.cmd.Git)
vim.keymap.set("n", "<Leader>$", function() vim.cmd.CellularAutomaton("make_it_rain") end)

-- LSP KEYMAPS
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'K', ":lua vim.lsp.buf.hover()<CR>", bufopts) -- keep rhs as string (see dap.lua)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>dq', vim.diagnostic.setqflist, bufopts)
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
  -- vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<Leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  -- end, bufopts)
  vim.keymap.set('n', '<A-F>', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- DAP
vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<Leader>dC', function() require('dap').terminate() end)
vim.keymap.set('n', '<Leader>dt', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dn', function() require('dap').step_over() end)
vim.keymap.set('n', '<Leader>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<Leader>do', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>du', function() require('dap').up() end)
vim.keymap.set('n', '<Leader>dd', function() require('dap').down() end)
-- vim.keymap.set('n', '<Leader>da', function() require('dapui').toggle() end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)


--- CMP KEYMAPS
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local luasnip = require("luasnip")

local cmp_mappings = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end,
    { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
    { "i", "s" }),
})

return {
  on_attach = on_attach,
  cmp_mappings = cmp_mappings,
}
