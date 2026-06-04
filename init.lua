-- Set leader keys before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core config
require("config.options")

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Toggle RTL for Hebrew
vim.keymap.set("n", "<leader>rl", function()
    vim.wo.rightleft = not vim.wo.rightleft
end, { desc = "Toggle RTL" })

vim.cmd.packadd('nvim.difftool')
vim.cmd.packadd('nvim.undotree')
local function gh(name)
    return "https://github.com/" .. name
end

vim.pack.add({
    gh("neovim/nvim-lspconfig"),
    gh("echasnovski/mini.icons"),
    gh("nvim-lualine/lualine.nvim"),
    gh("ibhagwan/fzf-lua"),
    gh("lewis6991/gitsigns.nvim"),
    gh('folke/lazydev.nvim'),
    gh('seblj/roslyn.nvim'),
    gh('nvim-treesitter/nvim-treesitter'),
    gh('folke/which-key.nvim')
})
require('mini.icons').setup({})
require('lazydev').setup({
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        }
    }
})
require('lualine').setup({
    options = {
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    }
})
require('which-key').setup({
    preset = "helix",
    spec = {
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>t", group = "Terminal" },
        { "<leader>u", group = "UI" },
    },
})
require('plugins.lsp')
require('plugins.fzf-lua')
require('plugins.gitsigns')
require('plugins.roslyn')

vim.cmd.colorscheme('habamax')

vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
vim.g.netrw_altfile = 1
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = "netrw_gitignore#Hide()"
vim.g.netrw_keepdir = 0
vim.g.netrw_localcopydircmd = 'cp -r'
vim.keymap.set("n", "<leader>e", ":Lexplore %:p:h<CR>", { silent = true })
vim.keymap.set("n", "<leader>E", ":Lexplore<CR>", { silent = true })
