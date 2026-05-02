-- lua/autocmds.lua


-- Close buffers
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "man", "qf", "nvim-pack", "nvim-undotree" },
    callback = function(e)
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = e.buf })
    end,
})

-- Enable spell check for prose filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "gitcommit", "text" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end,
})

-- Restore cursor position when reopening files
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(e)
        vim.schedule(function()
            local exclude = { "gitcommit", "gitrebase", "help" }
            if vim.tbl_contains(exclude, vim.bo[e.buf].filetype) then
                return
            end
            if not vim.api.nvim_buf_is_valid(e.buf) then
                return
            end
            local pos = vim.api.nvim_buf_get_mark(e.buf, '"')
            if pos[1] > 0 and pos[1] <= vim.api.nvim_buf_line_count(e.buf) then
                pcall(vim.api.nvim_win_set_cursor, 0, pos)
            end
        end)
    end,
})
