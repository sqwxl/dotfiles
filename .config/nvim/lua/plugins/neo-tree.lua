vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    opts = {
      window = {
        position = "right",
      },
      mappings = {
        ["<cr>"] = "open_with_window_picker",
        ["s"] = "split_with_window_picker",
        ["v"] = "vsplit_with_window_picker"
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
    opts = {
      selection_chars = "hutenosaidyfpg.c,r;l", -- dvorak
    }
  }
}
