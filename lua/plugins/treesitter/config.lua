local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "lua", "vim", "vimdoc", "regex",
      "bash", "json", "jsonc", "yaml", "toml", "ini",
      "dockerfile", "html", "css", "javascript", "typescript",
      "markdown", "markdown_inline",
      "xml", "gitignore", "gitattributes", "gitcommit", "diff",
    },
    highlight = { enable = true },
    indent = { enable = true, disable = { "yaml" } },
    incremental_selection = { enable = true },
    sync_install = false,
    auto_install = false,
  })
end

return M
