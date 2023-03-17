return {
  { "tpope/vim-fugitive" },

  {
    "zbirenbaum/copilot-cmp",
    config = true,
    -- opts = {
    --   formatters = {
    --     insert_text = require("copilot_cmp.format").remove_existing
    --   },
    -- },
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        },
      }
    }
  },

  {
    'folke/which-key.nvim',
    config = true,
  },

  {
    "toppair/peek.nvim",
    enabled = false, -- doesn't work on windows, tbd gnome
    build = "deno task --quiet build:fast",
  },

  {
    "rcarriga/nvim-dap-ui",
    config = true,
    init = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
      dependencies = {
        -- "theHamsta/nvim-dap-virtual-text",
        -- "ldelossa/nvim-dap-projects",
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
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
      local dap = require('dap')
      table.insert(dap.configurations.python, {
        type = "python",
        request = "attach",
        name = "Attach to running process",
        pid = require('dap.utils').pick_process,
        args = {}
      })
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'FastAPI module',
        module = 'uvicorn',
        args = {
          'app.main:app',
          -- '--reload', -- doesn't work
          '--use-colors',
          '--host',
          '0.0.0.0',
          '--port',
          '5000'
        },
        -- pythonPath = 'python',
        console = 'integratedTerminal',
      })
    end
  }

}
