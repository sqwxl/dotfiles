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

  {
    "folke/edgy.nvim",
    enabled = false,
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      bottom = {
        -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
      },
    },
  },

  {
    "folke/which-key.nvim",
    lazy = true,
  },
}
