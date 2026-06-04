local exe = vim.fs.joinpath(
    vim.fn.expand("~/.local/roslyn-lsp"),
    "content",
    "LanguageServer",
    "win-x64",
    "Microsoft.CodeAnalysis.LanguageServer.exe"
)

-- Persist solution target per working directory so we don't get prompted every time
local cache_path = vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn_targets.json")

local function read_cache()
    local f = io.open(cache_path, "r")
    if not f then return {} end
    local ok, data = pcall(vim.json.decode, f:read("*a"))
    f:close()
    return ok and data or {}
end

local function write_cache(cache)
    local f = io.open(cache_path, "w")
    if not f then return end
    f:write(vim.json.encode(cache))
    f:close()
end

local function choose_target(targets)
    local cwd = vim.fn.getcwd()
    local cache = read_cache()
    local cached = cache[cwd]

    -- If the cached target is still valid, use it
    if cached and vim.list_contains(targets, cached) then
        return cached
    end

    -- Otherwise prompt and save the choice
    local co = coroutine.running()
    vim.ui.select(targets, {
        prompt = "Select target solution: ",
        format_item = function(item)
            return vim.fn.fnamemodify(item, ":.")
        end,
    }, function(choice)
        if choice then
            cache[cwd] = choice
            write_cache(cache)
        end
        if co then
            coroutine.resume(co, choice)
        end
    end)

    if co then
        return coroutine.yield()
    end
end

-- Override the default cmd so roslyn.nvim finds our manually installed server
vim.lsp.config("roslyn", {
    cmd = {
        exe,
        "--logLevel=Information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.log.get_filename()),
        "--stdio",
    },
    settings = {
        ["csharp|navigation"] = {
            dotnet_navigate_to_decompiled_sources = true,
        },
    },
    handlers = {
        -- Roslyn sends $/progress without a token, which crashes noice.nvim
        ["$/progress"] = function(err, result, ctx)
            if not result or not result.token then
                return
            end
            return vim.lsp.handlers["$/progress"](err, result, ctx)
        end,
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function()
        require('roslyn').setup({
            filewatching = "auto",
            broad_search = true,
            choose_target = choose_target,
        })
    end
})
