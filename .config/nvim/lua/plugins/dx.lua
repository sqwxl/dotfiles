return {
  {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end
  },

  {
    'rmagatti/auto-session',
    enabled = false,
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
        pre_save_cmds = { function() vim.cmd('Neotree close') end }
      }
    end
  },

  {
    "folke/trouble.nvim",
    lazy = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true
  },

  {
    "danymat/neogen", -- generate annotations
    lazy = true,
    opts = { snippet_engine = "luasnip" },
    dependencies = "nvim-treesitter/nvim-treesitter"
  },

  {
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim"
    },
    config = true
  },

  {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    dependencies = {
      {
        "kevinhwang91/promise-async",
      },
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup {
            segments = {
              {
                text = { builtin.foldfunc, " " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScFa"
              },
              { text = { "%s" },             click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
            }
          }
        end
      },
    },
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
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end
    },
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

  {
    "sheerun/vim-polyglot"
  }
}
