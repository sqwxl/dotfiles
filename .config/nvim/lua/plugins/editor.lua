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
      filesystem = {
        filtered_items = {},
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(_)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
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
            ["<C-t>"] = require("telescope.actions").select_tab,
            ["<C-h>"] = require("telescope.actions").preview_scrolling_left,
            ["<C-l>"] = require("telescope.actions").preview_scrolling_right,
          },
        },
      },
    },
    keys = { { "<Leader><Leader>", false } },
  },

  {
    "folke/which-key.nvim",
  },

  {
    "folke/flash.nvim",
    opts = {
      modes = { search = { enabled = false } }, -- disable using flash for regular search
    },
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
}
