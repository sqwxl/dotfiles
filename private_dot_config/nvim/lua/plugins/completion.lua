return {
    "saghen/blink.cmp",
    version = "1.*",
    opts_extend = { "sources.default" },
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = "enter" },
        appearance = { nerd_font_variant = "normal" },
        fuzzy = { implementation = "rust" },
        completion = {
            menu = {
                draw = {
                    treesitter = { "lsp" },
                },
            },
            documentation = {
                auto_show = true,
            },
            ghost_text = {
                enabled = true,
            },
        },

        -- experimental signature help support
        -- signature = { enabled = true },

        sources = {
            default = { "lsp", "path", "snippets", "buffer", "lazydev" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100, -- show at a higher priority than lsp
                },
            },
        },

        cmdline = {
            enabled = false,
        },

    },
}
