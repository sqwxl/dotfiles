local map = vim.api.nvim_set_keymap

local noremap_silent = { noremap = true, silent = true }

map('n', '<leader>ff', [[<cmd>Telescope find_files<cr>]], noremap_silent)
map('n', '<leader>fb', [[<cmd>Telescope buffers show_all_buffers=true<cr>]], noremap_silent)
map('n', '<leader>fj', [[<cmd>Telescope live_grep<cr>]], noremap_silent)
map('n', '<leader>sh', [[<cmd>Telescope help_tags<cr>]], noremap_silent)
