local map = vim.api.nvim_set_keymap

local noremap_silent = { noremap = true, silent = true }

map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], noremap_silent)
map('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], noremap_silent)
map('n', '<leader>fj', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], noremap_silent)
map('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], noremap_silent)
map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], noremap_silent)
map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], noremap_silent)
