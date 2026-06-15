vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
vim.opt.clipboard = "unnamedplus"
vim.opt.findfunc = "v:lua.fd_findfunc"
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden --no-heading"
vim.opt.wildmode = "noselect:lastused,full"
vim.opt.wildoptions = "pum,tagfile,fuzzy"
vim.opt.completeopt = "fuzzy,menuone,noselect,popup,preview"

vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape Terminal" })
vim.cmd.packadd('nvim.difftool')
vim.cmd.packadd('nvim.undotree')

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/seblj/roslyn.nvim",
})

local lsps = { "lua_ls", "ts_ls", "angularls", "html", "cssls", "fsautocomplete", "marksman", "clangd", "gopls" }
for _, v in pairs(lsps) do
    vim.lsp.enable(v)
end

require('roslyn').setup({
    choose_target = function(target)
        return vim.iter(target):find(function(item)
            if string.match(item, "Silverbyte.Optima.Cloud.sln") then
                return item
            end
        end)
    end,
    lock_target = true
})
vim.cmd.colorscheme('habamax')

vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
vim.g.netrw_altfile = 1
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = "netrw_gitignore#Hide()"
vim.g.netrw_localcopydircmd = 'cp -r'
