return {
	'p00f/clangd_extensions.nvim',
	dependencies = { 'neovim/nvim-lspconfig' },
	-- enabled = false,
	lazy = true,
	ft = { 'c', 'cpp' },
	opts = {
		symbol_info = {
			border = 'single',
		}
	},
	keys = {
		{ '<leader>cs', '<cmd>ClangdSwitchSourceHeader<CR>', silent = true, nowait = true, noremap = true, desc = 'Toggle source/header' },
		{ '<leader>ch', '<cmd>ClangdTypeHierarchy<CR>',      silent = true, nowait = true, noremap = true, desc = 'Clangd Type Hierarchy' }
	},
}

