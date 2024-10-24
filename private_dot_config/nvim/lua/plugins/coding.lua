return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-f>"] = LazyVim.cmp.confirm({ select = true }),
        ["<CR>"] = LazyVim.cmp.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end),
      })

      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "cody" },
        { name = "path" },
      }, {
        { name = "buffer" },
        { name = "nvim_lua" },
      })
    end,
  },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        update_n_lines = "gsn", -- Update `n_lines`
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
