return {
	"shortcuts/no-neck-pain.nvim",
	opts = {
		-- The width of the focused window that will be centered. When the terminal width is less than the `width` option, the side buffers won't be created.
		--- @type integer|"textwidth"|"colorcolumn"
		width = 115,
		--- @type table
		mappings = {
			-- When `true`, creates all the mappings that are not set to `false`.
			--- @type boolean
			enabled = true,
			-- Sets a global mapping to Neovim, which allows you to toggle the plugin.
			-- When `false`, the mapping is not created.
			--- @type string
			toggle = "<Leader>np",
			-- Sets a global mapping to Neovim, which allows you to toggle the left side buffer.
			-- When `false`, the mapping is not created.
			--- @type string
			toggleLeftSide = "<Leader>nql",
			-- Sets a global mapping to Neovim, which allows you to toggle the right side buffer.
			-- When `false`, the mapping is not created.
			--- @type string
			toggleRightSide = "<Leader>nqr",
		},
		--- Common options that are set to both side buffers.
		--- See |NoNeckPain.bufferOptions| for option scoped to the `left` and/or `right` buffer.
		--- @type table
		buffers = {
			-- Leverages the side buffers as notepads, which work like any Neovim buffer and automatically saves its content at the given `location`.
			-- note: quitting an unsaved scratchPad buffer is non-blocking, and the content is still saved.
			--- see |NoNeckPain.bufferOptionsScratchPad|
			scratchPad = {
				-- When `true`, automatically sets the following options to the side buffers:
				-- - `autowriteall`
				-- - `autoread`.
				--- @type boolean
				enabled = true,
				-- The path to the file to save the scratchPad content to and load it in the buffer.
				--- @type string?
				--- @example: `~/notes.norg`
				pathToFile = "~/nnp-scratchPad.md",
			},
			--- Options applied to the `right` buffer, options defined here overrides the `buffers` ones.
			--- @see NoNeckPain.bufferOptions `:h NoNeckPain.bufferOptions`
			right = { enabled = false },
		},
	}
}
