return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  config = function() require("plugins.trouble.config").setup() end,
  keys = require("plugins.trouble.keys"),
}
