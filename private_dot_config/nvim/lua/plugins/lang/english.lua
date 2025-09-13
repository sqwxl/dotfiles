vim.lsp.config("harper_ls", {
	settings = {
		["harper-ls"] = {
			userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
			codeActions = { forceStable = true },
			linters = { avoid_curses = false },
		},
	},
})
vim.lsp.enable("harper-ls", false)

return {}
