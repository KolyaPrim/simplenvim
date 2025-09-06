return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function() require("plugins.mason-tool-installer.config").setup() end,
}
