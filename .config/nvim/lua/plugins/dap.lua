return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = { commented = true }
      },

      "nvim-telescope/telescope-dap.nvim",
      -- "ldelossa/nvim-dap-projects",
    },
    config = function()
      local dap = require("dap")
      -- dap.adapters.python = {
      --   type = "executable",
      --   command = os.getenv('HOME') .. "/.virtualenvs/debugpy/bin/python",
      --   args = { "-m", "debugpy.adapter" },
      -- }
      -- dap.configurations.python = {}
      dap.defaults.fallback.terminal_win_cmd = "vsplit new"

      -- map K to hover when session is active
      local api = vim.api
      local keymap_restore = {}
      dap.listeners.after['event_initialized']['me'] = function()
        for _, buf in pairs(api.nvim_list_bufs()) do
          local keymaps = api.nvim_buf_get_keymap(buf, 'n')
          for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
              table.insert(keymap_restore, keymap)
              api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
          end
        end
        api.nvim_set_keymap(
          'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
      end

      dap.listeners.after['event_terminated']['me'] = function()
        for _, keymap in pairs(keymap_restore) do
          api.nvim_buf_set_keymap(
            keymap.buffer,
            keymap.mode,
            keymap.lhs,
            keymap.rhs,
            { silent = keymap.silent == 1 }
          )
        end
        keymap_restore = {}
      end

      -- trigger completion automatically in the REPL
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-repl",
        callback = function()
          require("dap.ext.autocompl").attach()
          vim.opt_local.number = false
        end
      })

      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'GruvboxRed', linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointCondition',
      { text = '•', texthl = 'GruvboxBlue', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointRejected',
      { text = '•', texthl = 'GruvbaxOrange', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'GruvboxGreen', linehl = 'DapBreakpoint', numhl =
      'DapBreakpoint' })
      vim.fn.sign_define('DapLogPoint', { text = '•', texthl = 'GruvboxYellow', linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint' })
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
    config = true,
    init = function()
      local dap, dapui = require("dap"), require("dapui")
      -- dap.listeners.after.event_initialized["dapui_config"] = function()
      --   dapui.open()
      -- end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
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
          '--use-colors',
          '--host',
          '0.0.0.0',
          '--port',
          '5000'
        },
        justMyCode = false,
        -- pythonPath = 'python',
        console = 'integratedTerminal',
      })
    end
  }
}
