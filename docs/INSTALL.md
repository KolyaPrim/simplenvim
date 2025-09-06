# Installation

This document guides you through installing and managing the Neovim configuration.

## Requirements

Ensure you have the following installed on your system:

*   **Neovim 0.11+**: This configuration leverages modern Neovim features, requiring version 0.11 or newer.
*   **Git**: Essential for cloning the repository and managing plugins.
*   **Recommended Tools**:
    *   `ripgrep` (`rg`): For fast and efficient searching with Telescope.
    *   `make`: Required to build `telescope-fzf-native.nvim` for enhanced search performance.
    *   `glow`: For beautiful Markdown previews.
*   **Optional**: Node.js, Python, Go, etc., are needed if you plan to use language servers and formatters for these languages.

## Quick Installation (Linux/macOS)

The simplest way to install is by using the provided `Makefile`:

```bash
make install
```

Alternatively, you can run the installation script directly:

```bash
bash scripts/install.sh
```

This will:
1.  Check for necessary prerequisites.
2.  Backup your existing Neovim configuration (if any) to a timestamped directory.
3.  Copy this configuration into your `~/.config/nvim` directory.
4.  Perform a headless plugin sync (`Lazy! sync`), which will bootstrap `lazy.nvim` and start installing plugins.
5.  On the first launch of Neovim, `mason-tool-installer` will automatically install essential language servers and formatters.

## Developer Installation (Symlink)

If you intend to actively develop or modify this configuration, it's recommended to use a symlink. This allows changes in your cloned repository to immediately reflect in Neovim.

```bash
make install-symlink
```

Or directly:

```bash
bash scripts/install.sh --symlink
```

This creates a symbolic link from your cloned repository to `~/.config/nvim`.

## Manual Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/KolyaPrim/simplenvim.git ~/.config/nvim
    ```
    (Replace `~/.config/nvim` with your desired Neovim config path if different, e.g., `$XDG_CONFIG_HOME/nvim`).

2.  **Launch Neovim**:
    ```bash
    nvim
    ```
    `lazy.nvim` will automatically download and install all required plugins. `mason-tool-installer` will then proceed to install configured language servers and formatters in the background.

## First Run Checks

After the initial installation and plugin setup, you can verify the status of your environment:

*   `:LspInfo`: Displays active Language Server Protocol (LSP) clients attached to the current buffer.
*   `:checkhealth`: Provides a comprehensive diagnostic report of your Neovim setup.
*   `:Mason`: Opens an interactive UI to manage and install LSP servers, formatters, and linters.

## Updating

To update your configuration and all installed plugins:

```bash
make update
```

Alternatively, from within Neovim:

```vim
:Lazy sync
```

## Uninstalling

To remove the configuration and clean up associated cache files:

```bash
make uninstall
```

This will:
1.  Run a cache cleanup script.
2.  If the configuration was installed via `make install` (copied), it will be backed up and removed.
3.  If it was installed via `make install-symlink`, the symlink will be removed.
