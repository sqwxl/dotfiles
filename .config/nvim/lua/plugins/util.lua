return {
  {
    "tpope/vim-fugitive",
    event = "VimEnter",
    keys = { { "<C-g>", "<Cmd>Git<cr>", desc = "Git menu" } },
  },

  { "farmergreg/vim-lastplace" },

  -- {
  --   'rmagatti/auto-session',
  --   config = function()
  --     require("auto-session").setup {
  --       log_level = "error",
  --       auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
  --       pre_save_cmds = { function() vim.cmd('Neotree close') end }
  --     }
  --   end
  -- },

  -- {
}
