return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = 'VeryLazy',
		lazy = true,
		config = function()
			require('nvim-treesitter.configs').setup {
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>", -- TODO: Check if this are good keymaps
						node_incremental = "<CR>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,

						keymaps = {
							['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },

						}

					}

				}
			}
		end
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		event = 'VeryLazy',
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
	}
}
