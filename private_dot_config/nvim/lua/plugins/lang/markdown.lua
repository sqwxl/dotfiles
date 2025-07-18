return {
	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "markdownlint-cli2" } },
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["markdown"] = { "prettier", "markdownlint-cli2" },
				["markdown.mdx"] = { "prettier", "markdownlint-cli2" },
			},
			formatters = {
				["markdownlint-cli2"] = {
					condition = function(_, ctx)
						local diag = vim.tbl_filter(function(d)
							return d.source == "markdownlint"
						end, vim.diagnostic.get(ctx.buf))
						return #diag > 0
					end,
				},
			},
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		opts = function()
			local cmd
			-- native
			if vim.fn.has("linux") == 1 then
				if vim.fn.executable("flatpak-spawn") == 1 then
					cmd = "flatpak-spawn --host xdg-open"
				else
					cmd = "xdg-open"
				end
			elseif vim.fn.has("mac") == 1 then
				cmd = "open"
			elseif vim.fn.has("win32") == 1 then
				cmd = "start"
			end

			vim.cmd(string.format(
				[[function OpenMarkdownPreview (url)
					call system('%s ' . shellescape(a:url) . ' &')
				endfunction]],
				cmd
			))

			vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
		end,
		config = function()
			vim.cmd([[do FileType]])
		end,
		keys = {
			{ "<leader>cP", "<Cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Markdown preview" },
		},
	},
}
