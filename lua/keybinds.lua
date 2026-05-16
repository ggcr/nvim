-- Help under cursor
vim.keymap.set("n", "<leader>h.", "<cmd>help!<CR>", { desc = "Help under cursor" })

-- Save (emacs)
vim.keymap.set("n", "<C-x>s", "<cmd>write<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "<C-x>s", "<cmd>write<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("n", "<C-x><C-s>", "<cmd>write<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "<C-x><C-s>", "<cmd>write<CR>", { silent = true, desc = "Save file" })

-- Buffer navigation
vim.keymap.set("n", "<C-x>j", "<cmd>bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<C-x>l", "<cmd>bnext<CR>", { silent = true, desc = "Next buffer" })

-- Window navigation (emacs)
vim.keymap.set("n", "<C-x>0", "<cmd>close<CR>", { silent = true, desc = "Close window" })
vim.keymap.set("n", "<C-x>1", "<cmd>only<CR>", { silent = true, desc = "Close other windows" })
vim.keymap.set("n", "<C-x>2", "<cmd>split<CR>", { silent = true, desc = "Split window horizontally" })
vim.keymap.set("n", "<C-x>3", "<cmd>vsplit<CR>", { silent = true, desc = "Split window vertically" })
vim.keymap.set("n", "<C-x>o", "<C-w>w", { desc = "Other window" })
vim.keymap.set("n", "<C-x>r", "<C-w>r", { desc = "Rotate windows" })
vim.keymap.set("n", "<C-x>=", "<C-w>=", { desc = "Balance windows" })

-- Scrolling
vim.keymap.set("n", "<C-f>", "<C-d>", { desc = "Half page down" })
vim.keymap.set("n", "<C-b>", "<C-u>", { desc = "Half page up" })

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Update keymap
vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "Update plugins" })

-- Path of current buffer
vim.keymap.set("n", "<leader>pwd", function()
  local path = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg("+", path)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { path })
  local win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    anchor = "NE",
    row = 0,
    col = vim.o.columns,
    width = #path,
    height = 1,
    style = "minimal",
    border = "single",
    focusable = false,
  })
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, 2000)
end, { desc = "Copy path of current buffer" })


