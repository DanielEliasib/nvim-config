return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
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
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
				-- pickers =
				-- {
				-- 	-- lsp_references =
				-- 	-- {
				-- 	-- 	theme = 'ivy',
				-- 	-- 	layout_config =
				-- 	-- 	{
				-- 	-- 		height = 0.4,
				-- 	-- 		prompt_position = 'bottom',
				-- 	-- 	},
				-- 	-- }
				-- },
				defaults = {
					mappings = {
						i = { ["<c-t>"] = trouble.open, ["<CR>"] = actions.select_default + actions.center },
						n = { ["<c-t>"] = trouble.open, ["<CR>"] = actions.select_default + actions.center },
					},
					path_display = { "tail" },
					dynamic_preview_title = true,
					layout_strategy = "vertical",
					file_ignore_patterns = { "node_modules", ".git" },
					-- vimgrep_arguments = {
					-- 	"rg",
					-- 	"--color=never",
					-- 	"--no-heading",
					-- 	"--with-filename",
					-- 	"--line-number",
					-- 	"--column",
					-- 	"--smart-case",
					-- 	"--trim" -- add this value
					-- }
				},
			})

			require("telescope").load_extension("fzf")

			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
			vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = "Resume search" })
		end,
	},
	{
		{ "nvim-telescope/telescope-fzf-native.nvim", build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
	},
}
