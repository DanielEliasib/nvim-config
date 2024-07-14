return {
	'mvllow/modes.nvim',
	name = 'modes',
	-- tag = 'v0.2.0',
	event = 'VimEnter',
	config = function()
		require('modes').setup({
			line_opacity = 0.25,
		})
	end,
	dependencies = { 'DanielEliasib/sweet-fusion' }
}
