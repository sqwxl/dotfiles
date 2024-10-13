return {
  {
    "tpope/vim-fugitive",
    enabled = false,
    event = "VeryLazy",
    keys = { { "<C-g>", "<Cmd>Git<cr>", desc = "Git menu" } },
  },

  -- {
  --   "farmergreg/vim-lastplace",
  --   init = function()
  --     vim.g.lastplace_ignore_buftype = { "quickfix", "nofile", "help" }
  --     vim.g.lastplace_ignore_filetype = { "neo-tree", "gitcommit", "gitrebase", "svn", "hgcommit" }
  --   end,
  -- },

  {
    "avm99963/vim-jjdescription",
    enabled = false,
  },

  {
    "rafikdraoui/jj-diffconflicts",
    enabled = false,
  },
}
