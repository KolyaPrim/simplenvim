return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function() require("plugins.bufferline.config").setup() end,
  keys = require("plugins.bufferline.keys"),
}
