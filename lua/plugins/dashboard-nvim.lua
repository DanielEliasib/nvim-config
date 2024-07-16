-- callback_fun = function()
-- 	if vim.fn.argc() == 0 then
-- 		-- wait 1 sec
-- 		vim.defer_fn(function()
-- 			vim.cmd("Telescope neovim-project theme=ivy")
-- 		end, 100)
-- 	end
-- end

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = callback_fun,
-- })

local local_user = require("local_configs/local_user")

return {
	{
		"nvimdev/dashboard-nvim",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		priority = 500,
		lazy = false,
		enabled = true,
		config = function()
			local custom_footer = function()
				-- we current time:
				local current_date = os.date("%d/%m/%Y")
				local system_data = vim.fn.systemlist("uname -s")
				local icon = system_data[1] == 'Linux' and '  ' or '  '
				local centerd_user = local_user.centered_user_id
				return { " ", " ", " ", current_date, " ", centerd_user, icon, " " }
			end

			require("dashboard").setup({
				theme = "hyper",
				config = {
					disable_move = true,
					shortcut = {
						{
							icon = " ",
							icon_hl = '@variable',
							desc = "Projects ",
							group = "@tag",
							action = "Telescope neovim-project",
							key = "p",
						},
						{
							icon = '󰮳 ',
							icon_hl = '@variable',
							desc = 'Last Session ',
							group = 'DiagnosticHint',
							action = 'NeovimProjectLoadRecent',
							key = 'l',
						},
						{
							icon = ' ',
							icon_hl = '@variable',
							desc = 'Find Projects ',
							group = '@variable',
							action = 'Telescope neovim-project discover',
							key = 'k',
						},
					},
					header = {
						[[                                    ]],
						[[                                    ]],
						[[        _                           ]],
						[[        \`*-.                       ]],
						[[         )  _`-.                    ]],
						[[        .  : `. .                   ]],
						[[        : _   '  \                  ]],
						[[        ; *` _.   `*-._             ]],
						[[        `-.-'          `-.          ]],
						[[          ;       `       `.        ]],
						[[          :.       .        \       ]],
						[[          . \  .   :   .-'   .      ]],
						[[          '  `+.;  ;  '      :      ]],
						[[          :  '  |    ;       ;-.    ]],
						[[          ; '   : :`-:     _.`* ;   ]],
						[[[nvim] .*' /  .*' ; .*`- +'  `*'    ]],
						[[       `*-*   `*-*  `*-*'           ]],
						[[                                    ]],
						[[                                    ]],
					},
					packages = { enable = true },
					project = { enable = false },
					mru = { limit = 3 },
					footer = custom_footer(),
				},
			})
		end,
	},
}
