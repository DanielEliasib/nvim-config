return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		event = "VeryLazy",
		opts = {
			debug = true, -- Enable debugging

			model = 'gpt-4',
			temperature = 0.2,
			show_help = false,

			window = {
				layout = 'horizontal', -- 'vertical', 'horizontal', 'float'
				width = 1, -- fractional width of parent, or absolute width in columns when > 1
				height = 0.45, -- fractional height of parent, or absolute height in rows when > 1
				title = 'Chat', -- title of chat window
				relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
				

			},

			-- window = {
			-- 	layout = 'float', -- 'vertical', 'horizontal', 'float'
			-- 	width = 1, -- fractional width of parent, or absolute width in columns when > 1
			-- 	height = 0.45, -- fractional height of parent, or absolute height in rows when > 1
			-- 	-- Options below only apply to floating windows
			-- 	relative = 'cursor', -- 'editor', 'win', 'cursor', 'mouse'
			-- 	border = 'shadow', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
			-- 	title = '', -- title of chat window
			-- 	zindex = 1, -- determines if window is on top or below other floating windows
			-- },

			question_header = '■ User ', -- Header to use for user questions
			answer_header = '■ Copilot ', -- Header to use for AI answers
			error_header = '»» Error ', -- Header to use for errors
		},
		keys = {
			{ '<leader>cc', '<cmd>CopilotChatToggle<CR>', mode = { "n", "v" }, silent = true, nowait = true, noremap = true, desc = 'Toggle Copilot Chat' },
		}
		-- See Commands section for default commands if you want to lazy load on them
	},
}
