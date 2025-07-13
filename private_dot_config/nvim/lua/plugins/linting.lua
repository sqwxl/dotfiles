return {
	"mfussenegger/nvim-lint",
	opts = {
		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
		linters_by_ft = {
			css = { "biomejs" },
			fish = { "fish" },
			html = { "htmlhint" },
			htmldjango = { "djlint" },
			jinja = { "djlint" },
			sass = { "stylelint" },
			sh = { "shellcheck" },
			-- lua = { "selene", "luacheck" },
			-- ["*"] = { "cspell" },
		},
		linters = {
			stylelint = { stream = "stderr" },
			-- cspell = { args = { "lint", "-c", vim.env.HOME .. "/.config/cspell/cspell.yaml", "--no-color", "--no-progress", "--no-summary" } },
		},
	},
}
