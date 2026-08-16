return {
	"ldelossa/pi-ide.nvim",
	config = function()
		require("pi-ide").setup() -- auto-starts the MCP server; pi connects via lockfile+cwd

		-- Config-side override (survives pi-ide.nvim updates): never report terminal
		-- buffers (the pi panel itself) as the "current file"; hold the last real buffer.
		local selection = require("pi-ide.selection")
		local orig_update = selection.update
		selection.update = function()
			if vim.bo[vim.api.nvim_get_current_buf()].buftype == "terminal" then
				return
			end
			orig_update()
		end

		local PANEL_FT = "pi-panel"
		local WIDTH = 0.30 -- mirrors claudecode.nvim split_width_percentage default

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
				if vim.b[buf].pi_panel == cwd and panel_channel(buf) then
					return buf
				end
			end
		end

		local function focus_panel(buf)
			local win = vim.fn.bufwinid(buf)
			if win == -1 then
				vim.cmd("botright vsplit")
				vim.api.nvim_win_set_buf(0, buf)
			else
				vim.api.nvim_set_current_win(win)
			end
			vim.cmd("startinsert") -- deterministic terminal mode
		end

		local function open_panel(cmd)
			local cwd = vim.fn.getcwd()
			local existing = live_panel_bufnr(cwd)
			if existing then
				focus_panel(existing)
				return
			end
			vim.cmd("botright vsplit")
			vim.cmd("enew")
			local buf = vim.api.nvim_get_current_buf()
			vim.b[buf].pi_panel = cwd -- marker; no synthetic name (would leak into pi-ide's <editor> block)

			-- Pin to the bottom even when unfocused: scroll on every output chunk via
			-- termopen's job callbacks (fire regardless of focus; autocmd events do not).
			-- set_cursor works on an unfocused terminal (verified: cursor 1 -> 501); pcall
			-- makes it a no-op while focused, where native terminal auto-scroll applies.
			-- Pin only while the buffer tail is visible. nvim has no native terminal
			-- scrollback -- the buffer IS the scrollback -- so an unconditional pin fights
			-- the user's own scrolling: every TUI redraw or stream chunk yanks the view
			-- back down while pi runs. WinScrolled fires for any window scroll, focused or
			-- not, so it tracks the user's scrolling; pinning resumes at the tail again.
			local pinned = true
			vim.api.nvim_create_autocmd("WinScrolled", {
				callback = function(args)
					local win = tonumber(args.match)
					if win == nil or vim.api.nvim_win_get_buf(win) ~= buf then return end
					pinned = vim.fn.line("w$", win) >= vim.api.nvim_buf_line_count(buf)
				end,
			})
			local function scroll_bottom()
				local win = vim.fn.bufwinid(buf)
				if win == -1 or not pinned then return end
				pcall(vim.api.nvim_win_set_cursor, win, { vim.api.nvim_buf_line_count(buf), 0 })
			end
			vim.fn.termopen(cmd, {
				cwd = cwd,
				on_stdout = function() scroll_bottom() end,
				on_stderr = function() scroll_bottom() end,
			})

			vim.bo[buf].filetype = PANEL_FT

			-- single Esc passes through to pi's TUI (abort); double Esc exits terminal mode.
			-- Overrides the global t-mode <Esc> mapping (keymaps.lua) for this buffer.
			local esc_timer = (vim.uv or vim.loop).new_timer()
			vim.keymap.set("t", "<Esc>", function()
				if esc_timer:is_active() then
					esc_timer:stop()
					vim.cmd("stopinsert")
				else
					esc_timer:start(200, 0, function() end)
					return "<esc>"
				end
			end, { buffer = buf, expr = true, desc = "Double Esc exits terminal mode" })

			vim.api.nvim_win_set_width(0, math.floor(vim.o.columns * WIDTH))
			vim.cmd("startinsert")
		end

		-- wipe the panel buffer once its pi process exits
		vim.api.nvim_create_autocmd("TermClose", {
			group = vim.api.nvim_create_augroup("PiPanel", { clear = true }),
			callback = function(args)
				if vim.b[args.buf].pi_panel then
					vim.api.nvim_buf_delete(args.buf, { force = true })
				end
			end,
		})

		-- selection/file/diagnostics reach pi via pi-ide's <editor> block; no paste keys needed
		vim.keymap.set("n", "<leader>ap", function()
			open_panel("pi")
		end, { desc = "Pi: new session" })

		vim.keymap.set("n", "<leader>aP", function()
			open_panel("pi -c") -- resumes most recent session for this cwd
		end, { desc = "Pi: continue session" })
	end,
}
