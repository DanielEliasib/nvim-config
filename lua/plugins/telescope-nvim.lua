return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		lazy = true,
		module = false,
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local actions = require("telescope.actions")
			local trouble = require("trouble.sources.telescope")

			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
				defaults = {
					path_display = { "tail" },
					dynamic_preview_title = true,
					layout_strategy = "vertical",
					file_ignore_patterns = { "node_modules", ".git" },
					layout_config = {
						height = 0.8,
						width = 0.8
					}
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{
		{ "nvim-telescope/telescope-fzf-native.nvim", build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
	},
}
