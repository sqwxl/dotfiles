return {
  { "tpope/vim-fugitive" },

  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
      }
    }
  },

  {
    'folke/which-key.nvim',
    config = true
  },
}
