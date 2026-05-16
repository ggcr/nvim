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
        if not vim.api.nvim_buf_is_valid(e.buf) or vim.api.nvim_get_current_buf() ~= e.buf then
            return
        end

        local exclude = { "gitcommit", "gitrebase", "help" }
        if vim.tbl_contains(exclude, vim.bo[e.buf].filetype) then
            return
        end

        local pos = vim.api.nvim_buf_get_mark(e.buf, '"')
        if pos[1] > 0 and pos[1] <= vim.api.nvim_buf_line_count(e.buf) then
            -- Keep this synchronous so explicit jumps from pickers, quickfix, or +cmds win afterward.
            pcall(vim.api.nvim_win_set_cursor, 0, pos)
        end
    end,
})

-- Gopls: imports organized on save using the logic of goimports and your code formatted
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
