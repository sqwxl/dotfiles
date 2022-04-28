local telescope = require "telescope"

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    initial_mode = "insert",
    scroll_strategy = "cycle",
  },
  extensions = {
    frecency = {},
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
  pickers = {
    lsp_references = { theme = 'dropdown' },
    lsp_code_actions = { theme = 'dropdown' },
    lsp_definitions = { theme = 'dropdown' },
    lsp_implementations = { theme = 'dropdown' },
    buffers = {
      sort_lastused = true,
      previewer = false,
    },
  },
  mappings = {
    i = {
      ["<C-u>"] = false,
      ["<C-d>"] = false,
    },
  },
}

telescope.load_extension "frecency"
telescope.load_extension "fzf"
