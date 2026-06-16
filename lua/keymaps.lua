vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Escape Terminal" })

local function nset(new, old, desc)
    vim.keymap.set("n", new, old, { desc = desc })
end

nset("<leader><leader>", ":FzfLua files<CR>", "Find Files")
nset("<leader>'", ":FzfLua buffers<CR>", "Find Buffers")
nset("<leader>s", ":FzfLua live_grep_native<CR>", "Grep")

local oil = require("oil")
oil.setup()
local function toggle_pwd()
    local dir = vim.fn.getcwd()
    oil.toggle_float(dir)
end
nset("<leader>e", toggle_pwd, "Toggle Oil")
nset("<leader>E", oil.toggle_float, "Toggle Oil")
