return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		enabled = true,
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		event = "VeryLazy",
		opts = {
			debug = false, -- Enable debugging

			model = 'gpt-4o',
			temperature = 0.4,
			show_help = false,

			window = {
				layout = 'horizontal', -- 'vertical', 'horizontal', 'float'
				width = 1, -- fractional width of parent, or absolute width in columns when > 1
				height = 0.45, -- fractional height of parent, or absolute height in rows when > 1
				title = 'Chat', -- title of chat window
				relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'


			},
			prompts = {
				Diagnostics = {
					prompt = '/COPILOT_GENERATE Provide solutions to the following diagnostics:',
					selection = function(source)
						local bufnr = source.bufnr
						local select = require('CopilotChat.select')
						local select_buffer = select.buffer(source)
						local winnr = source.winnr
						if not select_buffer then
							return nil
						end
						local cursor = vim.api.nvim_win_get_cursor(winnr)

						file_diagnositcs = vim.diagnostic.get(bufnr,
							{ severity = { min = vim.diagnostic.severity.HINT } })
						if #file_diagnositcs == 0 or file_diagnositcs == nil then
							return nil
						end
						local diagnostics = {}
						for _, diagnostic in ipairs(file_diagnositcs) do
							table.insert(diagnostics, diagnostic.message)
						end

						local result = table.concat(diagnostics, '. ')
						result = result:gsub('^%s*(.-)%s*$', '%1'):gsub('\n', ' ')

						local file_name = vim.api.nvim_buf_get_name(bufnr)
						select_buffer.prompt_extra = file_name .. ':' .. cursor[1] .. '. ' .. result
						return select_buffer
					end
				}
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
