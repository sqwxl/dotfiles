return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
  },

  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = true,
      },
      routes = {
        {
          view = "cmdline",
          filter = { event = "msg_showmode" },
        },
      },
      views = {
        cmdline_popup = {
          position = "50%",
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            winblend = 10,
          },
        },
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
        ______ _____ ______ __  __ __ __________ 
       /\  __ \\  __\\  __ \\ \/\ \\_\\  __  __ \
       \ \ \/\ \\  __\\ \_\ \\ \/ |/\ \\ \/\ \/\ \
        \ \_\ \_\\____\\_____\\__/ \ \_\\_\ \_\ \_\
         \/_/\/_//____//____/\/_/   \/_//_/\/_/\/_/]],
        },
        formats = {
          header = { "%s", align = "left" },
        },
      },
      input = {
        win = {
          keys = {
            -- i_del_word = { "<C-w>", "delete_word", mode = "i" },
          },
          actions = {
            delete_word = function()
              vim.cmd("normal! diw<cr><right>")
            end,
          },
        },
      },
    },
  },

  {
    -- auto-resize windows
    "anuvyklack/windows.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      { "anuvyklack/middleclass" },
      -- { "anuvyklack/animation.nvim" },
    },
    opts = {
      animation = { enable = false },
      ignore = {
        buftype = { "quickfix", "help" },
        filetype = { "aerial", "neo-tree", "undotree", "gundo", "help" },
      },
    },
    keys = { { "<C-w>m", "<Cmd>WindowsMaximize<CR>", desc = "Maximize window" } },
  },
}
