vim.filetype.add({
	filename = {
		[".gitlab-ci.yml"] = "yaml.gitlab",
		[".gitlab-ci.yaml"] = "yaml.gitlab",
	},
	pattern = {
		[".*/%.gitlab/.*%.ya?ml"] = "yaml.gitlab",
	},
})

return {
	{
		"mason-org/mason.nvim",
		optional = true,
		opts = { ensure_installed = { "yamlfix" } },
	},

	{
		"b0o/schemastore.nvim",
		lazy = true,
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				yaml = { "yamlfix" },
				-- conform matches the full dotted filetype, so these need their own entries
				["yaml.docker-compose"] = { "yamlfix" },
				["yaml.gitlab"] = { "yamlfix" },
			},
		},
	},
}
