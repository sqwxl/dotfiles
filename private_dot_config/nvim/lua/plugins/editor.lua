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
        bind_to_cwd = true,
        cwd_target = {
          sidebar = "tab",
          current = "window",
        },
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
    lazy = true,
    version = "2.*",
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
      selection_chars = "aoeuidhtnsqjkxbmwvz",
      filter_rules = {
        bo = {
          filetype = { "neo-tree", "neo-tree-popup", "notify", "noice", "snacks_notif", "aerial" },
          buftype = { "terminal" },
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
    "ibhagwan/fzf-lua",
    opts = {
      fzf_opts = { ["--cycle"] = true },
      keymap = {
        builtin = {
          true,
          ["<c-u>"] = "preview-page-up",
          ["<c-d>"] = "preview-page-down",
        },
        fzf = {
          true,
          ["ctrl-u"] = "preview-page-up",
          ["ctrl-d"] = "preview-page-down",
        },
      },
    },
    keys = { { "<leader><space>", false } },
  },

  {
    "folke/flash.nvim",
    opts = {
      labels = "aoeuidhtnsqjkxbmwvzpyfgcrl",
      modes = {
        char = {
          char_actions = function(motion)
            return {
              [";"] = "prev",
              [","] = "next",
              [motion:lower()] = "next",
              [motion:upper()] = "prev",
            }
          end,
        },
      },
      jump = {
        autojump = true,
      },
    },
  },

  -- {
  --   "gbprod/yanky.nvim",
  -- },
}
