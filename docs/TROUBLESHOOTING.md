# Troubleshooting

This section addresses common issues you might encounter and provides solutions.

## Netrw opens at startup instead of NvimTree

*   **Cause**: Neovim was started with a directory argument (e.g., `nvim .`), and `netrw` (Neovim's built-in file explorer) hijacked the directory buffer before `NvimTree` could take over.
*   **Fix**: This configuration disables `netrw` early (`vim.g.loaded_netrw = 1`, `vim.g.loaded_netrwPlugin = 1`) and automatically opens `NvimTree` when starting Neovim with a directory. Ensure your configuration is up-to-date and restart Neovim.

## `mason-lspconfig.setup_handlers` is nil

*   **Cause**: You might be using an older version of `mason-lspconfig` or there's a caching issue.
*   **Fix**: This configuration includes a fallback path to ensure LSP servers are still set up. To fully resolve, update your plugins by running `:Lazy update` inside Neovim.

## LSP keymaps are missing in some files

*   **Cause**: LSP keymaps are buffer-local and applied via the `LspAttach` autocommand. If there are conflicting configurations or old plugin files, the `on_attach` function might not run as expected.
*   **Fix**:
    1.  Ensure you don't have any legacy single-file modules under `lua/plugins/*.lua` that conflict with the folder-based plugin structure (e.g., `lua/plugins/lsp.lua` if `lsp` is now a folder).
    2.  Run `:Lazy clean` to remove any unmanaged or conflicting plugin files.
    3.  Restart Neovim.
*   **Verification**: After opening a file with an active LSP client, run `:LspInfo`. If a client is attached, the LSP keymaps should be available.

## Two `lua_ls` clients attached

*   **Cause**: The `lua_ls` language server might be configured or started twice, often due to duplicate plugin definitions or lingering old configuration files.
*   **Fix**:
    1.  Remove any legacy or duplicate `lua_ls` configurations.
    2.  Run `:Lazy clean`.
    3.  Restart Neovim.

## Telescope `fzf-native` fails to build

*   **Cause**: The `telescope-fzf-native.nvim` plugin requires a C compiler and `make` to build its native extension.
*   **Fix**: Install `make` and a C toolchain (e.g., `build-essential` on Debian/Ubuntu, Xcode Command Line Tools on macOS). Alternatively, you can skip this extension; Telescope will still function, but without the native `fzf` performance benefits.

## `glow` not found

*   **Cause**: The `glow.nvim` plugin requires the `glow` command-line tool to be installed on your system.
*   **Fix**: Install `glow` via your system's package manager or download it from its GitHub releases page.
    *   **macOS**: `brew install glow`
    *   **Linux (example for Debian/Ubuntu)**: `sudo apt install glow` (or download the binary directly).

## `ripgrep` not found

*   **Cause**: `ripgrep` (`rg`) is used by Telescope for fast `live_grep` functionality.
*   **Fix**: Install `ripgrep` via your system's package manager.
    *   **macOS**: `brew install ripgrep`
    *   **Debian/Ubuntu**: `sudo apt install ripgrep`
    *   **Arch Linux**: `sudo pacman -S ripgrep`

## Reset plugin lock

*   **Cause**: You might want to force `lazy.nvim` to re-resolve all plugin versions to their latest compatible state, or fix issues with `lazy-lock.json`.
*   **Fix**:
    1.  Delete the `lazy-lock.json` file in your Neovim configuration root.
    2.  Run `:Lazy sync` in Neovim. This will re-fetch and lock the latest versions of all plugins.
