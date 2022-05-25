local map = vim.api.nvim_set_keymap
local noremap = { noremap = true }
local noremap_silent = { noremap = true, silent = true }

-- Remap space as leader key
map('', '<Space>', '<Nop>', noremap_silent)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap Esc
map('i', 'hh', '<Esc>', noremap)
map('c', 'hh', '<Esc>', noremap)
map('i', 'jf', '<Esc>', noremap)
map('c', 'jf', '<Esc>', noremap)
map('t', '<Esc>', '<C-\\><C-N>', noremap)

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

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
map('n', '<C-s>', ':w<CR>', noremap)
-- map('n', '<C-Q>', ':confirm quitall<CR>', noremap)
map('n', '<C-,>', ':tabnew<CR> :e ~/.config/nvim/init.lua<CR>', noremap)



-- LSP
if not vim.g.vscode then
  map('n', '<leader>t', ':NvimTreeToggle<CR>', noremap)

  map('i', '<F2>', '<cmd>lua require("renamer").rename()<CR>', noremap_silent)
  map('n', '<leader>r', '<cmd>lua require("renamer").rename()<CR>', noremap_silent)
  map('v', '<leader>r', '<cmd>lua require("renamer").rename()<CR>', noremap_silent)
end


map('n', '<leader>c', ':source ~/.config/nvim/init.lua<CR>', noremap)
