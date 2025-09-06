# Keymaps Overview

This document provides a concise overview of the most frequently used keybindings in this Neovim configuration. The global leader key is `<Space>`.

## General

| Keymap        | Description                          |
| :------------ | :----------------------------------- |
| `<leader>w`   | Save current file                    |
| `<leader>q`   | Quit Neovim                          |
| `<leader>wq`  | Save and quit                        |
| `<leader>x`   | Save and quit (if modified)          |
| `<leader>nh`  | Clear search highlights              |
| `<leader>ut`  | Interactive colorscheme picker       |

## Find & Files (Telescope)

| Keymap        | Description                          |
| :------------ | :----------------------------------- |
| `<leader>ff`  | Find files in current project        |
| `<leader>fg`  | Live grep (search content in files)  |
| `<leader>fb`  | List open buffers                    |
| `<leader>fh`  | Search help tags                     |
| `<leader>fs`  | Search for word under cursor         |
| `<leader>fr`  | List recent files                    |
| `<leader>fd`  | List project diagnostics             |
| `<leader>fz`  | Resume last Telescope picker         |

## File Tree (NvimTree)

| Keymap        | Description                          |
| :------------ | :----------------------------------- |
| `<leader>e`   | Toggle file tree                     |
| `<leader>fe`  | Focus file tree                      |

## Git (Fugitive & Gitsigns)

See [Git Usage](GIT.md) for more details.

### Fugitive (Repository-Level)

| Keymap        | Description                          |
| :------------ | :----------------------------------- |
| `<leader>gs`  | Git status                           |
| `<leader>gc`  | Git commit                           |
| `<leader>gp`  | Git push                             |
| `<leader>gP`  | Git pull --rebase                    |
| `<leader>gb`  | Git blame (current buffer)           |
| `<leader>gD`  | Git diff (split view)                |

### Gitsigns (Line/Hunk-Level)

| Keymap        | Description                          |
| :------------ | :----------------------------------- |
| `[h`          | Previous Git hunk                    |
| `]h`          | Next Git hunk                        |
| `<leader>ghs` | Stage hunk                           |
| `<leader>ghr` | Reset hunk                           |
| `<leader>ghS` | Stage entire buffer                  |
| `<leader>ghu` | Undo stage hunk                      |
| `<leader>ghp` | Preview hunk                         |
| `<leader>gtd` | Toggle deleted lines                 |
| `<leader>gbl` | Blame current line                   |

## LSP (Language Server Protocol)

See [LSP Configuration](LSP.md) for more details. These keymaps are buffer-local and active only when an LSP client is attached.

| Keymap        | Description                          |
| :------------ | :----------------------------------- |
| `gD`          | Go to Declaration                    |
| `gd`          | Go to Definition                     |
| `K`           | Show Hover documentation             |
| `gi`          | Go to Implementation                 |
| `gs`          | Show Signature Help                  |
| `<leader>lr`  | Rename symbol                        |
| `<leader>la`  | Show Code Actions                    |
| `<leader>lf`  | Format buffer                        |
| `[d`          | Navigate to previous diagnostic      |
| `]d`          | Navigate to next diagnostic          |
| `gl`          | Show line diagnostics                |
| `<leader>uv`  | Toggle diagnostics virtual text      |
| `<leader>ui`  | Toggle inlay hints                   |

## Buffers (Bufferline)

| Keymap        | Description                          |
| :------------ | :----------------------------------- |
| `<leader>bb`  | Pick buffer from list                |
| `<leader>1`..`<leader>9` | Jump to buffer 1-9             |
| `<leader>bn`  | Next buffer                          |
| `<leader>bp`  | Previous buffer                      |
| `<leader>bd`  | Delete current buffer                |
| `<leader>bl`  | List all open buffers                |

## Windows

| Keymap        | Description                          |
| :------------ | :----------------------------------- |
| `<C-h/j/k/l>` | Move between windows (left/down/up/right) |
| `<C-Up/Down/Left/Right>` | Resize window vertically/horizontally |
| `<leader>sv`  | Split window vertically              |
| `<leader>sh`  | Split window horizontally            |
| `<leader>sc`  | Close current window                 |
| `<leader>so`  | Close all other windows              |

## Terminal (ToggleTerm)

| Keymap        | Description                          |
| :------------ | :----------------------------------- |
| `<C-/>`       | Toggle bottom terminal (use count to select session) |
| `Esc` (in terminal) | Enter Normal mode                    |

## Plugin Manager (Lazy.nvim)

| Keymap        | Description                          |
| :------------ | :----------------------------------- |
| `<leader>L`   | Open Lazy.nvim UI                    |
| `<leader>Ls`  | Sync plugins (install/remove)        |
| `<leader>Lu`  | Update plugins                       |
