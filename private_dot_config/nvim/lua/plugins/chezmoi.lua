local pick_chezmoi = function(targets)
  require("fzf-lua").fzf_exec(require("chezmoi.commands").list({ targets = targets }), {
    fzf_opts = {},
    fzf_colors = true,
    actions = {
      ["default"] = function(selected)
        require("chezmoi.commands").edit({
          targets = { "~/" .. selected[1] },
          args = { "--watch" },
        })
      end,
    },
  })
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
    },
    init = function()
      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = os.getenv("HOME") .. "/.local/share/chezmoi/*",
        callback = function(ev)
          vim.schedule(function()
            require("chezmoi.commands.__edit").watch(ev.buf)
          end)
        end,
      })
    end,
  },
}
