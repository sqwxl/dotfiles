return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
        mappings = {
          ["<cr>"] = "open_with_window_picker",
          ["s"] = "split_with_window_picker",
          ["v"] = "vsplit_with_window_picker",
        },
      },
      -- filesystem = {
      --   hijack_netrw_behavior = "open_current",
      -- },
    },
    keys = {
      { "<Bslash>", "<Cmd>Neotree toggle=true position=right<CR>", noremap = true, desc = "Toggle Neotree" },
      { "<A-Bslash>", "<Cmd>Neotree reveal=true position=right<CR>", desc = "Reveal in Neotree" },
    },
  },

  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    version = "2.*",
    opts = {
      selection_chars = "AOEUIDHTNS", -- dvorak home row
      filter_rules = {
        bo = {
          filetype = { "neo-tree", "neo-tree-popup", "notify" },
          buftype = { "terminal", "quickfix" },
        },
      },
      highlights = {
        statusline = {
          focused = "WindowPickerStatusLine",
          unfocused = "WindowPickerStatusLineNC",
        },
        winbar = {
          focused = "WindowPickerWinBar",
          unfocused = "WindowPickerWinBarNC",
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "nvim-telescope/telescope-dap.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("dap")
        end,
      },
    },
    opts = {
      defaults = {
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-d>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-u>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
        },
      },
    },
    keys = {
      { "<Leader><Leader>", false },
      -- { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git files"},
      -- { "<Leader>g", "<cmd>Telescope live_grep<cr>",decs = "Live grep"},
      -- { "<Leader>o", "<cmd>Telescope oldfiles<cr>", desc = "Open recent files"},
      -- { "<Leader>b", "<cmd>Telescope buffers<cr>", desc = "Open buffers"},
      -- { "<Leader>i", "<cmd>Telescope help_tags<cr>", desc = "Help tags"},
    },
  },

  {
    "folke/which-key.nvim",
  },

  {
    "RRethy/vim-illuminate",
    enabled = false,
  },

  {
    "folke/trouble.nvim",
    -- enabled = false,
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
    keys = {
      { "<Leader>z", "<Cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
    },
  },

  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = {
  --     {
  --       "kevinhwang91/promise-async",
  --     },
  --     {
  --       "luukvbaal/statuscol.nvim",
  --       config = function()
  --         local builtin = require("statuscol.builtin")
  --         require("statuscol").setup {
  --           segments = {
  --             {
  --               text = { builtin.foldfunc, " " },
  --               condition = { true, builtin.not_empty },
  --               click = "v:lua.ScFa"
  --             },
  --             { text = { "%s" },             click = "v:lua.ScSa" },
  --             { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
  --           }
  --         }
  --       end
  --     },
  --   },
  --   event = "BufReadPost",
  --   init = function()
  --     -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  --     vim.keymap.set("n", "zR", function()
  --       require("ufo").openAllFolds()
  --     end)
  --     vim.keymap.set("n", "zM", function()
  --       require("ufo").closeAllFolds()
  --     end)
  --   end,
  --   opts = {
  --     provider_selector = function(bufnr, filetype, buftype)
  --       return { 'treesitter', 'indent' }
  --     end
  --   },
  -- },
}
