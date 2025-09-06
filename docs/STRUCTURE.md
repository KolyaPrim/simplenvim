# Repository Structure

This document outlines the logical organization of the Neovim configuration, designed for clarity and maintainability.

```
simplenvim/
├── docs/                     # Documentation files
├── ftplugin/                 # Filetype-specific settings (e.g., lua.lua for Lua files)
├── init.lua                  # Neovim's entry point and bootstrap sequence
├── lazy-lock.json            # Managed by lazy.nvim, locks plugin versions
├── LICENSE                   # Project license
├── lua/                      # Core configuration and plugin definitions
│   ├── core/                 # Fundamental Neovim settings and global configurations
│   │   ├── autocommands.lua  # Auto-commands for various events (e.g., autosave)
│   │   ├── keymaps.lua       # Global, plugin-agnostic keybindings
│   │   ├── lsp_keymaps.lua   # Buffer-local LSP keybindings (applied via LspAttach)
│   │   ├── options.lua       # Core Neovim options (e.g., indentation, line numbers)
│   │   └── whichkey_groups.lua # Centralized definitions for which-key groups
│   └── plugins/              # Plugin definitions, organized one folder per plugin
│       ├── <plugin_name>/    # Directory for a specific plugin
│       │   ├── init.lua      # lazy.nvim specification for the plugin (returns a table)
│       │   ├── config.lua    # Plugin-specific configuration (calls setup function)
│       │   └── keys.lua      # Optional: Plugin-specific keymaps
│       └── init.lua          # Main plugin loader, collects all plugin specs
├── Makefile                  # Automation scripts for common tasks (install, update, uninstall)
├── README.md                 # Project overview and quick start guide
└── scripts/                  # Helper shell scripts (install, uninstall, cache cleanup)
```

## Key Architectural Principles

### 1. Boot Sequence (`init.lua`)

`init.lua` is the main entry point for Neovim. It handles:
*   Enabling faster Lua module loading (Neovim 0.9+).
*   Disabling Vim compatibility for modern Neovim features.
*   Setting the global leader key (`<Space>`).
*   Disabling `netrw` early to prevent conflicts with `nvim-tree`.
*   Adding the `lua` directory to `runtimepath` for direct module requiring.
*   Loading the plugin manager (`lazy.nvim`).
*   Loading core Neovim configurations from `lua/core/`.

### 2. Core Configuration (`lua/core/`)

This directory contains fundamental settings that apply globally to your Neovim environment:
*   **`options.lua`**: Defines basic editor behavior like line numbers, indentation, search settings, and clipboard integration.
*   **`keymaps.lua`**: Houses global keybindings that are not tied to a specific plugin.
*   **`autocommands.lua`**: Manages auto-commands for events like `FocusLost` (autosave) or `TextYankPost` (highlight yanked text).
*   **`lsp_keymaps.lua`**: Crucially, this file defines LSP-related keymaps that are applied *buffer-locally* via the `LspAttach` autocommand. This ensures LSP keymaps are only active when an LSP client is attached to the buffer, and they work universally for any LSP client.
*   **`whichkey_groups.lua`**: Centralizes the definition of keymap groups for `which-key.nvim`, providing a structured overview of available commands.

### 3. Plugin Management (`lua/plugins/`)

Plugins are managed by `lazy.nvim` and follow a consistent, modular pattern:

*   **One plugin = One folder**: Each plugin gets its own dedicated folder (e.g., `lua/plugins/telescope/`).
*   **`init.lua` (Lazy.nvim Spec)**: Inside each plugin's folder, `init.lua` defines the plugin's specification for `lazy.nvim`. This includes its GitHub repository, dependencies, and calls to its `config.lua` and `keys.lua`.
*   **`config.lua` (Plugin Configuration)**: This file contains the `setup()` function for the plugin, where all its specific options and settings are defined. This keeps configuration separate from the `lazy.nvim` loading logic.
*   **`keys.lua` (Plugin-Specific Keymaps)**: If a plugin has keymaps that are specific to its functionality, they are defined here. This keeps related keymaps bundled with their respective plugins.
*   **`lua/plugins/init.lua`**: This file acts as the central registry for all plugins. It uses `lazy.nvim` to load all individual plugin specifications from their respective `init.lua` files.

### 4. Filetype-Specific Settings (`ftplugin/`)

The `ftplugin/` directory contains files that apply settings or keymaps only when editing a specific filetype. For example, `ftplugin/lua.lua` sets indentation and a run command specifically for Lua files.

### 5. Scripts and Documentation

*   **`scripts/`**: Contains helper shell scripts for installation, uninstallation, and cache cleanup, automating common maintenance tasks.
*   **`docs/`**: Houses detailed documentation on various aspects of the configuration, providing comprehensive guides beyond this high-level overview.
