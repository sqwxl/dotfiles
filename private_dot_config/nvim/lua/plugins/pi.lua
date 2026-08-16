return {
	"ldelossa/pi-ide.nvim",
	config = function()
		require("pi-ide").setup() -- auto-starts the MCP server; pi connects via lockfile+cwd

		local PANEL_FT = "pi-panel"
		local WIDTH = 0.5

		-- ── panel lifecycle ─────────────────────────────────────────
		-- Live channel for a terminal buffer (dead terminals drop out of getchannellist)
		local function panel_channel(buf)
			for _, ch in ipairs(vim.fn.getchannellist()) do
				if vim.fn.channelinfo(ch).buffer == buf then
					return ch
				end
			end
		end

		local function live_panel_bufnr(cwd)
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.bo[buf].filetype == PANEL_FT
					and vim.api.nvim_buf_get_name(buf) == "pi:" .. cwd
					and panel_channel(buf) then
					return buf
				end
			end
		end

		local function open_panel(cmd)
			local cwd = vim.fn.getcwd()
			local existing = live_panel_bufnr(cwd)
			if existing then
				local win = vim.fn.bufwinid(existing)
				if win == -1 then
					vim.cmd("botright vsplit")
					vim.api.nvim_win_set_buf(0, existing)
				else
					vim.api.nvim_set_current_win(win)
				end
				return
			end
			vim.cmd("botright vsplit | terminal " .. cmd)
			local buf = vim.api.nvim_get_current_buf()
			vim.api.nvim_buf_set_name(buf, "pi:" .. cwd)
			vim.bo[buf].filetype = PANEL_FT
			vim.api.nvim_win_set_width(0, math.floor(vim.o.columns * WIDTH))
		end

		-- wipe the panel buffer once its pi process exits
		vim.api.nvim_create_autocmd("TermClose", {
			group = vim.api.nvim_create_augroup("PiPanel", { clear = true }),
			callback = function(args)
				if vim.bo[args.buf].filetype == PANEL_FT then
					vim.api.nvim_buf_delete(args.buf, { force = true })
				end
			end,
		})

		-- ── sending references ──────────────────────────────────────
		local function paste(text)
			local buf = live_panel_bufnr(vim.fn.getcwd())
			local ch = buf and panel_channel(buf)
			if not ch then
				vim.notify("pi panel not open — <leader>ap to start", vim.log.levels.WARN)
				return
			end
			vim.api.nvim_chan_send(ch, "\27[200~" .. text .. "\27[201~") -- bracketed paste
		end

		local function relpath(path)
			local cwd = vim.fn.getcwd() .. "/"
			local p = vim.fn.fnamemodify(path, ":p")
			return p:sub(1, #cwd) == cwd and p:sub(#cwd + 1) or p
		end

		local function file_ref()
			return "# " .. relpath(vim.api.nvim_buf_get_name(0))
		end

		local function selection_ref()
			local buf = vim.api.nvim_get_current_buf()
			local s = vim.api.nvim_buf_get_mark(buf, "<")
			local e = vim.api.nvim_buf_get_mark(buf, ">")
			return ("# %s:%d-%d"):format(relpath(vim.api.nvim_buf_get_name(buf)), s[1], e[1])
		end

		-- ── keymaps ─────────────────────────────────────────────────
		local function pi_panel_active()
			local buf = vim.api.nvim_get_current_buf()
			return vim.bo[buf].filetype == PANEL_FT
		end

		-- ab/as are shared with the claude plugin: target pi when its panel
		-- is focused, otherwise fall through to claude's existing commands.
		local function send_to_agent(pi_fn, claude_cmd)
			if pi_panel_active() then
				pi_fn()
			else
				vim.cmd(claude_cmd)
			end
		end

		vim.keymap.set("n", "<leader>ap", function()
			open_panel("pi")
		end, { desc = "Pi: new session" })

		vim.keymap.set("n", "<leader>aP", function()
			open_panel("pi -c") -- resumes most recent session for this cwd
		end, { desc = "Pi: continue session" })

		vim.keymap.set("n", "<leader>ab", function()
			send_to_agent(function()
				paste(file_ref())
			end, "ClaudeCodeAdd %")
		end, { desc = "Agent: add current buffer" })

		vim.keymap.set("v", "<leader>as", function()
			send_to_agent(function()
				paste(selection_ref())
			end, "ClaudeCodeSend")
		end, { desc = "Agent: send selection" })
	end,
}
