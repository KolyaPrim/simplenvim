return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "b0o/SchemaStore.nvim",
    "folke/neodev.nvim",
  },
  config = function() require("plugins.lsp.config").setup() end,
}
