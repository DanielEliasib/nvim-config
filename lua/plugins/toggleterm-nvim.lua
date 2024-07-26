return {
	'akinsho/toggleterm.nvim',
	version = "*",
	event = 'VeryLazy',
	lazy = true,
	config = function()
		local wk = require("which-key")
		local local_user = require('local_configs/local_user')
		local selected_shell = local_user.is_windows and (vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell') or
			'zsh'
		require("toggleterm").setup {
			shell = selected_shell,
			shade_terminals = true,
			direction = 'float',
			float_opts = {
				-- The border key is *almost* the same as 'nvim_open_win'
				-- see :h nvim_open_win for details on borders however
				-- the 'curved' border is a custom border type
				-- not natively supported but implemented in this plugin.
				-- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
				border = 'curved',
				-- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
				-- width = <value>,
				width = function(terminal)
					return math.floor(vim.o.columns * 0.88)
				end,
				height = function(terminal)
					return math.floor(vim.o.lines * 0.88)
				end,
				title_pos = 'right' },
		}
		wk.add(
			{
				{ "<c-_>", "<cmd>ToggleTerm direction=float<cr>",                      desc = "Toggle float term",      mode = "nt" },
				{ "<m-/>", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal term", mode = "nt" },
			}
		)
	end
}
