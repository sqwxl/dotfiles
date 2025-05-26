return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
        require("lazy").load({ plugins = { "markdown-preview.nvim" } })
        vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
    config = function()
        vim.cmd([[do FileType]])
    end,
    opts = function()
        local cmd
        -- check if flatpak command is available
        if vim.fn.executable("flatpak") == 1 then
            cmd = "flatpak run org.mozilla.firefox"
        else
            -- check for running from container
            if vim.fn.executable("flatpak-spawn") == 1 then
                cmd = "flatpak-spawn --host flatpak run org.mozilla.firefox"
            else
                -- native
                if vim.fn.executable("firefox") == 1 then
                    cmd = "firefox"
                else
                    vim.notify("firefox not found", vim.log.levels.WARN)
                end
            end
        end

        vim.cmd(string.format(
            [[
        function OpenMarkdownPreview (url)
          execute "! %s -n --args --new-tab " . a:url
        endfunction
        ]],
            cmd
        ))

        vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end,
}
