vim.api.nvim_create_user_command("CspellLearnFile", function()
  local shell = vim.fn.exepath("fish")
  local config = vim.env.HOME .. "/.config/cspell/cspell.yaml"
  local current_file = vim.fn.expand("%:p")
  local dictionary = vim.env.HOME .. "/.config/cspell/custom.txt"
  local cmd = string.format(
    "cspell -c '%s' --words-only --unique --no-progress --no-summary '%s' >>'%s'",
    config,
    current_file,
    dictionary
  )
  vim.system({ shell, "-c", cmd }, { text = true })
end, {})
