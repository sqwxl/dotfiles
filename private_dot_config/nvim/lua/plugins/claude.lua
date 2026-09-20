return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		terminal_cmd = vim.env.HOME .. "/.local/bin/claude",
		terminal = {
			split_width_percentage = 0.4,
			diff_split_width_percentage = 0.25,
		},
		diff_opts = {
			keep_terminal_focus = true,
			open_in_new_tab = true,
			hide_terminal_in_new_tab = false,
		},
	},
	init = function()
		-- Land on the first hunk instead of line 1.
		vim.api.nvim_create_autocmd("User", {
			pattern = "ClaudeCodeDiffOpened",
			group = vim.api.nvim_create_augroup("ClaudeDiffJump", { clear = true }),
			callback = function(args)
				local win = args.data and args.data.diff_window
				if not (win and vim.api.nvim_win_is_valid(win)) then
					return
				end

				vim.schedule(function()
					if not vim.api.nvim_win_is_valid(win) then
						return
					end

					vim.api.nvim_win_call(win, function()
						vim.cmd("normal! gg")
						-- `]c` from inside the first hunk would skip to the second.
						if vim.fn.diff_hlID(1, 1) <= 0 then
							vim.cmd("normal! ]c")
						end
						vim.cmd("normal! zt")
					end)
				end)
			end,
		})
	end,
	keys = {
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
	},
}
