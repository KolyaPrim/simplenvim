return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function() require("plugins.treesitter.config").setup() end,
}
