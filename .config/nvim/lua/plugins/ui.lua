local logo = [[


  ██████   █████   ██  ██  ██░▒██   ██▒ ██▓    
▒██    ▒ ▒██▓  ██▒▓██░ ██ ░██░▒▒██ ██▒░▓██▒    
░ ▓██▄   ▒██▒  ██░▒██░ ██ ░██ ░░ ███  ░▒██░    
  ▒   ██▒░██  █▀ ░░░██ ███░██  ░██ ██▒ ▒██░    
▒██████▒▒░▒███▒█▄ ░░░▓██░▓██░ ▒██▒ ▒██▒░██████▒
▒ ▒▓▒ ▒ ░░░ ▒▒░ ▒ ░  ▓░▒  ▒   ▒▒ ░ ░▓ ░░ ▒░▓  ░
░ ░▒  ░ ░ ░ ▒░  ░    ▒ ░  ░   ░░   ░▒ ░░ ░ ▒  ░
░  ░  ░     ░   ░         ░    ░    ░    ░ ░   
      ░      ░         ░       ░    ░      ░  ░
                                            


]]
return {
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },

  {
    "stevearc/dressing.nvim",
    -- enabled = false
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
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = { enabled = true },
    },
  },

  {
    "echasnovski/mini.indentscope",
    enabled = false,
  },

  {
    "folke/which-key.nvim",
  },

  {
    "folke/noice.nvim",
    enabled = false,
    opts = {
      lsp = {
        progress = {
          enabled = false, -- use fidget.nvim instead
        },
      },
    },
  },

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {},
  },

  {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.header.opts.hl = "GruvboxGreen"
      for _, btn in ipairs(dashboard.section.buttons.val) do
        btn.opts.hl = "GruvboxBlue"
      end
      dashboard.section.buttons.val[#dashboard.section.buttons.val].opts.hl = "GruvboxRed"
      dashboard.section.footer.opts.hl = "GruvboxAqua"
    end,
  },

  {
    "SmiteshP/nvim-navic", -- lsp symbols in lualine
    enabled = false,
  },

  {
    "MunifTanjim/nui.nvim",
    -- enabled = false
  },

  -- {
  --   'glacambre/firenvim',
  --   enabled = false,
  --   lazy = false,
  --   build = function()
  --     require("lazy").load({ plugins = "firenvim", wait = true })
  --     vim.fn["firenvim#install"](0)
  --   end,
  --   cond = not not vim.g.started_by_firenvim,
  --   config = function()
  --     vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  --       pattern = "github.com_*.txt",
  --       cmd = "set filetype=markdown"
  --     })
  --   end
  --   -- explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  -- },

  -- {
  --   "j-hui/fidget.nvim",
  --   tag = "legacy",
  --   config = true,
  -- },

  {
    -- auto-resize windows
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      -- { "anuvyklack/animation.nvim" },
    },
    config = function()
      -- vim.o.winwidth = 10
      -- vim.o.winminwidth = 5
      -- vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
        ignore = {
          buftype = { "quickfix" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "help" },
        },
      })
    end,
    keys = { { "<Leader>wm", "<Cmd>WindowsMaximize<CR>", desc = "Maximize window" } },
  },

  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup({ "*" }, { names = false })
  --   end
  -- },

  --   {
  --     "petertriho/nvim-scrollbar",
  --     event = "BufReadPost",
  --     config = function()
  --       local scrollbar = require("scrollbar")
  --       local gruvbox_cfg = require("gruvbox").config
  --       local colors = require("gruvbox.palette").get_base_colors(vim.o.background, gruvbox_cfg.contrast)
  --       scrollbar.setup({
  --         handle = { color = colors.fg4 },
  --         excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
  --         marks = {
  --           Search = { color = colors.yellow },
  --           Error = { color = colors.red },
  --           Warn = { color = colors.yellow },
  --           Info = { color = colors.blue },
  --           Hint = { color = colors.aqua },
  --           Misc = { color = colors.purple },
  --         },
  --       })
  --     end,
  --   },
}
