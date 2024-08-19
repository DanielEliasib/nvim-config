return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			winopts = {
				height     = 0.85, -- window height
				width      = 0.75, -- window width
				fullscreen = false, -- start fullscreen?
				preview    = {
					vertical  = 'up:45%', -- up|down:size
					layout    = 'vertical', -- horizontal|vertical|flex
					title     = true, -- preview border title (file/buf)?
					title_pos = "left", -- left|center|right, title alignment
					delay = 20,
				},
			},
		})

		fzf = require('fzf-lua')

		vim.keymap.set('n', '<leader>ff', fzf.files, { desc = "Find files" })
		vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = "Live grep" })
		vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = "Buffers" })
		vim.keymap.set('n', '<leader>fh', fzf.helptags, { desc = "Help tags" })
		vim.keymap.set('n', '<leader>fr', fzf.resume, { desc = "Resume search" })
	end
}
