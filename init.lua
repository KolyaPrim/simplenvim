-- Enable faster Lua module loader (Neovim 0.9+)
if vim.loader then
  vim.loader.enable()
end
-- Disable Vim compatibility for modern Neovim features
vim.opt.compatible = false

-- Disable netrw early, so it won't steal directory buffers on startup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader key for custom keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Add 'lua' directory to runtimepath for direct module requiring
vim.loader = vim.loader or {}
vim.loader.rtp_search_path = vim.loader.rtp_search_path or {}
table.insert(vim.loader.rtp_search_path, 1, vim.fn.stdpath("config") .. "/lua")

-- Load plugin manager (Lazy.nvim)
require("plugins")

-- Load core Neovim configurations
require("core.options")
require("core.keymaps")
require("core.autocommands")

-- LSP keymaps via LspAttach (buffer-local, universal)
require("core.lsp_keymaps")
