return {
  {
    "tpope/vim-fugitive",
    event = "VimEnter",
    keys = { { "<C-g>", "<Cmd>Git<cr>", desc = "Git menu" } },
  },

  { "farmergreg/vim-lastplace" },

  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },

  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = true,
  },

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
