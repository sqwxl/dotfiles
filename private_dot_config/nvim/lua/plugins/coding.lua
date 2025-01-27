return {
  {
    "saghen/blink.cmp",
    opts = {
      appearance = {
        -- "mono" or "normal"; basically "normal" has larger icons; see nerd font readmes for more info
        nerd_font_variant = "normal",
      },
      completion = {
        trigger = {
          show_in_snippet = false,
        },
      },
      keymap = {
        preset = "enter",
        ["<C-y>"] = {},
        ["<C-b>"] = {},
        ["<C-f>"] = { LazyVim.cmp.map({ "ai_accept" }), "fallback" },
        ["<A-f>"] = { LazyVim.cmp.map({ "ai_accept_word" }), "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
    },
  },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
      },
    },
  },

  {
    "Wansmer/treesj",
    lazy = true,
    opts = {
      use_default_keymaps = false,
      max_join_length = 300,
    },
    keys = {
      {
        "<A-a>",
        function()
          require("treesj").toggle()
        end,
        desc = "Toggle fold/unfold tree structures",
      },
    },
  },

  { "echasnovski/mini.pairs", enabled = false },
  -- use nvim-autopairs instead
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      fast_wrap = {}, -- bound to <A-e> by default
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    opts = function()
      local cmd
      -- check if flatpak command is available
      if vim.fn.executable("flatpak") == 1 then
        cmd = "flatpak firefox --new-tab"
      else
        -- check for running from container
        if vim.fn.executable("flatpak-spawn") == 1 then
          cmd = "flatpak-spawn --host flatpak run org.mozilla.firefox --new-tab"
        else
          -- native
          if vim.fn.executable("firefox") == 1 then
            cmd = "firefox --new-tab"
          else
            vim.notify("firefox not found", vim.log.levels.WARN)
          end
        end
      end
      vim.cmd(string.format(
        [[
        function MkdpBrowserFn(url)
          execute '!%s' a:url
        endfunction
        ]],
        cmd
      ))
      vim.g.mkdp_browserfunc = "MkdpBrowserFn"
    end,
  },
}
