return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- Optional
		{
			"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
			opts = {},
		},
	},
	config = true,
	opts = {
		adapters = {
			llama3 = function()
				return require("codecompanion.adapters").use("ollama", {
					schema = {
						model = {
							default = "llama3.1:latest",
						},
						temperature = {
							default = 0.45
						},
						num_ctx = {
							default = 2048,
						},
						num_predict = {
							default = -1,
						},
					},
				})
			end,
			codestral = function()
				return require("codecompanion.adapters").use("ollama", {
					schema = {
						model = {
							default = "codestral:22b-v0.1-q2_K",
						},
						temperature = {
							default = 0.45
						},
						num_ctx = {
							default = 2048,
						},
						num_predict = {
							default = -1,
						},
					},
				})
			end,
		},
		strategies = {
			chat = {
				adapter = "llama3",
				roles = {
					llm = "chat",
					user = "user"
				}
			},
			inline = {
				adapter = "llama3",
			},
			agent = {
				adapter = nil,
			},
		},
		display = {
			action_palette = {
				width = 95,
				height = 10,
			},
			chat = {
				window = {
					layout = "horizontal", -- float|vertical|horizontal|buffer
					border = "single",
					height = 0.35,
					width = 1,
					relative = "editor",
					opts = {
						breakindent = true,
						cursorcolumn = false,
						cursorline = false,
						foldcolumn = "0",
						linebreak = true,
						list = false,
						signcolumn = "no",
						spell = false,
						wrap = true,
					},
				},
				intro_message = "Chat ✨! Press ? for help",

				messages_separator = "─*", -- The separator between the different messages in the chat buffer
				show_separator = true, -- Show a separator between LLM responses?
				show_settings = false, -- Show LLM settings at the top of the chat buffer?
				show_token_count = true, -- Show the token count for each response?
			},
			inline = {
				layout = "vertical", -- vertical|horizontal|buffer
				diff = {
					enabled = true,
					priority = 130,
					highlights = {
						removed = "DiffDelete",
					},
				},
			},
		},
		default_prompts = {
			["Generate a Staged Commit Message"] = {
				strategy = "chat",
				description = "Generate a commit message for staged files",
				opts = {
					index = 6,
					default_prompt = true,
					slash_cmd = "commitstaged",
					auto_submit = true,
				},
				prompts = {
					{
						role = "${user}",
						contains_code = true,
						content = function()
							return
								"You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:"
								.. "\n\n```\n"
								.. vim.fn.system("git diff --no-color --no-ext-diff --staged")
								.. "\n```"
						end,
					},
				},
			}
		},
		opts = {
			log_level = "TRACE"
		},
	}
}
