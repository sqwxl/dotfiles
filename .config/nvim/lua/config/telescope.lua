require"telescope".setup {
  defaults = {
    initial_mode = "insert",
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
}

require"telescope".load_extension "fzf"
require"telescope".load_extension "ui-select"

