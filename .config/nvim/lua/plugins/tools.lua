return {
  { "tpope/vim-fugitive" },

  {
    "zbirenbaum/copilot.lua",
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
