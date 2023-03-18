local noremap_silent = { noremap = true, silent = true }

-- Escape from monkey island
vim.keymap.set("i", "<C-c>", "<Esc>", noremap_silent)
vim.keymap.set("t", "<Esc>", "<C-Bslash><C-n>")
vim.keymap.set("n", "<C-s>", ":w<CR>")

-- move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", noremap_silent)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", noremap_silent)

-- follow J-K order
vim.keymap.set("", "{", "}", noremap_silent)
vim.keymap.set("", "}", "{", noremap_silent)

-- keep cursor pos when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- move to start and end of line
vim.keymap.set({"n", "x", "o"}, "H", "^")
vim.keymap.set({"n", "x", "o"}, "L", "$")

-- don't delete to register when pasting or deleting
vim.keymap.set("x", "<Leader>p", [["_dp]], noremap_silent)
vim.keymap.set("x", "<Leader>P", [["_dP]], noremap_silent)
vim.keymap.set({ "n", "v" }, "<Leader>d", [["_d]], noremap_silent)

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<Leader>Y", [["+Y]])

-- replace word under cursor
vim.keymap.set("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("n", "Q", "@q", noremap_silent)

-- switch to last used buffer
vim.keymap.set("n", "<Leader><Leader>", ":b#<CR>", noremap_silent)

-- vim.keymap.set("n", "<Leader>h", ":nohl<CR>", noremap_silent) -- change mapping if uncomment

vim.keymap.set("n", "<A-z>", ":set wrap!<CR>", noremap_silent)

vim.keymap.set("n", "<Leader>j", ":cnext<CR>zz")
vim.keymap.set("n", "<Leader>k", ":cprev<CR>zz")
vim.keymap.set("n", "<C-j>", ":lnext<CR>zz")
vim.keymap.set("n", "<C-k>", ":lprev<CR>zz")

-- tabs
vim.keymap.set("n", "<A-n>", ":tabnext<CR>", noremap_silent)

-- move around
vim.keymap.set("n", "<A-t>", ":tabnew<CR>", noremap_silent)
vim.keymap.set("n", "<A-p>", ":tabprevious<CR>", noremap_silent)
vim.keymap.set("t", "<A-h>", "<C-Bslash><C-N><C-w>h", noremap_silent)
vim.keymap.set("t", "<A-j>", "<C-Bslash><C-N><C-w>j", noremap_silent)
vim.keymap.set("t", "<A-k>", "<C-Bslash><C-N><C-w>k", noremap_silent)
vim.keymap.set("t", "<A-l>", "<C-Bslash><C-N><C-w>l", noremap_silent)
vim.keymap.set("i", "<A-h>", "<C-Bslash><C-N><C-w>h", noremap_silent)
vim.keymap.set("i", "<A-j>", "<C-Bslash><C-N><C-w>j", noremap_silent)
vim.keymap.set("i", "<A-k>", "<C-Bslash><C-N><C-w>k", noremap_silent)
vim.keymap.set("i", "<A-l>", "<C-Bslash><C-N><C-w>l", noremap_silent)
vim.keymap.set("n", "<A-h>", "<C-w>h", noremap_silent)
vim.keymap.set("n", "<A-j>", "<C-w>j", noremap_silent)
vim.keymap.set("n", "<A-k>", "<C-w>k", noremap_silent)
vim.keymap.set("n", "<A-l>", "<C-w>l", noremap_silent)
vim.keymap.set("t", "<Left>", "<C-Bslash><C-N><C-w>h", noremap_silent)
vim.keymap.set("t", "<Down>", "<C-Bslash><C-N><C-w>j", noremap_silent)
vim.keymap.set("t", "<Up>", "<C-Bslash><C-N><C-w>k", noremap_silent)
vim.keymap.set("t", "<Right>", "<C-Bslash><C-N><C-w>l", noremap_silent)
vim.keymap.set("n", "<Left>", "<C-w>h", noremap_silent)
vim.keymap.set("n", "<Down>", "<C-w>j", noremap_silent)
vim.keymap.set("n", "<Up>", "<C-w>k", noremap_silent)
vim.keymap.set("n", "<Right>", "<C-w>l", noremap_silent)

-- PLUGIN COMMANDS
local telescope = require('telescope.builtin')
vim.keymap.set("n", "<Leader>h", function() telescope.find_files({ no_ignore = true }) end, {})
vim.keymap.set("n", "<C-p>", telescope.git_files, {})
vim.keymap.set("n", "<Leader>g", telescope.live_grep, {})
vim.keymap.set("n", "<Leader>b", telescope.buffers, {})
vim.keymap.set("n", "<Leader>t", telescope.help_tags, {})
vim.keymap.set("n", "<Leader>n", telescope.lsp_document_symbols, {})

vim.keymap.set("n", "<Bslash>", ":Neotree toggle=true position=right<CR>", noremap_silent)
vim.keymap.set("n", "<A-Bslash>", ":Neotree reveal=true position=right<CR>", noremap_silent)

vim.keymap.set("i", "<C-f>", function() require("copilot.suggestion").accept() end, noremap_silent)
vim.keymap.set("i", "<A-f>", function() require("copilot.suggestion").accept_word() end, noremap_silent)
-- vim.keymap.set("i", "<C-e>", function() require("copilot.suggestion").dismiss() end, noremap_silent)

vim.keymap.set("n", "<Leader>v", vim.cmd.Git)
vim.keymap.set("n", "<Leader>l", vim.lsp.buf.format)
vim.keymap.set("n", "<Leader>F", vim.cmd.TSJToggle, noremap_silent)                -- fold/unfold table/array
vim.keymap.set("n", "gC", ":lua require('neogen').generate()<CR>", noremap_silent) -- annotation comment
vim.keymap.set("n", "<Leader>S", vim.cmd.SymbolsOutline, noremap_silent)
vim.keymap.set("v", "<Leader>R", ":lua require('refactoring').select_refactor()<CR>", noremap_silent)
vim.keymap.set("n", "<Leader>sR", ":lua require('ssr').open()", noremap_silent) -- structural repace

vim.keymap.set("n", "<Leader>z", vim.cmd.ZenMode, noremap_silent)
vim.keymap.set("n", "<Leader>m", vim.cmd.WindowsMaximize, noremap_silent)

vim.keymap.set("n", "<Leader>$", function() vim.cmd.CellularAutomaton("make_it_rain") end)


-- TREESITTER
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

vim.keymap.set("n", "<A-n>", function()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()
  print("hello")
  print(node:type())
  ts_utils.goto_node(node:next_sibling(), false, true)
end, noremap_silent)

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

-- LSP KEYMAPS
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>dq', vim.diagnostic.setqflist, bufopts)
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
  vim.keymap.set("n", "]D", vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
  -- vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<Leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  -- end, bufopts)
  -- vim.keymap.set('n', '<Leader>l', function() vim.lsp.buf.format { async = true } end, bufopts)
end


--- CMP KEYMAPS
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = {
      ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
      ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-c>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif vim.fn["vsnip#available"](1) == 1 then
      feedkey("<Plug>(vsnip-expand-or-jump)", "")
    elseif has_words_before() then
      cmp.complete()
    else
      fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
  end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_prev_item()
    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      feedkey("<Plug>(vsnip-jump-prev)", "")
    end
  end, { "i", "s" }),
}

return {
  on_attach = on_attach,
  cmp_mappings = cmp_mappings,
}
