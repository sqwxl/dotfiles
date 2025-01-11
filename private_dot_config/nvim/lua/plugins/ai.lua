return {

  {
    "supermaven-inc/supermaven-nvim",
    opts = function(_, opts)
      opts.disable_keymaps = true
      opts.disable_inline_completion = false
      opts.color = {
        -- NOTE: Not working at the moment see https://github.com/supermaven-inc/supermaven-nvim/issues/52
        suggestion_color = vim.api.nvim_get_hl(0, { name = "GruvboxBg2" }).fg,
        cterm = 0,
      }

      -- create ai_accept_word action (mirrors the ai_accept action in LazyVim)
      require("supermaven-nvim.completion_preview").suggestion_group = "SupermavenSuggestion"
      LazyVim.cmp.actions.ai_accept_word = function()
        local suggestion = require("supermaven-nvim.completion_preview")
        if suggestion.has_suggestion() then
          LazyVim.create_undo()
          vim.schedule(function()
            suggestion.on_accept_suggestion_word()
          end)
          return true
        end
      end
    end,
  },

  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "supermaven-nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        compat = { "supermaven" },
        providers = {
          supermaven = {
            kind = "Supermaven",
            score_offset = 100,
            async = true,
            should_show_items = true,
          },
        },
      },
    },
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
