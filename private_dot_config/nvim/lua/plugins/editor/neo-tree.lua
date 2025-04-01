return {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
        {
            "s1n7ax/nvim-window-picker",
            name = "window-picker",
            lazy = true,
            version = "2.*",
            opts = {
                hint = "floating-big-letter",
                show_prompt = false,
                selection_chars = "aoeuidhtnsqjkxbmwvz",
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    bo = {
                        filetype = { "neo-tree", "neo-tree-popup", "notify", "noice", "snacks_notif", "aerial" },
                        buftype = { "terminal" },
                    },
                },
                highlights = {
                    statusline = {
                        focused = "WindowPickerStatusLine",
                        unfocused = "WindowPickerStatusLineNC",
                    },
                    winbar = {
                        focused = "WindowPickerWinBar",
                        unfocused = "WindowPickerWinBarNC",
                    },
                },
            },
        }
    },
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        sources = { "filesystem", "buffers", "git_status" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        filesystem = {
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
        },
        window = {
            position = "left",
            mappings = {
                ["<cr>"] = "open_with_window_picker",
                ["s"] = "split_with_window_picker",
                ["v"] = "vsplit_with_window_picker",
                ["l"] = "open",
                ["h"] = "close_node",
                ["<space>"] = "none",
                ["Y"] = {
                    function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        vim.fn.setreg("+", path, "c")
                    end,
                    desc = "Copy Path to Clipboard",
                },
                ["O"] = {
                    function(state)
                        require("lazy.util").open(state.tree:get_node().path, { system = true })
                    end,
                    desc = "Open with System Application",
                },
            },
        },
        default_component_configs = {
            file_size = { enabled = false },
            last_modified = { enabled = false },
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            git_status = {
                symbols = {
                    unstaged = "󰄱",
                    staged = "󰱒",
                },
            },
        },
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    config = function(_, opts)
        local function on_move(data)
            Snacks.rename.on_rename_file(data.source, data.destination)
        end

        local events = require("neo-tree.events")
        opts.event_handlers = opts.event_handlers or {}
        vim.list_extend(opts.event_handlers, {
            { event = events.FILE_MOVED,   handler = on_move },
            { event = events.FILE_RENAMED, handler = on_move },
        })
        require("neo-tree").setup(opts)
        vim.api.nvim_create_autocmd("TermClose", {
            pattern = "*gitui",
            callback = function()
                if package.loaded["neo-tree.sources.git_status"] then
                    require("neo-tree.sources.git_status").refresh()
                end
            end,
        })
    end,
}
