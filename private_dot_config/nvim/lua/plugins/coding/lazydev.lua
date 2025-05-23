return {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "snacks.nvim",        words = { "Snacks" } },
        },
        enabled = function(root_dir)
            if (vim.g.lazydev_enabled ~= nil and true) then
                return true
            end
            return root_dir ~= nil and (
                string.match(root_dir, vim.fn.stdpath("config"))
                or string.match(root_dir, vim.fs.normalize("~/.local/share/chezmoi/private_dot_config/nvim"))
            )
        end,
    },
}
