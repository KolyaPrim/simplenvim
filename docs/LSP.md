# Language Server Protocol (LSP)

This configuration provides a robust LSP setup for intelligent code completion, diagnostics, formatting, and more.

## Overview

*   **Server Installation**: Language servers are automatically installed and managed via `mason.nvim` and `mason-lspconfig.nvim`.
*   **Keymaps**: LSP-specific keymaps are **buffer-local** and applied universally to any attached LSP client through the `LspAttach` autocommand in `lua/core/lsp_keymaps.lua`. This ensures keymaps are only active when relevant.
*   **Diagnostics**: Diagnostics are configured for a quiet default (virtual text is off by default). You can toggle virtual text with `<leader>uv`.
*   **Inlay Hints**: If supported by the language server, inlay hints are enabled on attach and can be toggled with `<leader>ui`.
*   **Formatting**: Code formatting is primarily handled by `conform.nvim` on save, with a fallback to LSP formatting if no `conform` formatter is available. Manual formatting is available via `<leader>lf`.
*   **Lua Specifics**: For Neovim configuration development, `neodev.nvim` is enabled to provide better completion and analysis for Lua. `lua_ls` root detection is configured to prioritize standard Lua project markers and fallback to your Neovim config directory. `single_file_support` is enabled for `lua_ls`.

## Keymaps (Buffer-Local)

These keymaps are active only when an LSP client is attached to the current buffer.

| Keymap        | Description                               |
| :------------ | :---------------------------------------- |
| `gD`          | Go to Declaration                         |
| `gd`          | Go to Definition                          |
| `K`           | Show Hover documentation                  |
| `gi`          | Go to Implementation                      |
| `gs`          | Show Signature Help                       |
| `<leader>lr`  | Rename symbol                             |
| `<leader>la`  | Show Code Actions                         |
| `<leader>lf`  | Format buffer (via Conform, with LSP fallback) |
| `[d`          | Navigate to previous diagnostic           |
| `]d`          | Navigate to next diagnostic               |
| `gl`          | Show line diagnostics in a float window   |
| `<leader>uv`  | Toggle diagnostics virtual text           |
| `<leader>ui`  | Toggle inlay hints                        |

## Diagnostics

*   **Virtual Text**: Disabled by default for a cleaner view. Toggle with `<leader>uv`.
*   **Float Window**: Diagnostics are displayed in a rounded border float window with no header, always showing the source.
*   **Navigation**: Use `[d` and `]d` to jump between diagnostics. A float window automatically opens to show the diagnostic message.

## Adding a New Language Server

You can add new language servers in two primary ways:

1.  **Using `:Mason` (Recommended for interactive use)**:
    *   Open Neovim and type `:Mason`.
    *   Navigate through the list of available servers and press `i` to install the desired one (e.g., `pyright`, `tsserver`, `gopls`).

2.  **Via Configuration File (for automatic installation)**:
    *   Edit `lua/plugins/lsp/config.lua`.
    *   Extend the `servers_list` table with the name of the new server.
        ```lua
        -- lua/plugins/lsp/config.lua (excerpt)
        local servers_list = {
          "lua_ls", "bashls", "jsonls", "yamlls", "lemminx", "dockerls", "marksman",
          "pyright", -- Add your new server here
          "tsserver", -- And here
        }
        ```
    *   Restart Neovim or run `:Lazy sync`. `mason-lspconfig` will automatically install the server.

3.  **Server-Specific Settings**:
    *   If a server requires custom settings (e.g., `jsonls` schema configuration, `lua_ls` runtime settings), you can add them within the `setup_server(server_name)` function in `lua/plugins/lsp/config.lua`. Look for the `if server_name == "..." then ... end` blocks.

## Debugging LSP Issues

If you encounter issues with LSP:

*   `:LspInfo`: Shows which LSP clients are attached to the current buffer and their root directories.
*   `:checkhealth`: Provides general health information about your Neovim setup, including LSP.
*   **View LSP Logs**: LSP logs are typically located at `~/.local/state/nvim/lsp.log`. You can tail this file for real-time debugging:
    ```bash
    tail -f ~/.local/state/nvim/lsp.log
