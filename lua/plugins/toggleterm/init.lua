return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function() require("plugins.toggleterm.config").setup() end,
  keys = require("plugins.toggleterm.keys"),
}
