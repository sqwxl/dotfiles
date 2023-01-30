local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require("packer")

packer.init {
  compile_path = vim.fn.stdpath('config') .. "/lua/packer_compiled.lua"
}

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "tpope/vim-surround"

  use "tpope/vim-repeat"

  use "tpope/vim-endwise"

  use "tpope/vim-fugitive"

  use {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end
  }

  use {
    "github/copilot.vim",
    disable = true,
    config = function()
        vim.g.copilot_no_tab_map = true
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  }

  use { 
    "ellisonleao/gruvbox.nvim",
  }

  use {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  }

  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {
        view = { side = "right" }
      } 
    end,
  }
  
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {
      check_ts = true
    } end,
  }

  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "lspconfig"
    end,
  }

  use {
    "j-hui/fidget.nvim",
    config = function() require("fidget").setup() end,
  }

  use { 
    "hrsh7th/nvim-cmp",
  }

  use {
    "hrsh7th/vim-vsnip",
  }

  use {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  }

  use {
    "nvim-lua/popup.nvim",
  }

  use {
    "nvim-lua/plenary.nvim",
  }

  use { 
    "nvim-telescope/telescope.nvim",
  } 

  use {
    "simrat39/rust-tools.nvim",
  }

  if packer_bootstrap then
    require("packer").sync()
    return
  end
end)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, bufopts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>l', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require("lspconfig")["pyright"].setup { on_attach = on_attach }

require("rust-tools").setup {
  tools = { 
    runnables = { use_telescope = true },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      other_hints_prefix = "" 
    }
  }, 
  server = {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = { 
        checkOnSave = { command = "clippy" }
      }
    }
  }
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format(nil, 200)
  end,
  group = format_sync_grp,
})

