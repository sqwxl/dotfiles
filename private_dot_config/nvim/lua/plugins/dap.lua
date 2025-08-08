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

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"igorlfs/nvim-dap-view",
				opts = {},
				keys = { {
					"<Leader>du",
					"<Cmd>DapViewToggle<CR>",
					desc = "Toggle view",
				} },
			},
			-- "rcarriga/nvim-dap-ui",
			{ "theHamsta/nvim-dap-virtual-text", opts = {} },
		},
		lazy = true,
		opts = function(_, _)
			local dap = require("dap")
			dap.defaults.fallback.external_terminal = {
				command = "/usr/bin/foot",
			}
		end,
		config = function()
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

			for name, sign in pairs(Sqwxl.icons.dap) do
				sign = type(sign) == "table" and sign or { sign }
				vim.fn.sign_define("Dap" .. name, {
					text = sign[1],
					texthl = sign[2] or "DiagnosticInfo",
					linehl = sign[3],
					numhl = sign[3],
				})
			end

			-- setup dap config by VsCode launch.json file
			-- local vscode = require("dap.ext.vscode")
			-- local json = require("plenary.json")
			-- vscode.json_decode = function(str)
			-- 	return vim.json.decode(json.json_strip_comments(str))
			-- end
		end,
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Breakpoint condition",
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
				desc = "Run with args",
			},
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to cursor",
			},
			{
				"<leader>dg",
				function()
					require("dap").goto_()
				end,
				desc = "Go to line (no execute)",
			},
			{
				"<leader>dj",
				function()
					require("dap").down()
				end,
				desc = "Down stack",
			},
			{
				"<leader>dk",
				function()
					require("dap").up()
				end,
				desc = "Up stack",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run last",
			},

			{
				"<left>",
				function()
					require("dap").restart_frame()
				end,
				desc = "Restart frame",
			},
			{
				"<up>",
				function()
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<down>",
				function()
					require("dap").step_out()
				end,
				desc = "Step out",
			},
			{
				"<right>",
				function()
					require("dap").step_over()
				end,
				desc = "Step over",
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
		},
	},

	{
		"igorlfs/nvim-dap-view",
		lazy = true,
		---@module 'dap-view'
		---@type dapview.Config
		opts = {
			auto_toggle = true,
			winbar = {
				default_section = "repl",
				sections = { "breakpoints", "watches", "scopes", "exceptions", "repl", "console", "threads" },
			},
			windows = { terminal = { hide = { "ruby", "go" } } },
		},
	},

	{
		enabled = false,
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
		config = function(_, opts)
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup(opts)
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle({})
				end,
				desc = "Dap UI",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				desc = "Eval",
				mode = { "n", "v" },
			},
		},
	},

	{
		enabled = false,
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			{
				"microsoft/vscode-js-debug",
				lazy = true,
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
		},
		opts = {
			debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
		},
	},
}
