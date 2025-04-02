local M = {}

local debounce = 200
local ns = vim.api.nvim_create_namespace("nvim.lsp.references")
local timer = assert((vim.uv or vim.loop).new_timer())
local modes = { "n", "i", "c" } -- modes to show references

function M.is_enabled()
    local mode = vim.api.nvim_get_mode().mode:lower()
    mode = mode:gsub("\22", "v"):gsub("\19", "s")
    mode = mode:sub(1, 2) == "no" and "o" or mode
    mode = mode:sub(1, 1):match("[ncitsvo]") or "n"
    if not vim.tbl_contains(modes, mode) then
        return false
    end
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })
    clients = vim.tbl_filter(function(client)
        return client.supports_method("textDocument/documentHighlight", { bufnr = buf })
    end, clients)
    return #clients > 0
end

function M.clear()
    vim.lsp.buf.clear_references()
end

function M.update()
    local buf = vim.api.nvim_get_current_buf()
    timer:start(debounce, 0, function()
        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_call(buf, function()
                    if not M.is_enabled() then
                        return
                    end
                    vim.lsp.buf.document_highlight()
                    M.clear()
                end)
            end
        end)
    end)
end

function M.get()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local current, ret = nil, {}
    local extmarks = {}
    vim.list_extend(extmarks, vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { details = true }))
    for _, extmark in ipairs(extmarks) do
        local w = {
            from = { extmark[2] + 1, extmark[3] },
            to = { extmark[4].end_row + 1, extmark[4].end_col },
        }
        ret[#ret + 1] = w
        if cursor[1] >= w.from[1] and cursor[1] <= w.to[1] and cursor[2] >= w.from[2] and cursor[2] <= w.to[2] then
            current = #ret
        end
    end
    return ret, current
end

---@param count? number
function M.jump(count)
    conut = count or 1
    local words, idx = M.get()
    if not idx then
        return
    end
    idx = idx + count
    idx = (idx - 1) % #words + 1
    local target = words[idx]
    if target then
        vim.cmd.normal({ "m`", bang = true })
        vim.api.nvim_win_set_cursor(0, target.from)
        vim.cmd.normal({ "zv", bang = true })
    end
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "ModeChanged" }, {
    group = vim.api.nvim_create_augroup("sqwxl.ref_jump", { clear = true }),
    callback = function()
        if not M.is_enabled() then
            M.clear()
            return
        end
        if not ({ M.get() })[2] then
            M.update()
        end
    end,
})

return M
