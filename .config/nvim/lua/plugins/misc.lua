return {
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      {
        "<Leader>fml",
        function()
          vim.cmd.CellularAutomaton("make_it_rain")
        end,
        desc = "Make it rain!",
      },
    },
  },
}
