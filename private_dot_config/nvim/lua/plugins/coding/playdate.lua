return {
    "sqwxl/playdate.nvim",
    opts = {
        playdate_luacats_path = "~/Clones/playdate-luacats",
        server_settings = {
            Lua = {
                format = {
                    defaultConfig = {
                        call_arg_parentheses = "remove_string_only",
                    },
                },
            },
        },
    },
}
