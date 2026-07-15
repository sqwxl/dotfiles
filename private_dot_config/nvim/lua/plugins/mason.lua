return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			-- global tools; lang/* files append their own via opts_extend
			ensure_installed = { "stylua", "shfmt", "xmlformatter" },
		},
		keys = { { "<Leader>cm", "<Cmd>Mason<CR>", desc = "Mason" } },
		config = function(_, opts)
			require("mason").setup(opts)

			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				-- re-trigger FileType so newly-installed tools attach without restart
				vim.defer_fn(function()
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local ok, p = pcall(mr.get_package, tool)
					if ok and not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
}
