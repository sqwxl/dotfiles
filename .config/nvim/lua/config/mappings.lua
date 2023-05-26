local noremap_silent = { noremap = true, silent = true }
local set = vim.keymap.set

-- GENERAL
set("n", ";", ":", { noremap = true })
set("i", "<C-c>", "<Esc>", noremap_silent)
set("t", "<Esc>", "<C-Bslash><C-n>")
set("n", "<C-s>", ":w<CR>")

-- NAVIGATION
-- move to start/end of line
set({ "n", "x", "o" }, "H", "^")
set({ "n", "x", "o" }, "L", "$")
-- follow J-K order for paragraph jump
set("", "{", "}", noremap_silent)
set("", "}", "{", noremap_silent)
-- move lines in visual mode
set("v", "J", ":m '>+1<CR>gv=gv", noremap_silent)
set("v", "K", ":m '<-2<CR>gv=gv", noremap_silent)
-- scroll
set("n", "<C-u>", "<C-u>zz", noremap_silent)
set("n", "<C-d>", "<C-d>zz", noremap_silent)
-- switch to last used buffer
set("n", "<Leader><Leader>", ":b#<CR>", noremap_silent)
-- quickfixlist
set("n", "<Leader>j", ":cnext<CR>zz")
set("n", "<Leader>k", ":cprev<CR>zz")
-- tabs
set("n", "<A-n>", ":tabnext<CR>", noremap_silent)
set("n", "<A-t>", ":tabnew<CR>", noremap_silent)
set("n", "<A-p>", ":tabprevious<CR>", noremap_silent)
-- windows
set("n", "<A-h>", "<C-w>h", noremap_silent)
set("n", "<A-j>", "<C-w>j", noremap_silent)
set("n", "<A-k>", "<C-w>k", noremap_silent)
set("n", "<A-l>", "<C-w>l", noremap_silent)
set({ "t", "i" }, "<A-h>", "<C-Bslash><C-N><C-w>h", noremap_silent)
set({ "t", "i" }, "<A-j>", "<C-Bslash><C-N><C-w>j", noremap_silent)
set({ "t", "i" }, "<A-k>", "<C-Bslash><C-N><C-w>k", noremap_silent)
set({ "t", "i" }, "<A-l>", "<C-Bslash><C-N><C-w>l", noremap_silent)
set("n", "<Left>", "<C-w>h", noremap_silent)
set("n", "<Down>", "<C-w>j", noremap_silent)
set("n", "<Up>", "<C-w>k", noremap_silent)
set("n", "<Right>", "<C-w>l", noremap_silent)
set("t", "<Left>", "<C-Bslash><C-N><C-w>h", noremap_silent)
set("t", "<Down>", "<C-Bslash><C-N><C-w>j", noremap_silent)
set("t", "<Up>", "<C-Bslash><C-N><C-w>k", noremap_silent)
set("t", "<Right>", "<C-Bslash><C-N><C-w>l", noremap_silent)
-- repeat movement with ,
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
-- ensure ; goes forward and , goes backward regardless of the last direction
-- set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
-- vim way: goes to the direction you were moving.
set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move)
-- set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
-- make builtin f, F, t, T also repeatable with ; and ,
set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

