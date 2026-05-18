-----------------------------------------------------------------------------
-- File System
-----------------------------------------------------------------------------
require('oil').setup({
    skip_confirm_for_simple_edits = false,
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-----------------------------------------------------------------------------
-- Mini.nvim
-----------------------------------------------------------------------------
require('mini.surround').setup()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.sessions").setup()

require("mini.bufremove").setup()
vim.keymap.set("n", "<C-x>k", MiniBufremove.delete, { desc = "Delete buffer" })

-----------------------------------------------------------------------------
-- Status Line
-----------------------------------------------------------------------------
local statusline = require("mini.statusline")
local section_location = function(args)
    if statusline.is_truncated(args.trunc_width) then
        return "%l %2v"
    end
    return ' %l/%L  %2v/%-2{virtcol("$") - 1}'
end

require("mini.statusline").setup({
    content = {
        active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 40 })
            local diff = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location = section_location({ trunc_width = 75 })
            local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

            return MiniStatusline.combine_groups({
                { hl = mode_hl,                 strings = { mode } },
                { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
                "%<",
                { hl = "MiniStatuslineFilename", strings = { filename } },
                "%=",
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                { hl = mode_hl,                  strings = { search } },
                { hl = "MiniStatuslineFileinfo", strings = { location } },
            })
        end,
    },
})

-----------------------------------------------------------------------------
-- LSP
-----------------------------------------------------------------------------
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticWarn",
        },
    },
})

vim.lsp.config("ty", {
    root_markers = { 'uv.lock' },
})

vim.lsp.config("ruff", {
    root_markers = { 'uv.lock', 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
})

vim.lsp.enable("ty")
vim.lsp.enable("ts_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("gopls")
vim.lsp.enable("clangd")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("marksman")
vim.lsp.enable("rust_analyzer")

-- LSP Keybinds
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local bufnr = event.buf
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr, desc = "Line diagnostics" })
        vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { buffer = bufnr, desc = "Go to definition" })
        vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", { buffer = bufnr, desc = "Code actions" })
        vim.keymap.set("n", "<leader>gi", "<cmd>FzfLua lsp_implementations<cr>",
            { buffer = bufnr, desc = "Search implementations" })
        vim.keymap.set("n", "<leader>gr", "<cmd>FzfLua lsp_references<cr>",
            { buffer = bufnr, desc = "Search references" })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
            return
        end

        if client:supports_method("textDocument/hover", bufnr) then
            vim.keymap.set("n", "K", function()
                vim.lsp.buf.hover({ border = "single" })
            end, { buffer = bufnr, desc = "Hover documentation" })
        end

        if client:supports_method("textDocument/inlayHint", bufnr) then
            vim.keymap.set("n", "<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
            end, { buffer = event.buf, desc = "Toggle inlay hints" })
        end

        if client:supports_method("textDocument/foldingRange", bufnr) then
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
            vim.wo.foldmethod = "expr"
            vim.wo.foldlevel = 99
        end

        if client:supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<leader>lf", function()
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 2000 })
            end, { buffer = bufnr, desc = "Format document" })
        end

        if client:supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("v", "<leader>lf", function()
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 2000 })
            end, { buffer = bufnr, desc = "Format selection" })
        end
    end,
})


-----------------------------------------------------------------------------
-- Treesitter
-----------------------------------------------------------------------------
local treesitter_parsers = { "bash", "json", "go", "rust", "c", "cpp", "python", "markdown", "markdown_inline", "html" }

vim.treesitter.language.register("bash", { "sh" })

require("treesitter-modules").setup({
    ensure_installed = treesitter_parsers,
    auto_install = true,
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = false,
            node_decremental = "<S-CR>",
        },
    },
})

-----------------------------------------------------------------------------
-- Completion (blink.cmp)
-----------------------------------------------------------------------------
require("blink.cmp").setup({
    appearance = { nerd_font_variant = "normal" },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    completion = {
        list = {
            selection = {
                preselect = true,
                auto_insert = false,
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 750,
            window = { border = "single" },
        },
        ghost_text = { enabled = false },
        menu = {
            auto_show_delay_ms = 120,
            border = "single",
            draw = {
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local kind_icon, _, _ = require("mini.icons").get("lsp", ctx
                                .kind)
                            return kind_icon
                        end,
                        highlight = function(ctx)
                            local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                            return hl
                        end,
                    },
                    kind = {
                        highlight = function(ctx)
                            local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                            return hl
                        end,
                    },
                },
            },
        },
    },
    keymap = {
        preset = "default",
        ["<C-space>"] = {},
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
    },
    signature = { enabled = true },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
})

-----------------------------------------------------------------------------
-- Picker
-----------------------------------------------------------------------------
require("fzf-lua").setup({
    fzf_colors = false,
    fzf_opts = {
        ["--no-scrollbar"] = true,
    },
    winopts = {
        border = "single",
        preview = {
            horizontal = "right:50%",
            border = "single",
        },
    },
    keymap = {
        builtin = {
            ["<C-f>"] = "preview-half-page-down",
            ["<C-b>"] = "preview-half-page-up",
        },
    },
    grep = {
        rg_glob = true,
        glob_separator = "  ",
    },
})

vim.keymap.set("n", "<leader><space>", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fc", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Dotfiles" })
vim.keymap.set("n", "<leader>fg", function() require("fzf-lua").files({ cwd = '~/.config/ghostty/' }) end, { desc = "Ghostty" })
vim.keymap.set("n", "<leader>fd", "<cmd>FzfLua diagnostics_document<CR>", { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua resume<CR>", { desc = "Resume" })
vim.keymap.set("n", "<leader>a", "<cmd>FzfLua live_grep<CR>", { desc = "Grep" })
vim.keymap.set("n", "<leader>hh", "<cmd>FzfLua helptags<CR>", { desc = "Help pages" })
vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "Git branches" })

-----------------------------------------------------------------------------
-- Notify
-----------------------------------------------------------------------------
require("fidget").setup({
    notification = {
        override_vim_notify = true,
        window = {
            border = "none",
            max_width = 60,
            x_padding = 0,
            y_padding = 0,
        },
    },
})

-----------------------------------------------------------------------------
-- Render-markdown
-----------------------------------------------------------------------------
require("render-markdown").setup({
    file_types = { "markdown" },
    completions = { blink = { enabled = true } },
    heading = { enabled = false },
})

-----------------------------------------------------------------------------
-- Which-key
-----------------------------------------------------------------------------
require("which-key").setup({
    preset = "helix",
    win = { border = "single" },
})

