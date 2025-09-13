-- vim.lsp.inlay_hint.enable(false)
--
vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = function(diagnostic)
			local icons = Sqwxl.icons.diagnostics
			for d, icon in pairs(icons) do
				if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
					return icon
				end
			end
			return "●"
		end,
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = Sqwxl.icons.diagnostics.Error,
			[vim.diagnostic.severity.WARN] = Sqwxl.icons.diagnostics.Warn,
			[vim.diagnostic.severity.HINT] = Sqwxl.icons.diagnostics.Hint,
			[vim.diagnostic.severity.INFO] = Sqwxl.icons.diagnostics.Info,
		},
	},
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("sqwxl.lsp", {}),
-- callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--
--     -- Don't use LSP for syntax highlighting
--     client.server_capabilities.semanticTokensProvider = nil
-- end,
-- })
