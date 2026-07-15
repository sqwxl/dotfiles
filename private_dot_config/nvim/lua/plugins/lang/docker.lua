vim.filetype.add({
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
	},
})

return {
	{
		"mason-org/mason.nvim",
		optional = true,
		opts = {
			ensure_installed = { "hadolint" },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = { ensure_installed = { "dockerfile" } },
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				dockerfile = { "hadolint" },
			},
		},
	},
}
