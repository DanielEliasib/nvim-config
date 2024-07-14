return {
	'stevearc/oil.nvim',
	init = function()
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
	opts = {
		columns = {
			'icon',
			'size',
			'mtime'
		},
	},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
