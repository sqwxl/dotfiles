return {

  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      keymaps = {
        accept_word = "<A-f>",
        accept_suggestion = "<C-f>",
      },
    },
    -- opts = function(_, opts)
    --   opts.disable_keymaps = true
    --
    --   -- create ai_accept_word action
    --   require("supermaven-nvim.completion_preview").suggestion_group = "SupermavenSuggestion"
    --   LazyVim.cmp.actions.ai_accept_word = function()
    --     local suggestion = require("supermaven-nvim.completion_preview")
    --     if suggestion.has_suggestion() then
    --       LazyVim.create_undo()
    --       vim.schedule(function()
    --         suggestion.on_accept_suggestion_word()
    --       end)
    --       return true
    --     end
    --   end
    -- end,
  },

  {
    "sourcegraph/sg.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      enable_cody = true,
      accept_tos = true,
      node_executable = "/home/linuxbrew/.linuxbrew/opt/node@20/bin/node",
    },
    keys = {
      dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
      {
        "<leader>cy",
        function()
          require("sg.cody.commands").toggle()
        end,
        desc = "Toggle Cody chat",
      },
    },
  },
}
