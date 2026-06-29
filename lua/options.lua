require("vim._core.ui2").enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

local osname = string.lower(vim.uv.os_uname().sysname)
if string.find(osname, string.lower("windows")) then
	vim.o.shell = "pwsh"
end

vim.cmd.colorscheme("tokyonight")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.autoread = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt.foldlevelstart = 99
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.o.signcolumn = "yes"
vim.opt.cmdheight = 0
