local dap = require("dap")
local netcoredbg = vim.fn.exepath("netcoredbg.exe")
if netcoredbg == "" then
	vim.notify("netcoredbg.exe not found in PATH", vim.log.levels.ERROR)
	return
end

local netcoredbg_adapter = {
	type = "executable",
	command = netcoredbg,
	args = { "--interpreter=vscode" },
}

dap.adapters.netcoredbg = netcoredbg_adapter
dap.adapters.coreclr = netcoredbg_adapter

local function filter_ps(opts)
	if opts.name:match("Silverbyte") ~= nil then
		return true
	end
	return false
end
dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to dll", vim.fn.getcwd() .. "\\bin\\Debug\\", "file")
		end,
	},
	{
		type = "coreclr",
		name = "attach - netcoredbg",
		request = "attach",
		processId = function()
			return tonumber(require("dap.utils").pick_process({ filter = filter_ps }))
		end,
	},
}
