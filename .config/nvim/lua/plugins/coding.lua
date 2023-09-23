return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
    },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
      }))

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        -- ["<C-e>"] = cmp.mapping.close(),
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
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
      cmp.event:on("menu_opened", function()
        vim.b.copilot_suggestion_hidden = true
      end)

      cmp.event:on("menu_closed", function()
        vim.b.copilot_suggestion_hidden = false
      end)
    end,
  },

  { "echasnovski/mini.surround", enabled = false },
  { "tpope/vim-surround", lazy = false },
  -- {
  --   "kylechui/nvim-surround",
  --   enabled = false,
  --   version = "*", -- Use for stability; omit to use `main` branch for the latest features
  --   event = "VeryLazy",
  --   config = function()
  --       require("nvim-surround").setup({
  --           -- Configuration here, or leave empty to use defaults
  --       })
  --   end
  -- },

  { "tpope/vim-abolish" }, -- adds case-aware substitution via :S command
  {
    "tpope/vim-sleuth",
  }, -- dynamic 'shiftwidth' and 'expandtab' based on file

  {
    "Wansmer/treesj", -- fold/unfold "tree structures" like arrays and tables
    cmd = "TSJToggle",
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { "<A-a>", "<Cmd>TSJToggle<CR>", desc = "Toggle fold/unfold tree structures" },
    },
  },

  { "echasnovski/mini.comment", enabled = false },

  { "numToStr/Comment.nvim", config = true },

  {
    "danymat/neogen", -- generate annotations
    opts = { snippet_engine = "luasnip" },
    keys = {
      {
        "gC",
        function()
          require("neogen").generate({})
        end,
        desc = "Generate annotations",
      },
    },
  },

  { "echasnovski/mini.pairs", enabled = false },
  {
    "windwp/nvim-autopairs",
    opts = {
      check_ts = true,
      enable_check_bracket_line = true,
      ignored_next_char = "[%w%.]",
      fast_wrap = {}, -- bound to <M-e> by default
    },
  },

  { "windwp/nvim-ts-autotag" },

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { "<Leader>E", "<Cmd>SymbolsOutline<CR>", desc = "Document structure" },
  },

  -- indent-aware pasting
  {
    "sickill/vim-pasta",
    config = function()
      vim.g.pasta_disable_filetypes = {
        "gitcommit",
        "gitrebase",
        "svn",
        "fugitive",
        "fugitiveblame",
      }
    end,
  },

  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   keys = {
  --     {
  --       "<Leader>R",
  --       function()
  --         require("refactoring").select_refactor()
  --       end,
  --       mode = "v",
  --       noremap = true,
  --       silent = true,
  --       expr = false,
  --       desc = "Select refactor",
  --     },
  --   },
  -- },

  -- structural find & replace
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<Leader>S",
        function()
          require("ssr").open()
        end,
        desc = "Structural search & replace",
      },
    },
  },

  -- {
  --   "sheerun/vim-polyglot",
  --   init = function()
  --     vim.g.polyglot_disabled = { "autoindent" }
  --   end
  -- }

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      panel = {
        keymap = { open = "<A-CR>" },
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-f>",
          accept_word = "<A-f>",
          dismiss = "<C-e>",
        },
      },
    },
  },

  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
    opts = {},
  },
}
