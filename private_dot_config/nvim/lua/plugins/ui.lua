local header = [[
                                _
   __      __     __   __  __ /\_\
 / __ ︡   / ‗‗ ︡  / __ ︡ /\ \/\ \\/\ \  / __ ︡ __ ︡
/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \
\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
 \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
 ]]

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = { header = "" },
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      stages = {
        function(state)
          local next_height = state.message.height + 1
          local next_row = require("notify.stages.util").available_slot(
            state.open_windows,
            next_height,
            require("notify.stages.util").DIRECTION.BOTTOM_UP
          )
          if not next_row then
            return nil
          end
          return {
            relative = "editor",
            anchor = "NE",
            width = state.message.width,
            height = state.message.height,
            col = 1,
            row = next_row - 2,
            border = "rounded",
            style = "minimal",
            opacity = 0,
          }
        end,
        function()
          return {
            opacity = { 100 },
            col = { 1 },
          }
        end,
        function()
          return {
            col = { 1 },
            time = true,
          }
        end,
        function()
          return {
            opacity = {
              0,
              frequency = 2,
              complete = function(cur_opacity)
                return cur_opacity <= 4
              end,
            },
            col = { 1 },
          }
        end,
      },
    },
  },

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
    "SmiteshP/nvim-navic", -- lsp symbols in lualine
    enabled = false,
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
