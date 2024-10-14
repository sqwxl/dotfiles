vim.api.nvim_create_user_command("CspellLearnFile", function()
  local config = vim.env.HOME .. "/.config/cspell/cspell.yaml"
  local current_file = vim.fn.expand("%:p")
  local dictionary = vim.env.HOME .. "/.config/cspell/custom.txt"

  local cmd = string.format(
    "cspell -c %s --unique --words-only --no-progress --no-summary %s >>%s ",
    config,
    current_file,
    dictionary,
    dictionary,
    dictionary
  )

  vim.system({ "sh", "-c", cmd }):wait()
  vim.system({ "sort", "--unique", dictionary, "-o", dictionary }):wait()

  -- enter and exit insert mode to trigger the InsertLeave event in LazyVim's nvim-lint spec
  vim.cmd.startinsert() -- enters insert mode after this function exits
  vim.schedule(function() -- scheduled so that it runs after the function exits and insert mode started
    vim.cmd.stopinsert()
  end)
end, {})
