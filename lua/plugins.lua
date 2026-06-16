vim.cmd.packadd('nvim.difftool')
vim.cmd.packadd('nvim.undotree')

vim.pack.add({
        "https://github.com/neovim/nvim-lspconfig",
        "https://github.com/seblj/roslyn.nvim",
        "https://github.com/rebelot/kanagawa.nvim",
        "https://github.com/nvim-tree/nvim-web-devicons",
        "https://github.com/ibhagwan/fzf-lua",
        "https://github.com/stevearc/oil.nvim",
        "https://github.com/rafamadriz/friendly-snippets",
        "https://github.com/lewis6991/gitsigns.nvim",
        "https://github.com/nvim-lualine/lualine.nvim",
        { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
    },
    { load = false }
)

require('blink.cmp').setup({
    fuzzy = { implementation = "lua" },
    sources = {
        providers = {
            cmdline = { enabled = true},
            snippets = { opts = { friendly_snippets = true } }
        }
    }
})

require('lualine').setup()

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

vim.cmd.colorscheme('kanagawa')
