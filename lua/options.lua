vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

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
vim.opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
vim.opt.foldlevelstart = 99
