vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.undotree")

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/seblj/roslyn.nvim",
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/igorlfs/nvim-dap-view",
    "https://github.com/tpope/vim-dadbod",
    "https://github.com/kristijanhusak/vim-dadbod-ui",
    "https://github.com/kristijanhusak/vim-dadbod-completion",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
}, { load = false })

require("nvim-autopairs").setup()
require("render-markdown").setup({})

local lsps = {
    "lua_ls", "ts_ls", "angularls", "html", "cssls", "fsautocomplete", "marksman", "clangd", "gopls", "ruby_lsp",
    "herb_ls", "rust_analyzer", "jsonls" }
for _, v in pairs(lsps) do
    vim.lsp.enable(v)
end

require("roslyn").setup({
    choose_target = function(target)
        return vim.iter(target):find(function(item)
            if string.match(item, "Silverbyte.Optima.Cloud.sln") then
                return item
            end
        end)
    end,
    lock_target = true,
})

require("terminal")
vim.schedule(function()
    require("lualine").setup({})
    require("blink.cmp").setup({
        fuzzy = { implementation = "lua" },
        sources = {
            per_filetype = {
                sql = { "snippets", "dadbod", "buffer" },
            },
            providers = {
                cmdline = { enabled = true },
                snippets = { opts = { friendly_snippets = true } },
                dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
            },
        },
    })
    require("conform").setup({
        formatters_by_ft = {
            lua = { "stylua" },
            rust = { "rustfmt" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
            cs = { "csharpier" },
        },
    })
    require("dbg")
end)
