-- Bootstrap Lazy.nvim (Neovim 0.10+: use vim.uv)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Collect specs from plugin modules
local specs = {}
local function add(spec) table.insert(specs, spec) end
local function add_many(list) for _, s in ipairs(list) do table.insert(specs, s) end end

add_many(require("plugins.colors"))            -- colorschemes (list)
add(require("plugins.devicons"))               -- nvim-web-devicons
add(require("plugins.lspkind"))                -- lspkind

add(require("plugins.nvim-tree"))              -- file explorer
add(require("plugins.telescope"))              -- telescope + fzf-native
add(require("plugins.treesitter"))             -- treesitter
add(require("plugins.lsp"))                    -- lspconfig + mason + schemastore
add(require("plugins.mason-tool-installer"))   -- ensure tools
add(require("plugins.cmp"))                    -- nvim-cmp
add(require("plugins.conform"))                -- formatting
add(require("plugins.lualine"))                -- statusline
add(require("plugins.bufferline"))             -- buffer tabs
add(require("plugins.gitsigns"))               -- git signs
add(require("plugins.trouble"))                -- diagnostics list
add(require("plugins.comment"))                -- comments
add(require("plugins.glow"))                   -- markdown preview
add(require("plugins.fugitive"))               -- fugitive
add(require("plugins.toggleterm"))             -- terminal
add(require("plugins.which-key"))              -- which-key (and register groups)

require("lazy").setup(specs, {
  checker = { enabled = true, notify = false },
  change_detection = { enabled = true, notify = false },
  ui = { border = "rounded" },
})
