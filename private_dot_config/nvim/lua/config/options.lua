vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.npm_global_modules = "~/.npm-global/lib/node_modules/"
vim.g.node_host_prog = "~/.npm-global/bin/neovim-node-host"
vim.g.python3_host_prog = "~/.virtualenvs/pynvim/bin/python"

vim.g.snacks_animate = false

local opt = vim.opt

-- Session management
opt.autowrite = true
opt.exrc = true   -- enable local .init.lua files
opt.secure = true -- disable shell and write commands in local .vimrc files
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "globals", "skiprtp", "folds" }
opt.undofile = true
opt.undolevels = 10000

-- UI
opt.confirm = true                                               -- Confirm to save changes before exiting modified buffer
opt.laststatus = 2                                               -- Each window has a status line
opt.jumpoptions =
"view"                                                           -- When moving through the jumplist, changelist, alternate-file or using mark-motions try to restore the mark-view in which the action occurred.
opt.pumblend = 0                                                 -- Disabled popup menu transparency
opt.smoothscroll = true
opt.splitbelow = true                                            -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true                                            -- Put new windows right of current
opt.termguicolors = true
opt.timeoutlen = 300                                             -- Time in milliseconds to wait for a mapped sequence to complete.
opt.updatetime = 50                                              -- Save swap file update & CursorHold interval
opt.winminwidth = 5                                              -- Minimum window width
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- This option helps to avoid all the |hit-enter| prompts caused by file messages, for example with CTRL-G, and to avoid some other messages.

-- Editor
opt.conceallevel = 2
vim.g.markdown_syntax_conceal = 0
opt.completeopt = "menu,menuone,noselect" -- A comma-separated list of options for Insert mode completion
opt.cursorline = true                     -- Enable highlighting of the current line
opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
opt.foldcolumn = "0"                      -- Disabled
opt.foldenable = false
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt/"
opt.ignorecase = true
opt.inccommand = "nosplit" -- preview incremental :substitute commands
opt.list = true            -- Show whitespace
opt.listchars = "tab:> ,trail:·,nbsp:+"
opt.number = true          -- Show line number
opt.signcolumn = "yes"     -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true       -- Don't ignore case with capitals
opt.spell = false
opt.spelllang = { "en" }
opt.virtualedit = "block"          -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.wrap = false
opt.linebreak = true               -- Wrap lines at convenient points
opt.scrolloff = 10
opt.sidescrolloff = 8

-- Integrations
opt.clipboard = vim.env.SSH_TTY and "" or
    "unnamedplus" -- Sync with system clipboard -- only set clipboard if not in ssh, to make sure the OSC 52
opt.diffopt:append("algorithm:histogram")
opt.diffopt:append("indent-heuristic")
opt.diffopt:append("iwhite")     -- Ignore whitespace
opt.diffopt:append("context:99") -- Disable folding
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.mouse = "nv" -- Enable mouse mode in Normal and Visual mode

-- Indentation
opt.breakindent = true -- keep indent when wrapping lines
opt.shiftround = true  -- Round indent
opt.shiftwidth = 4     -- Size of an indent
opt.tabstop = 4
opt.expandtab = true   -- Use spaces instead of tabs
opt.smartindent = true -- Insert indents automatically

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    return keymap_set(mode, lhs, rhs, opts)
end

if vim.g.neovide then
    vim.o.guifont = "JetBrains_Mono,Symbols_Nerd_Font,Noto_Color_Emoji:h13"
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_padding_top = 8
    vim.g.neovide_padding_bottom = 8
    vim.g.neovide_padding_right = 8
    vim.g.neovide_padding_left = 8

    vim.keymap.set("n", "<C-s>", ":w<CR>")        -- Save
    vim.keymap.set("v", "<C-S-c>", '"+y')         -- Copy
    vim.keymap.set("n", "<C-S-v>", '"+P')         -- Paste normal mode
    vim.keymap.set("v", "<C-S-v>", '"+P')         -- Paste visual mode
    vim.keymap.set("c", "<C-S-v>", "<C-R>+")      -- Paste command mode
    vim.keymap.set("i", "<C-S-v>", '<ESC>l"+Pli') -- Paste insert mode

    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-+>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-0>", function()
        vim.g.neovide_scale_factor = 1.0
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.25)
    end)
end
