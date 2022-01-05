require'telescope'.setup {
  defaults = {
    initial_mode = 'normal',
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

require'telescope'.load_extension 'fzf'

