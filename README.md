# Neovim Configuration

Minimal [Neovim] setup powered by [vim.pack], the built-in LSP client,
[fzf-lua], [mini.nvim], [blink.cmp], and a local transparent Solarized-style
colorscheme named `solstice`.

A fork of [`freddiehaddad/nvim`](https://github.com/freddiehaddad/nvim)

## Requirements

- [Neovim] 0.12 or newer
- A [Nerd Font] for icons

### External tools

| Tool | Purpose | Example install |
| --- | --- | --- |
| `git` | Plugin downloads and version control | `brew install git` |
| `fzf` | Fuzzy finding through `fzf-lua` | `brew install fzf` |
| `ripgrep` | Live grep and project search | `brew install ripgrep` |
| `tree-sitter` | Parser tooling | `brew install tree-sitter` |
| `ty` | Python LSP | `uv tool install ty` |
| `gopls` | Go LSP | `go install golang.org/x/tools/gopls@latest` |
| `clangd` | C/C++ LSP | `brew install llvm` |
| `jsonls` | JSON LSP | `npm install -g vscode-langservers-extracted` |
| `lua_ls` | Lua LSP | `brew install lua-language-server` |
| `marksman` | Markdown LSP | `brew install marksman` |
| `rust_analyzer` | Rust LSP | `rustup component add rust-analyzer` |

## Quick start

Clone into your Neovim config directory and launch:

```sh
git clone <repo-url> ~/.config/nvim
nvim
```

Plugins are declared in `init.lua` with `vim.pack.add`. The first launch
installs them through [vim.pack]. Use `<leader>pu` to update plugins.

## Plugins

| Plugin | Purpose |
| --- | --- |
| [mini.nvim] | Icons, pairs, surround, sessions, statusline, and buffer removal |
| [nvim-lspconfig] | LSP |
| [oil.nvim] | File system |
| [fzf-lua] | Picker |
| [fidget.nvim] | Notifications |
| [treesitter-modules.nvim] | Incremental selection |
| [blink.cmp] | Completion |

## Key mappings

Leader is `<Space>`

### General

| Key | Action |
| --- | --- |
| `<leader>h.` | Help under cursor |
| `<C-x>s` | Save file (blame Emacs) |
| `<leader>pu` | Update plugins |
| `<Esc>` | Clear search highlights |
| `<C-f>` | Half page down |
| `<C-b>` | Half page up |

### Buffers and windows

| Key | Action |
| --- | --- |
| `<C-x>j` | Previous buffer |
| `<C-x>l` | Next buffer |
| `<C-x>k` | Delete buffer |
| `<C-x>0` | Close window |
| `<C-x>1` | Close other windows |
| `<C-x>2` | Split window horizontally |
| `<C-x>3` | Split window vertically |
| `<C-x>o` | Move to other window |
| `<C-x>r` | Rotate windows |
| `<C-x>=` | Balance windows |

### LSP

These mappings are buffer-local and active after an LSP client attaches.

| Key | Action |
| --- | --- |
| `gl` | Show line diagnostic |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>gi` | Implementations |
| `<leader>gr` | References |
| `<leader>th` | Toggle inlay hints |
| `<leader>lf` | Format document or selection |

### Fuzzy finder

| Key | Action |
| --- | --- |
| `<leader><space>` | Buffers |
| `<leader>fc` | Config files |
| `<leader>fg` | Ghostty config |
| `<leader>fd` | Document diagnostics |
| `<leader>ff` | Find files |
| `<leader>fr` | Resume last picker |
| `<leader>a` | Live grep |
| `<leader>hh` | Help pages |
| `<leader>gs` | Git status |
| `<leader>gb` | Git branches |
| `<leader>nh` | Notification history |

### Completion

| Key | Action |
| --- | --- |
| `<C-k>` | Show, hide, or fall back for signature help |
| `<Tab>` | Select next item or jump forward in snippets |
| `<S-Tab>` | Select previous item or jump backward in snippets |
| `<CR>` | Accept completion or fall back |

### File system

| Key | Action |
| --- | --- |
| `-` | Open parent directory with Oil |

## Autocmds

- **Close with `q`** - help, man, quickfix, `nvim-pack`, and `nvim-undotree`
  buffers close with `q`.
- **Spell check** - enabled with `en_us` for `markdown`, `gitcommit`, and
  `text` filetypes.
- **Restore cursor** - reopens files at the last edited position, excluding
  `gitcommit`, `gitrebase`, and `help` buffers.

## Treesitter parsers

Installed grammars:

- Bash
- JSON
- Go
- Rust
- C
- C++
- Python

Shell files are registered to the Bash parser.

### Incremental selection

| Key | Action |
| --- | --- |
| `<CR>` | Start selection or expand to the next node |
| `<S-CR>` | Shrink to the previous node |

## Options

- Mouse support is disabled.
- Command height is set to `0`.
- Line numbers, relative numbers, and wrapping are disabled.
- The cursor is kept centered with a large `scrolloff`.
- The sign column is hidden.
- Search uses `ignorecase` and `smartcase`.
- Persistent undo is enabled.
- Clipboard is set to `unnamedplus`.
- Swap files are disabled.
- Indentation uses four spaces with `expandtab`.

## Project layout

```text
init.lua                 Leader keys, plugin bootstrap, module loading
nvim-pack-lock.json      vim.pack lock file
colors/solstice.lua      Colorscheme entry point
lua/options.lua          Editor options
lua/keybinds.lua         Global key mappings
lua/autocmds.lua         Autocommands
lua/plugins.lua          Plugin configuration
lua/solstice/init.lua    Solstice highlight groups
lua/solstice/palette.lua Solstice palette
```

## Colorscheme

The default colorscheme is `solstice`, loaded from `colors/solstice.lua`.
Its palette and highlight groups live under `lua/solstice/`.

## Attribution

Forked from the excellent minimal config by [`freddiehaddad/nvim`](https://github.com/freddiehaddad/nvim)

