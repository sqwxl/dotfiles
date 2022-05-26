require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "css",
    "dockerfile",
    "fish",
    "glsl",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "nix",
    "pug",
    "python",
    "rust",
    "scss",
    "svelte",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = {
    enable = false,
    use_languagetree = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<enter>",
      node_incremental = "<enter>",
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = false,
  },
  matchup = {
    enable = true,
  },
  autotag = {
    enable = true,
  }
}
