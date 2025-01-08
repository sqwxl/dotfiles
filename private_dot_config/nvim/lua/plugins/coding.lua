return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-f>"] = LazyVim.cmp.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      table.insert(opts.sources, {
        name = "cody",
        group_index = 1,
        priority = 100,
      })
    end,
  },

  {
    "saghen/blink.cmp",
    opts = {
      appearance = {
        nerd_font_variant = "normal",
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

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      enable_check_bracket_line = true,
      ignored_next_char = "[%w%.]",
      fast_wrap = {}, -- bound to <A-e> by default
    },
  },

  {
    "sourcegraph/sg.nvim",
    event = "VeryLazy",
    opts = {
      enable_cody = true,
      accept_tos = true,
      node_executable = "/home/linuxbrew/.linuxbrew/opt/node@20/bin/node",
    },
    keys = {
      dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
      {
        "<leader>cy",
        function()
          require("sg.cody.commands").toggle()
        end,
        desc = "Toggle Cody chat",
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
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
