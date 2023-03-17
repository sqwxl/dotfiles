return {
  { "tpope/vim-fugitive" },

  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
      }
    }
  },

  {
    'folke/which-key.nvim',
    config = true
  },

  {
    "toppair/peek.nvim",
    enabled = false, -- doesn't work on windows, tbd gnome
    build = "deno task --quiet build:fast",
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- "theHamsta/nvim-dap-virtual-text",
      "ldelossa/nvim-dap-projects",
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
          table.insert(require('dap').configurations.python, {
            type = "python",
            request = "attach",
            name = "Attach to running process",
            pid = require('dap.utils').pick_process,
            args = {}
          })
        end
      },
    },
    -- config = function()
    --   local dap = require("dap")
    --   dap.adapters.python = {
    --     type = "executable",
    --     command = os.getenv('HOME') .. "/.virtualenvs/debugpy/bin/python",
    --     args = { "-m", "debugpy.adapter" },
    --   }
    --   dap.configurations.python = {}
    -- end
  }
}
