-- Oil
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- Snacks.nvim picker
vim.keymap.set("n", "<leader><space>", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent" })

-- Emacs save
vim.keymap.set("n", "<C-x>s", "<cmd>write<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "<C-x>s", "<cmd>write<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("n", "<C-x><C-s>", "<cmd>write<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "<C-x><C-s>", "<cmd>write<CR>", { silent = true, desc = "Save file" })

-- Emacs buffer navigation
vim.keymap.set("n", "<C-x>j", "<cmd>bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<C-x>l", "<cmd>bnext<CR>", { silent = true, desc = "Next buffer" })

-- Kill current buffer
vim.keymap.set("n", "<C-x>k", function() Snacks.bufdelete() end, { desc = "Kill current buffer" })

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
