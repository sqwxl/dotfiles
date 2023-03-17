return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    build = function()
      require('nvim-treesitter.install').update { with_sync = true }
    end,
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "bash",
          "c",
          "css",
          "fish",
          "help",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "python",
          "query",
          "rust",
          "scss",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        -- indent = { enable = true, disable = { "python" } }, -- indentation for the "=" operator
        matchup = { enable = true },
        endwise = { enable = true },
        autotag = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
                  ['aa'] = '@parameter.outer',
                  ['ia'] = '@parameter.inner',
                  ['af'] = '@function.outer',
                  ['if'] = '@function.inner',
                  ['ac'] = '@class.outer',
                  ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                  [']m'] = '@function.outer',
                  [']]'] = '@class.outer',
            },
            goto_next_end = {
                  [']M'] = '@function.outer',
                  [']['] = '@class.outer',
            },
            goto_previous_start = {
                  ['[m'] = '@function.outer',
                  ['[['] = '@class.outer',
            },
            goto_previous_end = {
                  ['[M'] = '@function.outer',
                  ['[]'] = '@class.outer',
            },
          },
          -- swap = {
          --   enable = true,
          --   swap_next = {
          --     ['<leader>a'] = '@parameter.inner',
          --   },
          --   swap_previous = {
          --     ['<leader>A'] = '@parameter.inner',
          --   },
          -- },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "<CR>",
            node_decremental = "<M-CR>"
          }
        },
      }
    end
  }
}
