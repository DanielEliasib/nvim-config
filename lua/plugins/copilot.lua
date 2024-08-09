return {
	{
		'zbirenbaum/copilot.lua',
		event = 'VeryLazy',
		lazy = true,
		enabled = true,
		config = function()
			require('copilot').setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>"
					},
					layout = {
						position = "right", -- | top | left | right
						ratio = 0.35
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					debounce = 50,
					keymap = {
						accept = false,
						accept_word = false,
						accept_line = "<S-Tab>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = true,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = 'node', -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})

			vim.keymap.set('i', '<Tab>', function()
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, { desc = "Super Tab" })
		end

	}
}
