return {
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
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
    },
  },

  {
    "echasnovski/mini.indentscope",
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

  -- {
  --   "goolord/alpha-nvim",
  --   enable = false,
  --   opts = function(_, dashboard)
  --     dashboard.section.header.val = vim.split(logo, "\n")
  --     dashboard.section.header.opts.hl = "GruvboxGreen"
  --     for _, btn in ipairs(dashboard.section.buttons.val) do
  --       btn.opts.hl = "GruvboxBlue"
  --     end
  --     dashboard.section.buttons.val[#dashboard.section.buttons.val].opts.hl = "GruvboxRed"
  --     dashboard.section.footer.opts.hl = "GruvboxAqua"
  --   end,
  --   config = function(_, dashboard)
  --     -- close Lazy and re-open when the dashboard is ready
  --     if vim.o.filetype == "lazy" then
  --       vim.cmd.close()
  --       vim.api.nvim_create_autocmd("User", {
  --         pattern = "AlphaReady",
  --         callback = function()
  --           require("lazy").show()
  --         end,
  --       })
  --     end
  --
  --     require("alpha").setup(dashboard.opts)
  --
  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "LazyVimStarted",
  --       callback = function()
  --         local stats = require("lazy").stats()
  --         local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --         dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
  --         pcall(vim.cmd.AlphaRedraw)
  --       end,
  --     })
  --   end,
  -- },

  {
    "SmiteshP/nvim-navic", -- lsp symbols in lualine
    enabled = false,
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
        animation = { enable = false },
        ignore = {
          buftype = { "quickfix", "help" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "help" },
        },
      })
    end,
    keys = { { "<C-w>m", "<Cmd>WindowsMaximize<CR>", desc = "Maximize window" } },
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

  {
    "lukas-reineke/headlines.nvim",
    enabled = false,
  },
}
