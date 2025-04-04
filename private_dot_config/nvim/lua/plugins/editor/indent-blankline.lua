return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    -- For setting shiftwidth and tabstop automatically.
    dependencies = "tpope/vim-sleuth",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        scope = {
            show_start = false,
            show_end = false
        }
    },
}
