-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.shortmess:append("I")

vim.pack.add {
    'https://github.com/freddiehaddad/ferric.nvim',
    'https://github.com/vague-theme/vague.nvim',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/j-hui/fidget.nvim',
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/MeanderingProgrammer/treesitter-modules.nvim",
    { src = "https://github.com/saghen/blink.cmp",                version = vim.version.range("1.x") },
    "https://github.com/mfussenegger/nvim-dap",
    { src = "https://github.com/igorlfs/nvim-dap-view", version = vim.version.range("1.x") },
    "https://github.com/folke/which-key.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
}

require('plugins')
require('options')
require('autocmds')
require('keybinds')

vim.cmd.colorscheme("solstice")
