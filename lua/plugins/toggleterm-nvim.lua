return {
	'akinsho/toggleterm.nvim',
	version = "*",
	event = 'VeryLazy',
	lazy = true,
	config = function()
		local local_user = require('local_configs/local_user')
		local selected_shell = local_user.is_windows and (vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell') or 'zsh'
		require("toggleterm").setup {
			shell = selected_shell,
			open_mapping = [[<c-t>]],
		}
	end
}
