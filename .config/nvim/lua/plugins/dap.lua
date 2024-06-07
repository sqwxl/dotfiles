return {
  {
    "mxsdev/nvim-dap-vscode-js",
    enabled = false,
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
}
