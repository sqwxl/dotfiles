return {
  {
    "tpope/vim-fugitive",
    event = "VimEnter",
    keys = { { "<C-g>", "<Cmd>Git<cr>", desc = "Git menu" } },
  },

  -- {
  --   "farmergreg/vim-lastplace",
  --   init = function()
  --     vim.g.lastplace_ignore_buftype = { "quickfix", "nofile", "help" }
  --     vim.g.lastplace_ignore_filetype = { "neo-tree", "gitcommit", "gitrebase", "svn", "hgcommit" }
  --   end,
  -- },
}
