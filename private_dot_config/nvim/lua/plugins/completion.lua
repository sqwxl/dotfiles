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
        appearance = {
            -- sets the fallback highlight groups to nvim-cmp's highlight groups
            -- useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release, assuming themes add support
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "normal",
        },
        fuzzy = { implementation = "rust" },
        completion = {
            accept = {
                -- experimental auto-brackets support
                auto_brackets = {
                    enabled = true,
                },
            },
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
            trigger = {
                show_in_snippet = false,
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
