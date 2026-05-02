-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('options')
require('autocmds')
require('keybinds')

vim.pack.add {
    'https://github.com/vague-theme/vague.nvim',
    'https://github.com/freddiehaddad/ferric.nvim',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/ibhagwan/fzf-lua',
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
}

require('oil').setup({
    skip_confirm_for_simple_edits = false,
})

require('mini.surround').setup()

local statusline = require("mini.statusline")
local section_location = function(args)
    if statusline.is_truncated(args.trunc_width) then
        return "%l %2v"
    end
    return '%l/%L %2v/%-2{virtcol("$") - 1}'
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
