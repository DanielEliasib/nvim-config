return {
    {
        'williamboman/mason.nvim',
        opts = {},
		dependencies = {'williamboman/mason-lspconfig.nvim'}
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {},
		dependencies = {'williamboman/mason.nvim', 'mfussenegger/nvim-dap'}
    },
    {
        'williamboman/mason-lspconfig.nvim',
		event = 'VimEnter',
        opts = {},
		config = function()
			require('mason-lspconfig').setup()
		end
    }

}
