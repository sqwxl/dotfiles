return {
    "sqwxl/playdate.nvim",
    opts = {
        playdate_luacats_path = "~/Clones/playdate-luacats",
        build = {
            source_dir = "Source",
        },
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
