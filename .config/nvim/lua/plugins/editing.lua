return {
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-abolish" }, -- adds case-aware substitution via :S command
  { "tpope/vim-endwise" }, -- complete some structures like if -> end, do -> while
  { "tpope/vim-sleuth" }, -- dynamic 'shiftwidth' and 'expandtab' based on file

  {
    "Wansmer/treesj", -- fold/unfold "tree structures" like arrays and tables
    opts = {
      use_default_keymaps = false,
    }
  },

  { "numToStr/Comment.nvim", config = true },
  {
    "windwp/nvim-autopairs",
    opts = {
      check_ts = true
    }
  },

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    config = true,
  },

  { "cshuaimin/ssr.nvim" } -- structural find & replace
}
