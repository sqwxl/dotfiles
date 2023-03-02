return {
  {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end
  },

  {
    'rmagatti/auto-session',
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
    }
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true
  },

  {
    "danymat/neogen", -- generate annotations
    opts = { snippet_engine = "luasnip" },
    dependencies = "nvim-treesitter/nvim-treesitter"
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim"
    },
    config = true
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",

    init = function()
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
  },
}
