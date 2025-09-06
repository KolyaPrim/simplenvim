return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false, 
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function() require("plugins.nvim-tree.config").setup() end,
  keys = require("plugins.nvim-tree.keys"),
}
