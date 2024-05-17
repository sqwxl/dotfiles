return {
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      { "mfussenegger/nvim-dap" },
      {
        "microsoft/vscode-js-debug",
        lazy = true,
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
    opts = {
      debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
    },
  },

  -- disable fancy ui
  -- {
  -- "rcarriga/nvim-dap-ui",
  -- enabled = false,
  -- },

  -- {
  -- "mfussenegger/nvim-dap",
  -- opts = function()
  --   local dap = require("dap")
  --   if not dap.adapters["pwa-node"] then
  --     require("dap").adapters["pwa-node"] = {
  --       type = "server",
  --       host = "localhost",
  --       port = "${port}",
  --       executable = {
  --         command = "node",
  --         args = {
  --           require("dap-vscode-js").get_package("js-debug-adapter"):get_install_path()
  --             .. "/js-debug/src/dapDebugServer.js",
  --           "${port}",
  --         },
  --       },
  --     }
  --   end
  --   for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  --     if not dap.configurations[language] then
  --       dap.configurations[language] = {
  --         {
  --           type = "pwa-node",
  --           request = "launch",
  --           name = "Launch file",
  --           program = "${file}",
  --           cwd = "${workspaceFolder}",
  --         },
  --         {
  --           type = "pwa-node",
  --           request = "attach",
  --           name = "Attach",
  --           processId = require("dap.utils").pick_process,
  --           cwd = "${workspaceFolder}",
  --         },
  --       }
  --     end
  --   end
  -- end,
  -- },

  -- {
  --   "theHamsta/nvim-dap-virtual-text",
  --   opts = { commented = true },
  -- },

  -- {
  --   "mfussenegger/nvim-dap-python",
  --   config = function()
  --     local path = require("mason-registry").get_package("debugpy"):get_install_path()
  --     require("dap-python").setup(path .. "/venv/bin/python")
  --     local dap = require("dap")
  --     table.insert(dap.configurations.python, {
  --       type = "python",
  --       request = "attach",
  --       name = "Attach to running process",
  --       pid = require('dap.utils').pick_process,
  --       args = {}
  --     })
  --     table.insert(dap.configurations.python, {
  --       name = 'FastAPI module',
  --       type = 'python',
  --       request = 'launch',
  --       module = 'uvicorn',
  --       args = {
  --         'app.main:app',
  --         '--use-colors',
  --         '--host',
  --         '0.0.0.0',
  --         '--port',
  --         '5000'
  --       },
  --       justMyCode = false,
  --       -- pythonPath = 'python',
  --       console = 'integratedTerminal',
  --     })
  --     table.insert(dap.configurations.python, {
  --       name = "pytest .",
  --       type = 'python',
  --       request = 'launch',
  --       module = 'pytest',
  --       args = { '.' },
  --       console = 'integratedTerminal'
  --     })
  --   end
  -- }
}
