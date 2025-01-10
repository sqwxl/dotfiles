local pick_chezmoi = function(targets)
  local fzf_lua = require("fzf-lua")
  local results = require("chezmoi.commands").list({ targets = targets })
  local chezmoi = require("chezmoi.commands")

  local opts = {
    fzf_opts = {},
    fzf_colors = true,
    actions = {
      ["default"] = function(selected)
        chezmoi.edit({
          targets = { "~/" .. selected[1] },
          args = { "--watch" },
        })
      end,
    },
  }
  fzf_lua.fzf_exec(results, opts)
end

return {

  {
    "xvzc/chezmoi.nvim",
    keys = {
      {
        "<leader>fz",
        pick_chezmoi,
        desc = "Chezmoi",
      },
      {
        "<leader>fc",
        function()
          pick_chezmoi("~/.config/nvim")
        end,
        desc = "Edit nvim config files",
      },
    },
    opts = {
      edit = {
        watch = false,
        force = false,
      },
      notification = {
        on_open = true,
        on_apply = true,
        on_watch = false,
      },
      telescope = {
        select = { "<CR>" },
      },
    },
    init = function()
      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*/.local/share/chezmoi/*" },
        callback = function(ev)
          vim.schedule(function()
            require("chezmoi.commands.__edit").watch(ev.buf)
          end)
        end,
      })
    end,
  },

  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- replace the "config" entry's action in opts.dashboard.preset.keys
      for _, key in ipairs(opts.dashboard.preset.keys) do
        if key.desc == "Config" then
          key.action = function()
            pick_chezmoi("~/.config/nvim")
          end
        end
      end
    end,
  },
}
