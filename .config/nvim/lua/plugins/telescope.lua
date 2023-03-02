return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending"
      }
    }
  },
}
