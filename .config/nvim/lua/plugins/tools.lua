return {
  { "tpope/vim-fugitive" },

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      panel = {
        keymap = { open = "<A-CR>" }
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-f>",
          accept_word = "<A-f>",
          dismiss = "<C-e>"
        }
      },
    },
  },

  {
    'folke/which-key.nvim',
    enabled = false,
    config = true,
  },

  {
    -- markdown previewer
    "toppair/peek.nvim",
    enabled = false, -- doesn't work on windows, tbd gnome
    build = "deno task --quiet build:fast",
  },

}
