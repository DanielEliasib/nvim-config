vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.updatetime = 200
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.wrap = false

vim.opt.signcolumn = "yes"

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.termguicolors = true

vim.cmd('syntax enable')

-- Custom Windows Terminal Title
vim.opt.title = true
vim.opt.titlestring = [[%{fnamemodify(getcwd(), ':t')}]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins')

function open_dashboard()
	-- open dashboard
	local width = vim.api.nvim_get_option("columns") -- get the screen width
	local height = vim.api.nvim_get_option("lines") -- get the screen height
	local buf = vim.api.nvim_create_buf(false, true) -- create an empty buffer

	local x_pos = 0 -- calculate the x position
	local y_pos = 0 -- calculate the y position

	local win = vim.api.nvim_open_win(0, true, { -- create a new floating window
		relative = "editor",                      -- position relative to the editor
		width = width,                               -- window width
		height = height,                              -- window height
		col = x_pos,       -- window x position
		row = y_pos,      -- window y position
		style = "minimal"                         -- remove window decorations
	})
	vim.cmd("Dashboard")                 -- run the Dashboard command in the terminal buffer -- set the buffer type to nofile
end

vim.api.nvim_create_user_command("Dash", open_dashboard, { nargs = 0 })

require('lsp-configs')

vim.cmd [[colorscheme sweet-fusion]]

-- Remap key adding zz to center the screen
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
