return {
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-abolish" }, -- adds case-aware substitution via :S command
  { "tpope/vim-sleuth" }, -- dynamic 'shiftwidth' and 'expandtab' based on file

  {
    "Wansmer/treesj", -- fold/unfold "tree structures" like arrays and tables
    cmd = "TSJToggle",
    opts = {
      use_default_keymaps = false,
    }
  },

  { "numToStr/Comment.nvim", config = true },

  {
    "windwp/nvim-autopairs",
    opts = {
      check_ts = true,
      enable_check_bracket_line = true,
      ignored_next_char = "[%w%.]",
      fast_wrap = {}, -- bound to <M-e> by default
    }
  },

  { "windwp/nvim-ts-autotag" },

  { "RRethy/nvim-treesitter-endwise" }, -- complete some structures like if -> end, do -> while

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = true,
  },

  { "cshuaimin/ssr.nvim", lazy = true } -- structural find & replace
}
