return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = true,
	cmd = { 'TroubleToggle', 'Trouble' },
	event = "VimEnter",
	opts = {
		mode = "document_diagnostics",
	},
	init = function()
		vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle("diagnostics") end, { desc = "Trouble: Toggle Diagnostics"})
		vim.keymap.set("n", "<leader>xs", function() require("trouble").toggle("symbols") end, { desc = "Trouble: Toggle Symbols"})
		vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = "Trouble: Toggle Quickfix"})
		vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = "Trouble: Toggle Loclist"})
		vim.keymap.set("n", "<leader>xc", function() require("trouble").toggle("todo") end, { desc = "Trouble: Toggle Todo"})
	end,
}
