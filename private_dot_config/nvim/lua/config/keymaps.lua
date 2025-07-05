local diagnostic_goto = function(next, severity)
	severity = severity and vim.diagnostic.severity[severity] or nil

	return function()
		vim.diagnostic.jump({ count = next and 1 or -1, float = true, severity = severity })
	end
end

---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
	local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
	local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

	config = vim.deepcopy(config)
	---@cast args string[]
	config.args = function()
		local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
		if config.type and config.type == "java" then
			---@diagnostic disable-next-line: return-type-mismatch
			return new_args
		end
		return require("dap.utils").splitstr(new_args)
	end
	return config
end

local map = function(lhs, rhs, opts, mode)
	vim.keymap.set(mode or "n", lhs, rhs, opts or {})
end

local keymaps = {
	core = {
		{ "<S-CR>", ":", silent = false, desc = "Command line" },
		{ "<Esc>", "<C-Bslash><C-n>", mode = "t" },
		{
			"<C-c>",
			function()
				vim.cmd("noh")
				if vim.snippet then
					vim.snippet.stop()
				end
				return "<esc>"
			end,
			expr = true,
			desc = "Escape and Clear hlsearch",
			mode = { "i", "n", "s" },
		},

		-- better movement
		{
			"j",
			"v:count == 0 ? 'gj' : 'j'",
			desc = "Down",
			expr = true,
			silent = true,
			mode = { "n", "x" },
		},
		{
			"<Down>",
			"v:count == 0 ? 'gj' : 'j'",
			desc = "Down",
			expr = true,
			silent = true,
			mode = { "n", "x" },
		},
		{
			"k",
			"v:count == 0 ? 'gk' : 'k'",
			desc = "Up",
			expr = true,
			silent = true,
			mode = { "n", "x" },
		},
		{
			"<Up>",
			"v:count == 0 ? 'gk' : 'k'",
			desc = "Up",
			expr = true,
			silent = true,
			mode = { "n", "x" },
		},
		{ "{", "}", mode = "" },
		{ "}", "{", mode = "" },
		{
			"H",
			"^",
			desc = "Start of line",
			mode = "",
		},
		{
			"L",
			"$",
			desc = "End of line",
			mode = "",
		},

		-- keep cursor centered when scrolling
		{ "<C-u>", "<C-u>zz" },
		{ "<C-d>", "<C-d>zz" },

		-- move lines
		{ "<A-S-t>", "<cmd>execute 'move .+' . v:count1<cr>==", desc = "Move Down" },
		{ "<A-S-c>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", desc = "Move Up" },
		{
			"<A-S-t>",
			"<esc><cmd>m .+1<cr>==gi",
			desc = "Move Down",
			mode = "i",
		},
		{
			"<A-S-t>",
			"<esc><cmd>m .-2<cr>==gi",
			desc = "Move Up",
			mode = "i",
		},
		{
			"<A-S-t>",
			":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
			desc = "Move Down",
			mode = "v",
		},
		{
			"<A-S-c>",
			":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
			desc = "Move Up",
			mode = "v",
		},
		{ "<", "<gv", mode = "v" },
		{ ">", ">gv", mode = "v" },

		-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
		{
			"n",
			"'Nn'[v:searchforward].'zv'",
			expr = true,
			desc = "Next Search Result",
		},
		{
			"n",
			"'Nn'[v:searchforward]",
			expr = true,
			desc = "Next Search Result",
			mode = "x",
		},
		{
			"n",
			"'Nn'[v:searchforward]",
			expr = true,
			desc = "Next Search Result",
			mode = "o",
		},
		{
			"N",
			"'nN'[v:searchforward].'zv'",
			expr = true,
			desc = "Prev Search Result",
		},
		{
			"N",
			"'nN'[v:searchforward]",
			expr = true,
			desc = "Prev Search Result",
			mode = "x",
		},
		{
			"N",
			"'nN'[v:searchforward]",
			expr = true,
			desc = "Prev Search Result",
			mode = "o",
		},

		-- Add undo break-points
		{ ",", ",<C-g>u", mode = "i" },
		{ ".", ".<C-g>u", mode = "i" },
		{ ";", ";<C-g>u", mode = "i" },

		-- Write
		{
			"<C-s>",
			"<cmd>w<cr><esc>",
			desc = "Save File",
			mode = { "i", "x", "n", "s" },
		},

		{ "Q", "@q" },

		-- saner command history
		{
			"<C-p>",
			function()
				return vim.fn.wildmenumode() and "<Up>" or "<C-p>"
			end,
			expr = true,
			silent = false,
			mode = "c",
		},
		{
			"<C-n>",
			function()
				return vim.fn.wildmenumode() and "<Down>" or "<C-n>"
			end,
			expr = true,
			silent = false,
			mode = "c",
		},

		-- windows & tabs
		{ "<C-Tab>", "<Cmd>tabnext #<CR>", desc = "Go to last accessed window" },
		{
			"<S-Tab>",
			"<C-w>W",
			desc = "Go to window above/left",
			mode = { "n", "v" },
		},
		{
			"<Tab>",
			"<C-w>w",
			desc = "Go to window below/right",
			mode = { "n", "v" },
		},
		{ "<C-i>", "<Tab>", mode = { "n", "v" } }, -- CTRL-I can be mapped separately from <Tab>, on the condition that both keys are mapped, otherwise the mapping applies to both.
		{ "<A-h>", "<C-w>h", desc = "Move left" },
		{
			"<A-h>",
			"<C-Bslash><C-N><C-w>h",
			desc = "Move left",
			mode = { "t", "i" },
		},
		{ "<A-t>", "<C-w>j", desc = "Move down" },
		{
			"<A-t>",
			"<C-Bslash><C-N><C-w>j",
			desc = "Move down",
			mode = { "t", "i" },
		},
		{ "<A-c>", "<C-w>k", desc = "Move up" },
		{
			"<A-c>",
			"<C-Bslash><C-N><C-w>k",
			desc = "Move up",
			mode = { "t", "i" },
		},
		{ "<A-n>", "<C-w>l", desc = "Move right" },
		{
			"<A-n>",
			"<C-Bslash><C-N><C-w>l",
			desc = "Move right",
			mode = { "t", "i" },
		},

		{
			"<C-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},

		-- flash.nvim
		{
			"s",
			function()
				require("flash").jump()
			end,
			desc = "Flash",
			mode = { "n", "x", "o" },
		},
		{
			"S",
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
			mode = { "n", "o", "x" },
		},
		{
			"r",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
			mode = "o",
		},
		{
			"R",
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
			mode = { "o", "x" },
		},
		{
			"<C-s>",
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
			mode = { "c" },
		},

		{
			"<A-a>",
			function()
				require("treesj").toggle()
			end,
			desc = "Toggle fold/unfold tree structures",
		},
	},

	match = {
		{ "mm", "%", desc = "Go to matching bracket", mode = "" },
		{ "<C-g>s", "<Plug>(nvim-surround-insert)", desc = "Surround", mode = "i" },
		{ "ms", "<Plug>(nvim-surround-normal)", desc = "Surround" },
		{ "mr", "<Plug>(nvim-surround-change)", desc = "Replace surround character" },
		{ "md", "<Plug>(nvim-surround-delete)", desc = "Delete surround character" },
	},

	leader = {
		{"<Leader>a", nil, desc = "AI"},
		-- quit
		{
			"<Leader>qq",
			"<cmd>qa<cr>",
			desc = "Quit All",
		},

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
			desc = "Location List",
		},
		-- quickfix list
		{
			"<Leader>xq",
			function()
				local success, err =
					pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
				if not success and err then
					vim.notify(err, vim.log.levels.ERROR)
				end
			end,
			desc = "Quickfix List",
		},

		-- lazy
		{
			"<Leader>l",
			"<cmd>Lazy<cr>",
			desc = "Lazy",
		},

		-- new file
		{
			"<Leader>n",
			"<cmd>enew<cr>",
			desc = "New File",
		},

		{
			"<Leader><Space>",
			"<Cmd>e#<CR>",
			desc = "Go to last accessed buffer",
		},

		-- Top Pickers & Explorer
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},
		{
			"<leader><c-w>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Window Hydra Mode (which-key)",
		},
		{
			"<Leader>$",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		{
			"<Leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<Leader>.",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<Leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<Leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<Leader>A",
			function()
				vim.lsp.buf.code_action({ apply = true, context = { only = { "source" }, diagnostics = {} } })
			end,
			desc = "Source Action",
		},
		{
			"<Leader>ca",
			vim.lsp.buf.code_action,
			desc = "Code Action",
			mode = { "n", "v" },
		},
		{
			"<Leader>d",
			vim.diagnostic.open_float,
			desc = "Line Diagnostics",
		},
		{
			"<Leader>e",
			"<Cmd>Neotree toggle=true<CR>",
			desc = "Toggle Neotree",
		},
		{
			"<A-Bslash>",
			"<Cmd>Neotree reveal=true<CR>",
			desc = "Reveal in Neotree",
		},
		{
			"<Leader>f",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		-- {
		-- 	"<Leader>g",
		-- 	function()
		-- 		Snacks.picker.git_files()
		-- 	end,
		-- 	desc = "Find Git Files",
		-- },
		{
			"<Leader>K",
			"<cmd>norm! K<cr>",
			desc = "Keywordprg",
		},
		{
			"<Leader>W",
			function()
				local nr = require("window-picker").pick_window()
				if nr ~= nil then
					vim.cmd.wincmd(nr .. " w")
				end
			end,
			desc = "Pick window",
		},

		{
			"<Leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},

		-- UI (u)
		{
			"<Leader>un",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<Leader>uN",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<Leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},

		-- Search (s)
		{
			"<Leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<Leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<Leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<Leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			'<Leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<Leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		{
			"<Leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<Leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<Leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<Leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<Leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<Leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<Leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<Leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<Leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<Leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<Leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<Leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},
		{
			"<Leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<Leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<Leader>sp",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Search for Plugin Spec",
		},
		{
			"<Leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<Leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<Leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<Leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<Leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},

		-- Debugger (d)
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Breakpoint Condition",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Run/Continue",
		},
		{
			"<leader>da",
			function()
				require("dap").continue({ before = get_args })
			end,
			desc = "Run with Args",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<leader>dg",
			function()
				require("dap").goto_()
			end,
			desc = "Go to Line (No Execute)",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "Down",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "Up",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dP",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<leader>ds",
			function()
				require("dap").session()
			end,
			desc = "Session",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Widgets",
		},

		-- Git (g)
		{
			"<Leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse (open)",
			mode = { "n", "x" },
		},
		{
			"<Leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<Leader>gL",
			"<Cmd>%diffget REMOTE<CR>",
			desc = "Get all REMOTE hunks",
		},
		{
			"<Leader>gU",
			"<Cmd>%diffget LOCAL<CR>",
			desc = "Get all LOCAL hunks",
		},
		{
			"<Leader>gb",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<Leader>gg",
			function()
				Snacks.terminal({ "gitui" })
			end,
			desc = "GitUi (Root Dir)",
		},
		{
			"<Leader>gl",
			"<Cmd>diffget REMOTE<CR>",
			desc = "Get REMOTE hunk",
		},
		{
			"<Leader>gu",
			"<Cmd>diffget LOCAL<CR>",
			desc = "Get LOCAL hunk",
		},
		{
			"<leader>ge",
			"<Cmd>Neotree source=git_status toggle=true<CR>",
			desc = "Git Explorer",
		},

		-- Code (c)
		{
			"<Leader>cl",
			function()
				Snacks.picker.lsp_config()
			end,
			desc = "LSP info",
		},
		{
			"<Leader>cm",
			"<Cmd>Mason<CR>",
			desc = "Mason",
			mode = { "n", "v" },
		},
		{
			"<Leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer",
			mode = { "n", "v" },
		},
		{
			"<leader>cF",
			function()
				require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
			end,
			desc = "Format Injected Langs",
			mode = { "n", "v" },
		},
		{
			"<Leader>cc",
			vim.lsp.codelens.run,
			desc = "Run Codelens",
			mode = { "n", "v" },
		},
		{
			"<Leader>cC",
			vim.lsp.codelens.refresh,
			desc = "Refresh & Display Codelens",
		},
		{
			"<Leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>cp",
			ft = "markdown",
			"<cmd>MarkdownPreviewToggle<cr>",
			desc = "Markdown Preview",
		},
		{ "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
		{
			"<leader>cn",
			function()
				require("neogen").generate()
			end,
			desc = "Generate Annotations (Neogen)",
		},
		{ "<Leader>r", vim.lsp.buf.rename, desc = "Rename" },
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
	},

	bracket = {

		{
			"]]",
			function()
				require("sqwxl.lsp_refs").jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				require("sqwxl.lsp_refs").jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},

		{ "[b", "<cmd>bprevious<cr>", desc = "Prev Buffer" },
		{ "]b", "<cmd>bnext<cr>", desc = "Next Buffer" },

		{ "]d", diagnostic_goto(true), desc = "Next Diagnostic" },
		{ "[d", diagnostic_goto(false), desc = "Prev Diagnostic" },

		{ "]e", diagnostic_goto(true, "ERROR"), desc = "Next Error" },
		{ "[e", diagnostic_goto(false, "ERROR"), desc = "Prev Error" },

		{ "[q", vim.cmd.cprev, desc = "Previous Quickfix" },
		{ "]q", vim.cmd.cnext, desc = "Next Quickfix" },

		{ "]w", diagnostic_goto(true, "WARN"), desc = "Next Warning" },
		{ "[w", diagnostic_goto(false, "WARN"), desc = "Prev Warning" },

		{ "[<Space>", "<Cmd>put! =repeat(nr2char(10), v:count1)<CR>", desc = "Add empty line(s) above" },
		{ "]<Space>", "<Cmd>put =repeat(nr2char(10), v:count1)<CR>", desc = "Add empty line(s) below" },
	},

	g = {

		{
			"gh",
			"^",
			desc = "Start of line",
			mode = "",
		},
		{
			"gl",
			"$",
			desc = "End of line",
			mode = "",
		},

		{
			"gV",
			function()
				Snacks.picker.lsp_definitions({
					show_empty = false,
					confirm = "edit_vsplit",
					win = { list = { keys = { ["<CR>"] = "edit_vsplit" } } },
				})
			end,
			desc = "Go to definiton in split",
		},
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},

		{
			"gp",
			"<cmd>bprevious<cr>",
			desc = "Prev Buffer",
		},
		{
			"gn",
			"<cmd>bnext<cr>",
			desc = "Next Buffer",
		},

		{
			"gK",
			function()
				return vim.lsp.buf.signature_help()
			end,
			desc = "Signature help",
		},
		{
			"<C-s>",
			function()
				return vim.lsp.buf.signature_help()
			end,
			desc = "Signature help",
			mode = "i",
		},

		-- commenting
		{
			"gco",
			"o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>",
			desc = "Add Comment Below",
		},
		{
			"gcO",
			"O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>",
			desc = "Add Comment Above",
		},
	},
}

for _, group in pairs(keymaps) do
	for _, key in pairs(group) do
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
end
