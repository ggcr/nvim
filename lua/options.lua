-- lua/options.lua

-- General
vim.o.mouse = ""
vim.o.cmdheight = 0
if vim.fn.has("nvim-0.12") == 1 then
    pcall(function()
        require("vim._core.ui2").enable()
    end)
end
vim.o.cursorline = false
vim.o.number = false
vim.o.relativenumber = false
vim.o.wrap = false
vim.o.breakindent = true
vim.o.showmode = false

-- Centered cursor
vim.o.scrolloff = 999
vim.o.sidescrolloff = 0
vim.o.sidescroll = 5

vim.o.signcolumn = "no"
vim.o.inccommand = "split"
vim.o.confirm = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.opt.sessionoptions:remove("blank")

-- Clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.tabstop = 4
vim.opt.cindent = true
vim.opt.autoindent = false
vim.opt.smartindent = false

-- Completion menu
vim.o.pumheight = 20

