vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Escape Terminal" })

local function nset(new, old, desc)
	vim.keymap.set("n", new, old, { desc = desc, silent = true })
end

nset("<leader><leader>", ":FzfLua files<CR>", "Find Files")
nset("<leader>'", ":FzfLua buffers<CR>", "Find Buffers")
nset("<leader>/", ":FzfLua live_grep_native<CR>", "Grep")
nset("<leader>s", ":FzfLua lsp_document_symbols<CR>", "Grep")
nset("<leader>w", ":FzfLua lsp_live_workspace_symbols<CR>", "Grep")

local oil = require("oil")
oil.setup()
local function toggle_pwd()
	local dir = vim.fn.getcwd()
	oil.toggle_float(dir)
end
nset("<leader>e", toggle_pwd, "Toggle Oil")
nset("<leader>E", oil.toggle_float, "Toggle Oil")

nset("<leader>d", ":DBUIToggle<CR>", "Toggle DB UI")
nset("<F5>", ":DapContinue<CR>", "Debug Continue")
nset("<F9>", ":DapToggleBreakpoint<CR>", "Toggle Breakpoint")
nset("<F10>", ":DapStepOver<CR>", "Step Over")
nset("<F11>", ":DapStepInto<CR>", "Step Into")
nset("<F12>", ":DapStepOut<CR>", "Step Out")

vim.keymap.set({ "v", "n" }, "<leader>f", function()
	require("conform").format({ async = true })
end, { desc = "Format", silent = true })
