return {
	"dnlhc/glance.nvim",
	event = 'VeryLazy',
	config = function()
		local glance = require('glance')
		glance.setup({
			border = {
				enable = true, -- Show window borders. Only horizontal borders allowed
				top_char = '―',
				bottom_char = '―',
			},
			theme = { -- This feature might not work properly in nvim-0.7.2
				enable = true, -- Will generate colors for the plugin based on your current colorscheme
				mode = 'brighten', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
			},
		})
		local wk = require("which-key")
		wk.add(
			{
				{ "<leader>gd", "<cmd>Glance definitions<cr>",      desc = "Glance definitions",      mode = "n" },
				{ "<leader>gr", "<cmd>Glance references<cr>",       desc = "Glance references",       mode = "n" },
				{ "<leader>gt", "<cmd>Glance type_definitions<cr>", desc = "Glance type_definitions", mode = "n" },
				{ "<leader>gi", "<cmd>Glance implementations<cr>",  desc = "Glance implementations",  mode = "n" },
			}
		)
	end
}
