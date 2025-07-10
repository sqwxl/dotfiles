return {
	"stevearc/aerial.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		attach_mode = "window",
		backends = { "lsp", "treesitter", "markdown", "man" },
		layout = {
			resize_to_content = false,
			win_opts = {
				winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
				signcolumn = "yes",
				statuscolumn = " ",
			},
		},
		show_guides = true,
		guides = {
			mid_item = "├╴",
			last_item = "└╴",
			nested_top = "│ ",
			whitespace = "  ",
		},
		-- HACK: fix lua's weird choice for `Package` for control structures like if/else/for/etc.
		icons = vim.tbl_extend("force", {}, Sqwxl.icons.kinds, { Package = Sqwxl.icons.kinds.Control }),
	},
	keys = {
		{ "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
	},
}
