-- check if file exists
local is_windows = vim.loop.os_uname().sysname:match('Windows') ~= nil

local user = ''
local machine = ''

local config_dir = vim.fn.stdpath('config')
local data_dir = config_dir .. "/data"
local lsp_file_path = data_dir .. "/lsps"
local project_file_path = data_dir .. "/projects"

if is_windows then
	user = vim.api.nvim_eval("$USERNAME")
	machine = vim.api.nvim_eval("$COMPUTERNAME")

	data_dir = string.gsub(data_dir, "/", "\\")
	lsp_file_path = string.gsub(lsp_file_path, "/", "\\")
	project_file_path = string.gsub(project_file_path, "/", "\\")
else
	user = vim.api.nvim_eval("$USER")
	-- machine = tostring(vim.api.nvim_eval("system('hostname')"))
	local file = io.open("/proc/sys/kernel/hostname", "r")
	local name = file:read("*a")
	file:close()

	name = name:gsub("\n", "")
	machine = name
end

user = user:lower()
machine = machine:lower()

local user_id = user .. '@' .. machine

local function create_config_file_if_not_exists(file_path)
	r = os.execute("mkdir " .. data_dir)

	local f = io.open(file_path, "r")
	if f == nil then 
		local file = io.open(file_path, "w")
		file:close()
	end
end

local function create_table(file_path)
	data = {}

	create_config_file_if_not_exists(file_path)
	local f = io.open(file_path, "r")
	
	if f ~= nil then
		for line in f:lines() do
			table.insert(data, line)
		end
	
		f:close()
	end

	return data
end

local M = {}

M.user_id = user_id
M.is_windows = is_windows
M.is_linux = not is_windows

M.get_lsps = function()
	return create_table(lsp_file_path)
end

M.get_projects = function()
	return create_table(project_file_path)
end

return M
