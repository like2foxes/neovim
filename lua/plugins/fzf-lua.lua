local keys = {
    -- General
    { "<leader><space>", function() require("fzf-lua").files() end,                 {desc = "Find files"} },
    { "<leader>/",       function() require("fzf-lua").live_grep() end,             {desc = "Live grep"} },
    { "<leader>,",       function() require("fzf-lua").buffers() end,               {desc = "Buffers"} },

    -- Find
    { "<leader>fh",      function() require("fzf-lua").helptags() end,              {desc = "Help tags"} },
    { "<leader>fr",      function() require("fzf-lua").oldfiles() end,              {desc = "Recent files"} },
    { "<leader>fc",      function() require("fzf-lua").commands() end,              {desc = "Commands"} },
    { "<leader>fd",      function() require("fzf-lua").diagnostics_workspace() end, {desc = "Workspace diagnostics"} },
    { "<leader>fk",      function() require("fzf-lua").keymaps() end,               {desc = "Keymaps"} },
    { "<leader>ff",      function() require("fzf-lua").resume() end,                {desc = "Resume last picker"} },
    { "<leader>fs",      function() require("fzf-lua").lsp_document_symbols() end,  {desc = "Document symbols"} },
    { "<leader>fS",      function() require("fzf-lua").lsp_workspace_symbols() end, {desc = "Workspace symbols"} },
    { "<leader>fw",      function() require("fzf-lua").grep_cword() end,            {desc = "Grep word"} },
    { "<leader>fW",      function() require("fzf-lua").grep_cWORD() end,            {desc = "Grep WORD"} },

    -- Git
    { "<leader>gs",      function() require("fzf-lua").git_status() end,            {desc = "Status"} },
    { "<leader>gb",      function() require("fzf-lua").git_branches() end,          {desc = "Branches"} },
    { "<leader>gc",      function() require("fzf-lua").git_commits() end,           {desc = "Commits"} },
    { "<leader>gC",      function() require("fzf-lua").git_bcommits() end,          {desc = "Buffer commits"} },
    { "<leader>gt",      function() require("fzf-lua").git_stash() end,             {desc = "Stash"} },
}
for _, v in pairs(keys) do
    local  km, fun, opts  = unpack(v)
    vim.keymap.set("n", km, fun, opts)
end
