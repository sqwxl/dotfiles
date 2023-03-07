local noremap_silent = { noremap = true, silent = true }

vim.keymap.set("n", "<C-s>", ":w<CR>")

-- move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", noremap_silent)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", noremap_silent)

-- follow J-K order
vim.keymap.set("", "{", "}", noremap_silent)
vim.keymap.set("", "}", "{", noremap_silent)

-- keep cursor pos when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- quick indent
vim.keymap.set("n", ">", ">>")
vim.keymap.set("n", "<", "<<")

-- don't delete to register when pasting or deleting
vim.keymap.set("x", "<leader>p", [["_dp]], noremap_silent)
vim.keymap.set("x", "<leader>P", [["_dP]], noremap_silent)
vim.keymap.set("n", "<leader>d", [["_d]], noremap_silent)
vim.keymap.set("v", "<leader>d", [["_d]], noremap_silent)

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("i", "<C-c>", "<Esc>", noremap_silent)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- replace word under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("n", "Q", "@q", noremap_silent)

-- switch to last used buffer
vim.keymap.set("n", "<leader><leader>", ":b#<CR>", noremap_silent)

vim.keymap.set("n", "<leader>h", ":nohl<CR>", noremap_silent)

vim.keymap.set("n", "<M-z>", ":set wrap!<CR>", noremap_silent)

vim.keymap.set("n", "<leader>j", ":cnext<CR>zz")
vim.keymap.set("n", "<leader>k", ":cprev<CR>zz")
vim.keymap.set("n", "<C-j>", ":lnext<CR>zz")
vim.keymap.set("n", "<C-k>", ":lprev<CR>zz")

-- move around
vim.keymap.set("t", "<A-h>", "<C-\\><C-N><C-w>h", noremap_silent)
vim.keymap.set("t", "<A-j>", "<C-\\><C-N><C-w>j", noremap_silent)
vim.keymap.set("t", "<A-k>", "<C-\\><C-N><C-w>k", noremap_silent)
vim.keymap.set("t", "<A-l>", "<C-\\><C-N><C-w>l", noremap_silent)
vim.keymap.set("i", "<A-h>", "<C-\\><C-N><C-w>h", noremap_silent)
vim.keymap.set("i", "<A-j>", "<C-\\><C-N><C-w>j", noremap_silent)
vim.keymap.set("i", "<A-k>", "<C-\\><C-N><C-w>k", noremap_silent)
vim.keymap.set("i", "<A-l>", "<C-\\><C-N><C-w>l", noremap_silent)
vim.keymap.set("n", "<A-h>", "<C-w>h", noremap_silent)
vim.keymap.set("n", "<A-j>", "<C-w>j", noremap_silent)
vim.keymap.set("n", "<A-k>", "<C-w>k", noremap_silent)
vim.keymap.set("n", "<A-l>", "<C-w>l", noremap_silent)
vim.keymap.set("t", "<left>", "<C-\\><C-N><C-w>h", noremap_silent)
vim.keymap.set("t", "<down>", "<C-\\><C-N><C-w>j", noremap_silent)
vim.keymap.set("t", "<up>", "<C-\\><C-N><C-w>k", noremap_silent)
vim.keymap.set("t", "<right>", "<C-\\><C-N><C-w>l", noremap_silent)
vim.keymap.set("n", "<left>", "<C-w>h", noremap_silent)
vim.keymap.set("n", "<down>", "<C-w>j", noremap_silent)
vim.keymap.set("n", "<up>", "<C-w>k", noremap_silent)
vim.keymap.set("n", "<right>", "<C-w>l", noremap_silent)

-- PLUGIN COMMANDS
local telescope = require('telescope.builtin')
vim.keymap.set("n", "<leader>f", telescope.find_files, {})
vim.keymap.set("n", "<C-p>", telescope.git_files, {})
vim.keymap.set("n", "<leader>g", telescope.live_grep, {})
vim.keymap.set("n", "<leader>b", telescope.buffers, {})
vim.keymap.set("n", "<leader>t", telescope.help_tags, {})
vim.keymap.set("n", "<leader>s", telescope.lsp_document_symbols, {})

vim.keymap.set("n", "\\", ":Neotree toggle=true position=right<CR>", noremap_silent)
vim.keymap.set("n", "<A-\\>", ":Neotree reveal=true position=right<CR>", noremap_silent)

vim.keymap.set("i", "<C-f>", function() require("copilot.suggestion").accept() end, noremap_silent)
vim.keymap.set("i", "<A-f>", function() require("copilot.suggestion").accept_word() end, noremap_silent)
-- vim.keymap.set("i", "<C-e>", function() require("copilot.suggestion").dismiss() end, noremap_silent)

vim.keymap.set("n", "<leader>v", vim.cmd.Git)

vim.keymap.set("n", "<leader>l", vim.cmd.LspZeroFormat)

vim.keymap.set("n", "<leader>$", function() vim.cmd.CellularAutomaton("make_it_rain") end)

vim.keymap.set("n", "<leader>J", vim.cmd.TSJToggle, noremap_silent)                -- fold/unfold table/array

vim.keymap.set("n", "gC", ":lua require('neogen').generate()<CR>", noremap_silent) -- annotation comment

vim.keymap.set("v", "<leader>R", ":lua require('refactoring').select_refactor()<CR>", noremap_silent)

vim.keymap.set("n", "<leader>S", vim.cmd.SymbolsOutline, noremap_silent)

vim.keymap.set("n", "<leader>sR", ":lua require('ssr').open()", noremap_silent) -- structural repace

vim.keymap.set("n", "<leader>z", vim.cmd.ZenMode, noremap_silent)
vim.keymap.set("n", "<leader>m", vim.cmd.WindowsMaximize, noremap_silent)

-- LSP KEYMAPS
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, bufopts)
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, bufopts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
  -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  -- end, bufopts)
  -- vim.keymap.set('n', '<leader>l', function() vim.lsp.buf.format { async = true } end, bufopts)
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
