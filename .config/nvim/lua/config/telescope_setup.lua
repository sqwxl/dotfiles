local map = vim.api.nvim_set_keymap

local noremap_silent = { noremap = true, silent = true }

map('n', '<leader>uu', [[<cmd>Telescope find_files<cr>]], noremap_silent)
map('n', '<leader>ub', [[<cmd>Telescope buffers show_all_buffers=true<cr>]], noremap_silent)
map('n', '<leader>ug', [[<cmd>Telescope live_grep<cr>]], noremap_silent)
map('n', '<leader>uh', [[<cmd>Telescope help_tags<cr>]], noremap_silent)
