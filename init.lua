vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt
local fd = function(pat)
    local fdout = vim.system({
        "fd",
        "--type", "f",
        "--hidden",
        "--follow",
        "--full-path",
        "--exclude", ".git",
        pat,
    }):wait()

    if fdout.code ~= 0 then
        return {}
    end

    local matches = vim.split(fdout.stdout, "\n", { trimempty = true })
    return matches
end

_G.fd_findfunc = function(cmdarg, cmdcomplete)
    if not cmdcomplete then
        local stat = vim.uv.fs_stat(cmdarg)
        if stat and stat.type == 'file' then
            return { cmdarg }
        end
        local matches = fd(cmdarg)
        if #matches == 0 then
            return {}
        end
        return { matches[1] }
    end

    return fd(cmdarg)
end

opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.splitbelow = true
opt.splitright = true
opt.autoread = true
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.foldmethod = "expr"
opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
opt.foldlevelstart = 99
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.findfunc = "v:lua.fd_findfunc"
opt.grepprg = "rg --vimgrep --smart-case --hidden --no-heading"
opt.wildmode = "noselect:lastused,full"
opt.wildoptions = "pum,tagfile,fuzzy"
opt.completeopt = "fuzzy,menuone,noselect,popup,preview"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>rl", function()
    vim.wo.rightleft = not vim.wo.rightleft
end, { desc = "Toggle RTL" })
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape Terminal" })
vim.cmd.packadd('nvim.difftool')
vim.cmd.packadd('nvim.undotree')

local function gh(name)
    return "https://github.com/" .. name
end

vim.pack.add({
    gh("neovim/nvim-lspconfig"),
    gh("lewis6991/gitsigns.nvim"),
    gh('seblj/roslyn.nvim'),
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("angularls")
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("fsautocomplete")
vim.lsp.enable("marksman")
vim.lsp.enable("clangd")
vim.cmd.colorscheme('habamax')

vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
vim.g.netrw_altfile = 1
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = "netrw_gitignore#Hide()"
vim.g.netrw_keepdir = 0
vim.g.netrw_localcopydircmd = 'cp -r'
