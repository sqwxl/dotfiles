return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                header = [[
        ______ _____ ______ __  __ __ __________
       /\  __ \\  __\\  __ \\ \/\ \\_\\  __  __ \
       \ \ \/\ \\  __\\ \_\ \\ \/ |/\ \\ \/\ \/\ \
        \ \_\ \_\\____\\_____\\__/ \ \_\\_\ \_\ \_\
         \/_/\/_//____//_____//_/   \/_//_/\/_/\/_/]],
            },
            formats = {
                header = { "%s", align = "left" },
            },
        },
        notifier = { enabled = false, timeout = 3000 },
        statuscolumn = { enabled = true },
        picker = { enabled = true },
        styles = { notifications = { wo = { wrap = true }, relative = true } },
    },
    keys = {
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
                Snacks.toggle.zen():map("<leader>uz")
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel",
                    { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map(
                    "<leader>uc")
                Snacks.toggle.option("showtabline",
                    { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
                    :map("<leader>uA")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                Snacks.toggle.dim():map("<leader>uD")
                Snacks.toggle.animate():map("<leader>ua")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.scroll():map("<leader>uS")
                Snacks.toggle.profiler():map("<leader>dpp")
                Snacks.toggle.profiler_highlights():map("<leader>dph")

                Snacks.toggle.inlay_hints():map("<leader>uh")
            end,
        })
    end,
}