-- EDITING
-- keep cursor pos when joining lines
set("n", "J", "mzJ`z")
-- don't delete to register when pasting or deleting
set("x", "<Leader>p", [["_dp]], noremap_silent)
set("x", "<Leader>P", [["_dP]], noremap_silent)
set({ "n", "v" }, "<Leader>d", [["_d]], noremap_silent)
-- replace word under cursor
set("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- structural replace
set("n", "<Leader>S", ":lua require('ssr').open()", noremap_silent)
-- yank to clipboard
set({ "n", "v" }, "<Leader>y", [["+y]])
set({ "n", "v" }, "<Leader>Y", [["+Y]])
-- macros
set("n", "Q", "@q", noremap_silent)
-- copilot
-- set("i", "<C-f>", function() require("copilot.suggestion").accept() end, noremap_silent)
-- set("i", "<A-f>", function() require("copilot.suggestion").accept_word() end, noremap_silent)
-- set("i", "<C-e>", function() require("copilot.suggestion").dismiss() end, noremap_silent)
-- fold/unfold table/array
set("n", "<A-a>", vim.cmd.TSJToggle, noremap_silent)
-- documentation comment
set("n", "gC", ":lua require('neogen').generate()<CR>", noremap_silent)
-- refactoring
set("v", "<Leader>o", ":lua require('refactoring').select_refactor()<CR>", noremap_silent)
set({ "n", "v" }, "<leader>ri", ":lua require('refactoring').refactor('Inline Variable')<CR>", noremap_silent)
-- git
set("n", "<C-g>", vim.cmd.Git, noremap_silent)
set("n", "gu", "<cmd>diffget //2<CR>", noremap_silent)
set("n", "gh", "<cmd>diffget //3<CR>", noremap_silent)

-- UI
-- toggle wrap
set("n", "<A-z>", ":set wrap!<CR>", noremap_silent)
-- toggle highlight
set("n", "<Leader>h", ":set hlsearch!<CR>", noremap_silent)
-- file tree
set("n", "<Bslash>", ":Neotree toggle=true position=right<CR>", noremap_silent)
set("n", "<A-Bslash>", ":Neotree reveal=true position=right<CR>", noremap_silent)
-- windows
set("n", "<Leader>z", vim.cmd.ZenMode, noremap_silent)
set("n", "<Leader>m", vim.cmd.WindowsMaximize, noremap_silent)
-- toggle quickfix list
set("n", "<Leader>q", "empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen<CR>' : ':cclose<CR>'",
  { expr = true, noremap = true })

-- PLUGIN COMMANDS
-- telescope
local telescope = require('telescope.builtin')
set("n", "<Leader>u", function() telescope.find_files({ no_hidden = true }) end, {})
set("n", "<C-p>", telescope.git_files, {})
set("n", "<Leader>g", telescope.live_grep, {})
set("n", "<Leader>b", telescope.buffers, {})
set("n", "<Leader>i", telescope.help_tags, {})
set("n", "<Leader>e", telescope.lsp_document_symbols, {})
-- document structure
set("n", "<Leader>E", vim.cmd.SymbolsOutline, noremap_silent)
-- git
-- set("n", "<Leader>v", vim.cmd.Git)
set("n", "<Leader>$", function() vim.cmd.CellularAutomaton("make_it_rain") end)

-- LSP KEYMAPS
local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts)
  set('n', 'K', ":lua vim.lsp.buf.hover()<CR>", bufopts) -- keep rhs as string (see dap.lua)
  set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- open definition in vsplit
  set('n', 'gV', function()
    vim.cmd("vsplit")
    vim.lsp.buf.definition()
  end, bufopts)
  set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
  set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
  set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  set('n', 'gr', vim.lsp.buf.references, bufopts)
  set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
  set('n', '<Leader>dq', vim.diagnostic.setqflist, bufopts)
  set('n', 'gl', vim.diagnostic.open_float, bufopts)
  set("n", "[d", vim.diagnostic.goto_prev, bufopts)
  set("n", "]d", vim.diagnostic.goto_next, bufopts)
  -- set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- set('n', '<Leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  -- end, bufopts)
  set('n', '<A-F>', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- DAP
set('n', '<Leader>dc', function() require('dap').continue() end)
set('n', '<Leader>dC', function() require('dap').terminate() end)
set('n', '<Leader>dt', function() require('dap').toggle_breakpoint() end)
set('n', '<Leader>dn', function() require('dap').step_over() end)
set('n', '<Leader>di', function() require('dap').step_into() end)
set('n', '<Leader>do', function() require('dap').step_out() end)
set('n', '<Leader>du', function() require('dap').up() end)
set('n', '<Leader>dd', function() require('dap').down() end)
-- set('n', '<Leader>da', function() require('dapui').toggle() end)
set('n', '<Leader>dr', function() require('dap').repl.toggle() end)
set('n', '<Leader>dl', function() require('dap').run_last() end)
set({ 'n', 'v' }, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
set('n', '<Leader>df', function()
  -- Frames sidebar
  local widgets = require('dap.ui.widgets')
  widgets.sidebar(widgets.frames).open()
end)
set('n', '<Leader>ds', function()
  -- Scopes sidebar
  local widgets = require('dap.ui.widgets')
  widgets.sidebar(widgets.scopes).open()
end)


--- CMP KEYMAPS
-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local cmp = require("cmp")
local luasnip = require("luasnip")

local cmp_mappings = cmp.mapping.preset.insert({
  ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  ["<C-u>"] = cmp.mapping.scroll_docs(-4),
  ["<C-d>"] = cmp.mapping.scroll_docs(4),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-e>"] = cmp.mapping.close(),
  ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
  ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable_locally() then
        luasnip.expand_or_jump()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end,
    { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
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
