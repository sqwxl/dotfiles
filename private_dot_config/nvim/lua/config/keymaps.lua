-- stylua: ignore start
local go_to_diagnostic = function(next, severity)
	severity = severity and vim.diagnostic.severity[severity] or nil

	return function()
		vim.diagnostic.jump({ count = next and 1 or -1, float = true, severity = severity })
	end
end

local keys = {
	-- general
	{ "<Leader>qq", "<Cmd>qa<CR>", desc = "Quit" },
	{ "<Esc>", function() vim.cmd("noh") if vim.snippet then vim.snippet.stop() end return "<Esc>" end, expr = true, desc = "Escape and Clear hlsearch", mode = { "i", "n", "s" } },
	{ "<C-c>", "<Esc>", mode = { "i", "n", "s" }, remap = true },
	{ "<Esc>", "<C-Bslash><C-n>", mode = "t" },
	{ "<CR>", ":", silent = false, desc = "Command line" },
	{ "<Leader>n", "<Cmd>enew<CR>", desc = "New file" },
	{ "<C-s>", "<Cmd>w<CR><Esc>", desc = "Save file", mode = { "i", "x", "n", "s" } },

	{ "<Leader>K", "<Cmd>norm! K<CR>", desc = "Keywordprg" },

	-- better movement
	{ "j", "v:count == 0 ? 'gj' : 'j'", desc = "Down", expr = true, silent = true, mode = { "n", "x" } },
	{ "k", "v:count == 0 ? 'gk' : 'k'", desc = "Up", expr = true, silent = true, mode = { "n", "x" } },
	{ "{", "}", mode = "" },
	{ "}", "{", mode = "" },
	{ "H", "^", desc = "Start of line", mode = "" },
	{ "L", "$", desc = "End of line", mode = "" },
	{ "mm", "%", desc = "Go to matching bracket", mode = "" },

	-- keep cursor centered when scrolling
	{ "<C-u>", "<C-u>zz" },
	{ "<C-d>", "<C-d>zz" },

	-- move lines
	{ "<A-S-c>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", desc = "Move line up" },
	{ "<A-S-t>", "<cmd>execute 'move .+' . v:count1<cr>==", desc = "Move line down" },
	{ "<A-S-c>", "<esc><cmd>m .-2<cr>==gi", desc = "Move line up", mode = "i" },
	{ "<A-S-t>", "<esc><cmd>m .+1<cr>==gi", desc = "Move line down", mode = "i" },
	{ "<A-S-c>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", desc = "Move lines up", mode = "v" },
	{ "<A-S-t>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", desc = "Move lines down", mode = "v" },

	-- indenting
	{ "<", "<gv", mode = "v" },
	{ ">", ">gv", mode = "v" },

	-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
	{ "n", "'Nn'[v:searchforward].'zv'", expr = true, desc = "Next search result" },
	{ "n", "'Nn'[v:searchforward]", expr = true, desc = "Next search result", mode = "x" },
	{ "n", "'Nn'[v:searchforward]", expr = true, desc = "Next search result", mode = "o" },
	{ "N", "'nN'[v:searchforward].'zv'", expr = true, desc = "Prev search result" },
	{ "N", "'nN'[v:searchforward]", expr = true, desc = "Prev search result", mode = "x" },
	{ "N", "'nN'[v:searchforward]", expr = true, desc = "Prev search result", mode = "o" },

	-- Add undo break-points
	{ ",", ",<C-g>u", mode = "i" },
	{ ".", ".<C-g>u", mode = "i" },
	{ ";", ";<C-g>u", mode = "i" },

	{ "Q", "@q" },

	{ "gco", "o<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<BS>", desc = "Add comment below" },
	{ "gcO", "O<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<BS>", desc = "Add comment above" },
	{ "[<Space>", "<Cmd>put! =repeat(nr2char(10), v:count1)<CR>", desc = "Add empty line(s) above" },
	{ "]<Space>", "<Cmd>put =repeat(nr2char(10), v:count1)<CR>", desc = "Add empty line(s) below" },

	-- Command history
	{ "<C-p>", function() return vim.fn.wildmenumode() and "<Up>" or "<C-p>" end, expr = true, silent = false, mode = "c" },
	{ "<C-n>", function() return vim.fn.wildmenumode() and "<Down>" or "<C-n>" end, expr = true, silent = false, mode = "c" },

	-- Buffers
	{ "<Leader><Space>", "<Cmd>e#<CR>", desc = "Go to last accessed buffer" },
	{ "[b", "<Cmd>bprevious<CR>", desc = "Prev buffer" },
	{ "gp", "<Cmd>bprevious<CR>", desc = "Prev buffer" },
	{ "]b", "<Cmd>bnext<CR>", desc = "Next buffer" },
	{ "gn", "<Cmd>bnext<CR>", desc = "Next buffer" },
	{ "<Leader>bD", "<Cmd>bd<CR>", desc = "Delete buffer" },
	{ "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", desc = "Redraw / Clear hlsearch / Diff Update" },

	-- Windaws
	{ "<S-Tab>", "<C-w>W", desc = "Go to window above/left", mode = { "n", "v" } },
	{ "<Tab>", "<C-w>w", desc = "Go to window below/right", mode = { "n", "v" } },
	{ "<C-i>", "<Tab>", mode = { "n", "v" } }, -- CTRL-I can be mapped separately from <Tab>, on the condition that both keys are mapped, otherwise the mapping applies to both.
	{ "<A-h>", "<C-w>h", desc = "Move left" },
	{ "<A-h>", "<C-Bslash><C-N><C-w>h", desc = "Move left", mode = { "t", "i" } },
	{ "<A-n>", "<C-w>l", desc = "Move right" },
	{ "<A-n>", "<C-Bslash><C-N><C-w>l", desc = "Move right", mode = { "t", "i" } },
	{ "<A-c>", "<C-w>k", desc = "Move up" },
	{ "<A-c>", "<C-Bslash><C-N><C-w>k", desc = "Move up", mode = { "t", "i" } },
	{ "<A-t>", "<C-w>j", desc = "Move down" },
	{ "<A-t>", "<C-Bslash><C-N><C-w>j", desc = "Move down", mode = { "t", "i" } },

	-- tabs
	{ "<Leader><Tab>", "<Cmd>tabnew<CR>", desc = "New tab" },
	{ "<C-Tab>", "<Cmd>tabnext #<CR>", desc = "Go to last accessed tab" },

	{ "<C-/>", function() Snacks.terminal() end, desc = "Toggle terminal", mode = { "n", "v", "i" } },
	{ "<C-/>", "<Cmd>close<CR>", desc = "Hide terminal", mode = "t" },

	-- location list
	{
		"<Leader>xl",
		function()
			local success, err =
				pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
			if not success and err then
				vim.notify(err, vim.log.levels.ERROR)
			end
		end,
		desc = "Location list",
	},

	-- quickfix list
	{
		"<Leader>xq",
		function()
			local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
			if not success and err then
				vim.notify(err, vim.log.levels.ERROR)
			end
		end,
		desc = "Quickfix list",
	},
	{ "[q", vim.cmd.cprev, desc = "Prev quickfix" },
	{ "]q", vim.cmd.cnext, desc = "Next quickfix" },


	-- format
	{ "<Leader>cf", function() require("conform").format() end, desc = "Format", mode = { "n", "v" } },
	{ "<leader>cF", function() require("conform").format({ formatters = { "injected" } }) end, desc = "Format injected langs", mode = { "n", "v" } },

	-- diagnostics
	{ "<Leader>cd", vim.diagnostic.open_float, desc = "Line diagnostics" },
	{ "[d", go_to_diagnostic(false), desc = "Prev diagnostic" },
	{ "]d", go_to_diagnostic(true), desc = "Next diagnostic" },
	{ "[e", go_to_diagnostic(false, "ERROR"), desc = "Prev error" },
	{ "]e", go_to_diagnostic(true, "ERROR"), desc = "Next error" },
	{ "[w", go_to_diagnostic(false, "WARN"), desc = "Prev warning" },
	{ "]w", go_to_diagnostic(true, "WARN"), desc = "Next warning" },
	{ "<Leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
	{ "<Leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer diagnostics" },

	-- git
	{ "<Leader>gg", function() Snacks.terminal({ "gitui" }) end, desc = "gitui" },
	{ "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Current file history" } },
	{ "<Leader>gb", function() Snacks.picker.git_log_line() end, desc = "Blame line" },
	{ "<Leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse (open)", mode = {"n", "x"} },
	{ "<Leader>gY", function() Snacks.gitbrowse({open = function(url) vim.fn.setreg("+", url) end, notify = false}) end, desc = "Git browse (copy)", mode = {"n", "x"} },
	{ "<Leader>gL", "<Cmd>%diffget REMOTE<CR>", desc = "Get all REMOTE hunks" },
	{ "<Leader>gU", "<Cmd>%diffget LOCAL<CR>", desc = "Get all LOCAL hunks" },
	{ "<Leader>gl", "<Cmd>diffget REMOTE<CR>", desc = "Get REMOTE hunk" },
	{ "<Leader>gu", "<Cmd>diffget LOCAL<CR>", desc = "Get LOCAL hunk" },

	{ "<Leader>l", "<Cmd>Lazy<CR>", desc = "Lazy" },
	{ "<Leader>m", "<Cmd>Mason<CR>", desc = "Mason", mode = {"n", "v"} },

	{ "]]", function() require("sqwxl.lsp_refs").jump(vim.v.count1) end, desc = "Next symbol reference", mode = { "n", "t" } },
	{ "[[", function() require("sqwxl.lsp_refs").jump(-vim.v.count1) end, desc = "Prev symbol reference", mode = { "n", "t" } },
	{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Go to definition" },
	{ "gV", function() Snacks.picker.lsp_definitions({ show_empty = false, confirm = "edit_vsplit", win = { list = { keys = { ["<CR>"] = "edit_vsplit" } } } }) end, desc = "Go to definiton in split" },
	{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Go to declaration" },
	{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
	{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Go to implementation" },
	{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Go to type definition" },
	{ "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
	{ "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature help" },
	{ "<C-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help" },
	{ "<Leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = {"n","v"} },
	{ "<Leader>cA", function() vim.lsp.buf.code_action({apply = true, context = {only = {"source"}, diagnostics = {}}}) end, desc = "Source action" },
	{ "<Leader>cc", vim.lsp.codelens.run, desc = "Run code lens", mode = {"n", "v"} },
	{ "<Leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & display codelens" },
	{ "<Leader>r", vim.lsp.buf.rename, desc = "Rename symbol" },
	{
		"<Leader>R",
		function()
			local old = vim.fn.expand("<cword>")
			vim.ui.input(
				{ prompt = 'Replace "' .. old .. '" with: ', default = old, completion = "buffer" },
				function(new)
					if new ~= nil then
						vim.cmd("%s/\\<" .. old .. "\\>/" .. new .. "/gI")
					end
				end
			)
		end,
		desc = "Replace word under cursor",
	},

}

local map = function(lhs, rhs, opts, mode)
	vim.keymap.set(mode or "n", lhs, rhs, opts or {})
end

for _, key in pairs(keys) do
	local lhs = key[1]
	local rhs = key[2]
	local opts = {
		desc = key.desc,
		expr = key.expr or false,
		nowait = key.nowait or false,
		remap = key.remap or false,
		silent = key.silent or false,
	}
	map(lhs, rhs, opts, key.mode or "n")
end

