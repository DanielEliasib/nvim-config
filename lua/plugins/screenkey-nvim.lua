return {
	"NStefan002/screenkey.nvim",
	lazy = false,
	version = "*", -- or branch = "dev", to use the latest commit
	opts = {
		win_opts = {
			row = vim.o.lines - vim.o.cmdheight - 1,
			col = vim.o.columns - 1,
			relative = "editor",
			anchor = "SE",
			width = 40,
			height = 3,
			border = "solid",
		},
	}
}
