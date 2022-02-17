local map = vim.api.nvim_set_keymap
local noremap = {noremap = true}
local noremap_silent = {noremap = true, silent = true}

-- Remap space as leader key
map('', '<Space>', '<Nop>', noremap_silent)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap Esc
map('i', 'jf', '<Esc>', noremap)
map('c', 'jf', '<Esc>', noremap)
map('t', '<Esc>', '<C-\\><C-N>', noremap)

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", {noremap = true, expr = true, silent = true})
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", {noremap = true, expr = true, silent = true})

-- Undo breaks before deletes
map('i', '<C-U>', '<C-G>u<C-U>', noremap)
map('i', '<C-W>', '<C-G>u<C-W>', noremap)

-- Ergonomics
map('n', ';', ':', noremap)

map('n', 'H', '^', noremap)
map('n', 'L', '$', noremap)
map('v', 'H', '^', noremap)
map('v', 'L', '$', noremap)

map('n', 'Y', 'y$', noremap)
map('n', 'Q', '@q', noremap)
map('n', 'D', 'd$', noremap)

map('n', '<C-H>', '<C-W>h', noremap)
map('n', '<C-J>', '<C-W>j', noremap)
map('n', '<C-K>', '<C-W>k', noremap)
map('n', '<C-L>', '<C-W>l', noremap)

-- Move lines
map('n', '<A-j>', ':m .+1<CR>==', noremap)
map('n', '<A-k>', ':m .-2<CR>==', noremap)
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', noremap)
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', noremap)
map('v', '<A-j>', ':m \'>+1<CR>gv=gv', noremap)
map('v', '<A-k>', ':m \'<-2<CR>gv=gv', noremap)
map('n', '<Tab>', '>>', noremap)
map('v', '<Tab>', '>', noremap)
map('n', '<S-Tab>', '<<', noremap)
map('v', '<S-Tab>', '<', noremap)

-- Search
map('n', '?', [[?\v]], noremap)
map('n', '/', [[/\v]], noremap)
map('c', '%s/', '%sm/', noremap)
map('n', '<leader>h', ':noh<CR>', noremap_silent)

-- Show/hide hidden characters
map('n', '<leader>,', ':set invlist<CR>', noremap_silent)

-- Buffers
map('n', '<leader><space>', '<C-^>', noremap)
map('n', '<leader>n', ':bnext<CR>', noremap_silent)
map('n', '<leader>p', ':bprevious<CR>', noremap_silent)
map('n', '<C-X>', ':bwipeout<CR>', noremap_silent)

-- Write/quit
map('n', '<leader>w', ':w<CR>', noremap)
-- map('n', '<C-Q>', ':confirm quitall<CR>', noremap)
map('n', '<C-,>', ':tabnew<CR> :e ~/.config/nvim/init.lua<CR>', noremap)

map('n', '<leader>t', ':NvimTreeToggle<CR>', noremap)

map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], noremap_silent)
map('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], noremap_silent)
map('n', '<leader>fj', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], noremap_silent)
map('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], noremap_silent)
map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], noremap_silent)
map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], noremap_silent)

-- LSP
map('i', '<F2>', '<cmd>lua require("renamer").rename()<CR>', noremap_silent)
map('n', '<leader>r', '<cmd>lua require("renamer").rename()<CR>', noremap_silent)
map('v', '<leader>r', '<cmd>lua require("renamer").rename()<CR>', noremap_silent)

map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', noremap_silent)
map('n', 'J', '<cmd>lua vim.lsp.buf.code_action()<CR>', noremap_silent)
map('n', '<leader>k', '<cmd>lua vim.lsp.buf.declaration()<CR>', noremap_silent)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', noremap_silent)
map('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', noremap_silent)
map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', noremap_silent)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', noremap_silent)
map('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', noremap_silent)
map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', noremap_silent)
map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', noremap_silent)
map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', noremap_silent)
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', noremap_silent)

map('n', 'E', '<cmd>lua vim.diagnostic.open_float()<CR>', noremap_silent)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', noremap_silent)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', noremap_silent)
map('n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', noremap_silent)

map('n', '<leader>c', ':source ~/.config/nvim/init.lua<CR>', noremap)
