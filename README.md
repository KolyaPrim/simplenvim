
# Neovim Config — Minimal, Robust, Extensible

**Who this is for:** This Neovim configuration is designed for developers seeking a **quick start** with a modern, functional, and easily extensible environment. It's ideal for those looking for a **clean, well-structured base** that can cover 99% of daily tasks while avoiding unnecessary complexity.

---

## 🚀 Quick Start

**Requirements:**
*   **Neovim 0.11+** 
*   **git**
*   **Recommended:** `ripgrep` (for fast searching), `make` (for `telescope-fzf-native` compilation), `glow` (for Markdown preview).
*   **Optional:** Node.js, Python, Go, etc., for various language servers and tools.

**Installation (Linux/macOS):**

The easiest way is to use `make`:

```bash
make install
```

Or, if you prefer to run the script directly:

```bash
bash scripts/install.sh
```

**Developer Install (Symlink):**

If you plan to actively modify the configuration, use the symlink option:

```bash
make install-symlink
```

This links your repository directly to your Neovim config directory, allowing for immediate reflection of changes.

**First Run:**

After installation, simply launch Neovim:

```bash
nvim
```

`lazy.nvim` will automatically bootstrap and install all plugins. `mason-tool-installer` will begin installing essential language servers and formatters.

**Adding LSPs for Your Frameworks:**

After the first run, you can easily add support for other languages and frameworks:

1.  Open Neovim.
2.  Run the command `:Mason` to interactively manage tools.
3.  Find the desired language server (e.g., `pyright` for Python, `tsserver` for TypeScript) and install it.
4.  Alternatively, for automatic installation, add the server name to the `servers_list` in `lua/plugins/lsp/config.lua`:

    ```lua
    local servers_list = {
      "lua_ls", "bashls", "jsonls", "yamlls", "lemminx", "dockerls", "marksman",
      "pyright", -- Add here
      "tsserver", -- And here
      -- etc.
    }
    ```
    Then restart Neovim or run `:Lazy sync`.

**Update:**

```bash
make update
```

**Uninstall:**

```bash
make uninstall
```

---

## About the Project

This Neovim configuration aims to provide:

*   **A Minimal and Robust Base:** Focused on the essentials for productive work.
*   **An Explicit and Consistent Structure:** Each plugin resides in its own folder (`lua/plugins/<name>/`), containing `init.lua` (Lazy.nvim spec), optionally `config.lua` (plugin configuration), and optionally `keys.lua` (keymaps).
*   **Easy Extensibility and Maintainability:** Thanks to its modular structure, adding or removing functionality is intuitive.

**Key Components:**

*   **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim) (safe bootstrap).
*   **LSP:** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason.nvim](https://github.com/williamboman/mason.nvim) (+ [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim)) + [neodev.nvim](https://github.com/folke/neodev.nvim) for Lua.
*   **Completion:** [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) (with [luasnip](https://github.com/L3MON4D3/LuaSnip) and [lspkind](https://github.com/onsails/lspkind.nvim)).
*   **Formatting:** [conform.nvim](https://github.com/stevearc/conform.nvim) (format on save with LSP fallback).
*   **Treesitter:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlighting and indentation.
*   **User Interface:** [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim), [bufferline.nvim](https://github.com/akinsho/bufferline.nvim), [which-key.nvim](https://github.com/folke/which-key.nvim), [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
*   **Tools:** [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (+fzf), [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua), [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim), [trouble.nvim](https://github.com/folke/trouble.nvim), [Comment.nvim](https://github.com/numToStr/Comment.nvim), [glow.nvim](https://github.com/ellisonleao/glow.nvim).

---

## 📚 Documentation

For more detailed information on various aspects of the configuration, please refer to the files in the `docs/` directory:

*   [**Installation and Update**](docs/INSTALL.md)
*   [**Repository Structure**](docs/STRUCTURE.md)
*   [**Extend and Customize**](docs/EXTEND.md) (how to add/remove plugins, LSPs, formatters, keymaps)
*   [**LSP Configuration**](docs/LSP.md) (LSP behavior, keymaps, diagnostics)
*   [**Git Usage**](docs/GIT.md) (Fugitive and Gitsigns)
*   [**Keymaps Overview**](docs/KEYMAPS.md)
*   [**Troubleshooting**](docs/TROUBLESHOOTING.md) (common issues and their solutions)

---

## License

[MIT License](LICENSE)
