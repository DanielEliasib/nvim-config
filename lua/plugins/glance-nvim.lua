return {
	"dnlhc/glance.nvim",
	event = 'VeryLazy',
	opts = {
		border = {
			enable = true, -- Show window borders. Only horizontal borders allowed
			top_char = '―',
			bottom_char = '―',
		},
		theme = {  -- This feature might not work properly in nvim-0.7.2
			enable = true, -- Will generate colors for the plugin based on your current colorscheme
			mode = 'brighten', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
		},
	},
}
