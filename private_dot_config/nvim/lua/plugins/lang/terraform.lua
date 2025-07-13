vim.lsp.config("terraformls", {})
vim.lsp.enable("terraformls")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "terraform", "hcl" } },
	},

	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "tflint" } },
	},

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				terraform = { "terraform_validate" },
				tf = { "terraform_validate" },
			},
		},
	},

	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				hcl = { "packer_fmt" },
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
			},
		},
	},
}
