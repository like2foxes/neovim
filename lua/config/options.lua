local opt = vim.opt
_G.fd_findfunc = function (pat, cmdtype)
     -- ignore non-file search contexts if you want
  pat = pat or ""

  if pat == "" then
    return {}
  end

  local results = vim.fn.systemlist({
    "fd",
    "--type", "f",
    "--hidden",
    "--follow",
    "--exclude", ".git",
    pat,
    ".",
  })

  if vim.v.shell_error ~= 0 then
    return {}
  end

  -- for i, v in ipairs(results) do
  --     results[i] = vim.fs.normalize(v)
  -- end
  return results
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
