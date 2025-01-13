return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      -- remove shortcuts set by LazyVim (esp to restore C-l)
      opts.terminal.win.keys.nav_h = nil
      opts.terminal.win.keys.nav_j = nil
      opts.terminal.win.keys.nav_k = nil
      opts.terminal.win.keys.nav_l = nil
    end,
  },

  {
    "tpope/vim-fugitive",
    enabled = false,
    event = "VeryLazy",
    keys = { { "<C-g>", "<Cmd>Git<cr>", desc = "Git menu" } },
  },

  {
    "avm99963/vim-jjdescription",
    enabled = false,
  },

  {
    "rafikdraoui/jj-diffconflicts",
    enabled = false,
  },
}
