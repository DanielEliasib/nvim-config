return {
	{
		'DanielEliasib/sweet-fusion',
		name = 'sweet-fusion',
		priority = 1000,
		opts = {
			-- Set transparent background
			transparency = true,
			dim_inactive = false,
		}
	},
	{
		'rebelot/kanagawa.nvim',
		lazy = true,
		opts = {
			undercurl = true,
			commentStyle = { italic = true },
			keywordStyle = { italic = true },
			transparent = true,
			dimInactive = false,
			terminalColors = true,
			theme = "dragon",
			background = {
				dark = "dragon",
				light = "lotus",
			}
		}
	},
}
