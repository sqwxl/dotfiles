-- vim.lsp.config("html", {
-- 	filetypes = {
-- 		"html",
-- 		"templ",
-- 		"htmldjango",
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
-- 		if filetype == "htmldjango" then
-- 			client.server_capabilities.documentFormattingProvider = false
-- 			client.server_capabilities.documentRangeFormattingProvider = false
-- 		end
-- 	end,
-- })
-- vim.lsp.enable("html")

return {
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				html = { "prettierd" },
				htmldjango = { "djlint" },
				jinja = { "djlint" },
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				html = { "htmlhint" },
				htmldjango = { "djlint" },
				jinja = { "djlint" },
			},
		},
	},

	{
		"windwp/nvim-ts-autotag",
		opts = { aliases = { htmldjango = "html" } },
	},
}
