-- Diagnostic configuration
vim.diagnostic.config({
    float = { border = "rounded", source = true },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
        },
    },
})

-- LSP keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
    callback = function(ev)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
        end

        local clients = vim.lsp.get_clients({ bufnr = ev.buf })
        for _, client in pairs(clients) do
            vim.lsp.completion.enable(true, client.id, ev.buf, {
                autotrigger = true,
                convert = function(item)
                    return { abbr = item.label:gsub('%b()', '') }
                end,
            })
        end
        local fzf = require("fzf-lua")
        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("<leader>ld", fzf.lsp_definitions, "Go to definition")
        map("<leader>lD", fzf.lsp_declarations, "Go to declaration")
        map("<leader>lr", fzf.lsp_references, "References")
        map("<leader>li", fzf.lsp_implementations, "Implementations")
        map("<leader>lt", fzf.lsp_typedefs, "Type definition")
        map("<leader>ls", fzf.lsp_document_symbols, "Document symbols")
        map("<leader>ln", vim.lsp.buf.rename, "Rename")
        map("<leader>la", vim.lsp.buf.code_action, "Code action")
        map("<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
        map("<leader>lh", vim.lsp.buf.hover, "Hover")
        map("<leader>lk", vim.lsp.buf.signature_help, "Signature help")
        map("<leader>le", vim.diagnostic.open_float, "Line diagnostics")
        map("<leader>ll", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
            "Toggle inlay hints")
    end,
})

-- Server configurations using Neovim 0.11+ API
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.enable("lua_ls")

-- TypeScript / React
vim.lsp.config("ts_ls", {
    init_options = {
        preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
        },
    },
})
vim.lsp.enable("ts_ls")

-- Angular
vim.lsp.enable("angularls")

-- HTML
vim.lsp.enable("html")

-- CSS
vim.lsp.enable("cssls")

-- F#
vim.lsp.enable("fsautocomplete")

-- Markdown
vim.lsp.enable("marksman")
vim.lsp.enable("clangd")
