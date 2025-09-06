local M = {}

function M.setup()
  require("mason-tool-installer").setup({
    ensure_installed = {
      -- LSP
      "lua-language-server", "bash-language-server", "vscode-json-language-server",
      "yaml-language-server", "lemminx", "dockerfile-language-server",
      "html-lsp", "css-lsp", "typescript-language-server", "pyright", "marksman",
      -- Formatters
      "stylua", "prettierd", "prettier", "shfmt", "taplo",
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 3000,
    debounce_hours = 24,
  })
end

return M
