vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    opts = {
      window = {
        position = "right",
        mappings = {
              ["<cr>"] = "open_with_window_picker",
              ["s"] = "split_with_window_picker",
              ["v"] = "vsplit_with_window_picker"
        },
      },
      filesystem = {
        hijack_netrw_behavior = "open_current",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "v1.x",
    config = function()
      local colors = require("gruvbox.palette").get_base_colors(vim.o.background, require("gruvbox").config.contrast)
      require("window-picker").setup {
        selection_chars = "HUTENOSAIDYFPG.C,R;L", -- dvorak
        filter_rules = {
          bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            buftype = { "terminal", "quickfix" }
          }
        },
        fg_color = colors.fg0,
        other_win_hl_color = colors.blue,
      }
    end
  }
}
