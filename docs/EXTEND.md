# Extend and Customize

This document explains how to extend and customize this Neovim configuration to fit your specific needs. The modular structure makes it easy to add, modify, or remove components.

## Adding a New Plugin

Follow this consistent pattern for integrating new plugins:

1.  **Create a new folder** for your plugin inside `lua/plugins/`.
    Example: `lua/plugins/my-awesome-plugin/`

2.  **Create `init.lua`** inside your plugin's folder. This file defines the `lazy.nvim` specification for the plugin.

    ```lua
    -- lua/plugins/my-awesome-plugin/init.lua
    return {
      "owner/repo-name", -- Replace with the actual GitHub owner/repo
      -- Optional: Add dependencies if your plugin relies on others
      -- dependencies = { "another/plugin" },
      -- Call the config.lua file for setup
      config = function() require("plugins.my-awesome-plugin.config").setup() end,
      -- Optional: Load plugin-specific keymaps
      keys = require("plugins.my-awesome-plugin.keys"),
      -- Any other lazy.nvim fields (e.g., event, cmd, ft, opts, etc.)
      -- event = "VeryLazy", -- Example: Load on startup but very late
      -- cmd = { "MyAwesomeCommand" }, -- Example: Load only when command is used
    }
    ```

3.  **(Optional) Create `config.lua`** inside your plugin's folder. This file contains the actual setup function for your plugin.

    ```lua
    -- lua/plugins/my-awesome-plugin/config.lua
    local M = {}

    function M.setup()
      -- Your plugin's setup options go here.
      -- Example:
      -- require("my-awesome-plugin").setup({
      --   option1 = true,
      --   option2 = "value",
      -- })
    end

    return M
    ```

4.  **(Optional) Create `keys.lua`** if your plugin introduces its own keymaps.

    ```lua
    -- lua/plugins/my-awesome-plugin/keys.lua
    return {
      -- Define your plugin's keymaps here.
      -- Example:
      -- { "<leader>ma", "<cmd>MyAwesomePluginAction<CR>", desc = "My Awesome Plugin: Do something" },
    }
    ```

5.  **Add your plugin to `lua/plugins/init.lua`**. Open `lua/plugins/init.lua` and add a `require` call for your new plugin's `init.lua` file.

    ```lua
    -- lua/plugins/init.lua (excerpt)
    -- ...
    add(require("plugins.my-awesome-plugin")) -- Add this line
    -- ...
    ```

6.  **Restart Neovim** or run `:Lazy sync` to install the new plugin.

## Removing a Plugin

To remove a plugin, simply:

1.  **Remove the plugin's folder** from `lua/plugins/` (e.g., `rm -rf lua/plugins/my-awesome-plugin/`).
2.  **Remove the corresponding `require` line** from `lua/plugins/init.lua`.
3.  **Run `:Lazy clean`** in Neovim to remove the unreferenced plugin files from your system.

## Customizing Keymaps

Keymaps are organized for clarity:

*   **Global Keymaps**: Defined in `lua/core/keymaps.lua`. These are general-purpose keybindings not tied to a specific plugin (e.g., save, quit, buffer navigation).
*   **LSP Buffer-Local Keymaps**: Defined in `lua/core/lsp_keymaps.lua`. These keymaps are automatically applied to a buffer only when an LSP client is attached, ensuring they are context-aware.
*   **Plugin-Specific Keymaps**: Located in `lua/plugins/<plugin_name>/keys.lua`. This keeps keybindings relevant to a plugin grouped with its configuration.
*   **Which-key Groups**: The categories for `which-key.nvim` are registered centrally in `lua/core/whichkey_groups.lua`.

## Managing LSP Servers

Language Server Protocol (LSP) servers are managed by `mason.nvim` and configured via `mason-lspconfig.nvim` and `nvim-lspconfig`.

*   **Add/Remove Servers**:
    *   The easiest way is to run `:Mason` in Neovim and use its interactive UI to install/uninstall servers.
    *   Alternatively, you can modify the `servers_list` in `lua/plugins/lsp/config.lua` to define which servers `mason-lspconfig` should `ensure_installed`.

    ```lua
    -- lua/plugins/lsp/config.lua (excerpt)
    local servers_list = {
      "lua_ls", "bashls", "jsonls", "yamlls", "lemminx", "dockerls", "marksman",
      "pyright", -- Add new servers here
      "tsserver",
    }
    ```
    After modifying, run `:Lazy sync` or restart Neovim.

*   **Server-Specific Settings**: If a server requires custom settings, add them within the `setup_server(server_name)` function in `lua/plugins/lsp/config.lua`.

## Configuring Formatters

Code formatting is handled by `conform.nvim`.

*   **Define Formatters**: Configure `formatters_by_ft` in `lua/plugins/conform/config.lua` to specify which formatters to use for different filetypes.
    ```lua
    -- lua/plugins/conform/config.lua (excerpt)
    function M.setup()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          json = { "prettierd", "prettier" },
          -- Add more filetypes and their formatters here
        },
        format_on_save = function(_) return { lsp_fallback = true, timeout_ms = 1000 } end,
      })
    end
    ```
*   **On-Save Formatting**: Formatting is automatically triggered on save with a fallback to LSP formatting if `conform` doesn't find a suitable formatter.
*   **Manual Formatting**: Use `<leader>lf` to manually format the current buffer.

## Managing Treesitter Parsers

`nvim-treesitter` provides enhanced syntax highlighting and indentation.

*   **Add Languages**: Modify the `ensure_installed` list in `lua/plugins/treesitter/config.lua` to add new language parsers.
    ```lua
    -- lua/plugins/treesitter/config.lua (excerpt)
    function M.setup()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "regex",
          "python", -- Example: Add Python
          "go",     -- Example: Add Go
        },
        -- ...
      })
    end
    ```
*   **Update Parsers**: After modifying the list, run `:TSUpdate` in Neovim to download and install the new parsers.

## Changing Colorscheme

*   **Default Colorscheme**: The initial colorscheme is set in `lua/core/options.lua`.
    ```lua
    -- lua/core/options.lua (excerpt)
    vim.cmd("colorscheme github_dark")
    ```
    You can change this line to your preferred colorscheme.
*   **Interactive Picker**: Use `<leader>ut` to open an interactive colorscheme picker and try different themes on the fly. The available themes are defined in `lua/core/keymaps.lua`.
