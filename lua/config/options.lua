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
vim.opt.path:append('**')

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Scroll
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Files
opt.autoread = true
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Folding (treesitter-based)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 99

-- System
opt.clipboard = "unnamedplus"
opt.updatetime = 250
opt.timeoutlen = 300
opt.mouse = "a"

opt.findfunc = "v:lua.fd_findfunc"
opt.wildmode = "noselect:lastused,full"
opt.wildoptions = "pum,tagfile,fuzzy"

opt.completeopt = "fuzzy,menuone,noselect,popup,preview"
