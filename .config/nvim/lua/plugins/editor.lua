return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "left",
        mappings = {
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["<cr>"] = "open_with_window_picker",
          ["s"] = "split_with_window_picker",
          ["v"] = "vsplit_with_window_picker",
        },
      },
      filesystem = {
        -- bind_to_cwd = true,
        -- cwd_target = {
        --   sidebar = "global",
        -- },
        -- filtered_items = {},
      },
      event_handlers = {
        -- {
        --   event = "file_opened",
        --   handler = function(_)
        --     require("neo-tree.command").execute({ action = "close" })
        --   end,
        -- },
      },
      default_component_configs = {
        file_size = { enabled = false },
        last_modified = { enabled = false },
      },
    },
    keys = {
      { "<Bslash>", "<Cmd>Neotree toggle=true<CR>", noremap = true, desc = "Toggle Neotree" },
      { "<A-Bslash>", "<Cmd>Neotree reveal=true<CR>", desc = "Reveal in Neotree" },
    },
  },

  {
    "stevearc/aerial.nvim",
    opts = {
      layout = {
        placement = "window",
        default_direction = "right",
        resize_to_content = true,
        win_opts = {
          spell = false,
        },
      },
      attach_mode = "window",
      highlight_mode = "none",
    },
  },

  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
      selection_chars = "aoeuidhtnsqjkxbmwvz",
      filter_rules = {
        bo = {
          filetype = { "neo-tree", "neo-tree-popup", "notify", "noice" },
          buftype = { "terminal", "help" },
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

  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = {
  --     {
  --       "nvim-telescope/telescope-dap.nvim",
  --       build = "make",
  --       config = function()
  --         require("telescope").load_extension("dap")
  --       end,
  --     },
  --   },
  --   opts = {
  --     defaults = {
  --       layout_config = { prompt_position = "top" },
  --       sorting_strategy = "ascending",
  --       mappings = {
  --         i = {
  --           ["<C-t>"] = require("telescope.actions").select_tab,
  --           ["<C-h>"] = require("telescope.actions").preview_scrolling_left,
  --           ["<C-l>"] = require("telescope.actions").preview_scrolling_right,
  --         },
  --       },
  --     },
  --   },
  --   keys = { { "<Leader><Leader>", false } },
  -- },

  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        keymap = {
          builtin = {
            ["<c-u>"] = "preview-page-up",
            ["<c-d>"] = "preview-page-down",
          },
          fzf = {
            ["ctrl-u"] = "preview-page-up",
            ["ctrl-d"] = "preview-page-down",
          },
        },
      })
    end,
    keys = { { "<leader><space>", false } },
  },

  {
    "folke/flash.nvim",
    opts = {
      jump = {
        autojump = true,
      },
    },
  },

  {
    "folke/which-key.nvim",
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
