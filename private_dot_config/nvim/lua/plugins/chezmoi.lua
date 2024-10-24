local pick_chezmoi = function()
  if LazyVim.pick.picker.name == "telescope" then
    require("telescope").extensions.chezmoi.find_files()
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
    local results = require("chezmoi.commands").list()
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
end

local pick_chezmoi_nvim = function()
  require("fzf-lua").fzf_exec()
end

return {
  {
    -- highlighting for chezmoi files template files
    "alker0/chezmoi.vim",
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = 1
      vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/.local/share/chezmoi"
    end,
  },

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
        pick_chezmoi,
        desc = "Chezmoi",
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
}
