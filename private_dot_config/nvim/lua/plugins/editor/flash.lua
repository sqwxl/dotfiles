return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        labels = "aoeuidhtnsqjkxbmwvzpyfgcrl",
        modes = {
            char = {
                char_actions = function(motion)
                    return {
                        [";"] = "prev",
                        [","] = "next",
                        [motion:lower()] = "next",
                        [motion:upper()] = "prev",
                    }
                end,
            },
        },
        jump = {
            autojump = true,
        },
    },
}
