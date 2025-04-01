local function augroup(name)
    return vim.api.nvim_create_augroup("sqwxl." .. name, { clear = true })
end

-- Core autocommands (taken from LazyVim)

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Check if we need to reload the file when it changed",
    group = augroup("checktime"),
    callback = function() if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function() (vim.hl or vim.highlight).on_yank() end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "dbout",
        "gitsigns-blame",
        "grug-far",
        "help",
        "lspinfo",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Make it easier to close man-files when opened inline",
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Wrap and check for spell in text filetypes",
    group = augroup("wrap_spell"),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    desc = "Fix conceallevel for json files",
    group = augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc = "Auto create dir when saving a file, in case some intermediate directory does not exist",
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-----------------

vim.api.nvim_create_autocmd("CmdwinEnter", {
    desc = "Unmap C-c in command-line window",
    group = augroup("cmdline"),
    callback = function()
        if vim.fn.expand("<afile>") ~= ":" then return end
        vim.keymap.set({ "i", "n" }, "<C-c>", "<C-c>", { buffer = true, silent = false })
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Change the appearance of terminal window",
    pattern = "*",
    group = augroup("term"),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.spell = false
        vim.cmd.startinsert()
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    desc = "Change to terminal mode when entering terminal window",
    group = augroup("term"),
    pattern = "term://*",
    callback = function() vim.cmd.startinsert() end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    desc = "Move help window to the left side and resize to textwidth",
    group = augroup("help"),
    pattern = { "*.md", "*.txt" },
    callback = function(ev)
        if vim.o.buftype == "help" then
            vim.wo.signcolumn = "no"
            vim.wo.foldcolumn = "0"
            vim.wo.colorcolumn = ""
            vim.wo.spell = false
            vim.diagnostic.enable(false, { bufnr = ev.buf })
            vim.cmd("wincmd H")
            local tw = (vim.bo[ev.buf].textwidth or 80)
            local width = math.max(tw, 80)
            vim.cmd("vert resize " .. width)
            vim.wo.winfixwidth = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    desc = "Hide cursorline in inactive window",
    group = augroup("cursor"),
    callback = function()
        if vim.w.auto_cursorline then
            vim.wo.cursorline = true
            vim.w.auto_cursorline = nil
        end
    end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    desc = "Show cursorline in active window",
    group = augroup("cursor"),
    callback = function()
        if vim.wo.cursorline then
            vim.w.auto_cursorline = true
            vim.wo.cursorline = false
        end
    end,
})

vim.api.nvim_create_autocmd("BufRead", {
    desc = "Restore cursor position",
    group = augroup("cursor"),
    pattern = "*",
    once = true,
    callback = function()
        local ft_ignore = { "gitcommit", "gitrebase", "neo-tree" }
        local bt_ignore = { "nofile", "quickfix", "help" }

        local line = vim.fn.line([['"]])
        if line >= 1 and line <= vim.fn.line("$") then
            local ft = vim.opt.filetype:get()
            if not vim.tbl_contains(ft_ignore, ft) then
                local bt = vim.opt.buftype:get()
                if not vim.tbl_contains(bt_ignore, bt) then
                    vim.cmd('keepjumps normal! g`"')
                end
            end
        end
    end,
})
