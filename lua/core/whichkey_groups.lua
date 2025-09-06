local M = {}

function M.register()
  local ok, wk = pcall(require, "which-key")
  if not ok then return end
  wk.add({
    { "<leader>b", group = "Buffers" },
    { "<leader>c", group = "Code" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>u", group = "UI" },
    { "<leader>w", group = "Windows" },
    { "<leader>x", group = "Diagnostics" },
  })
end

return M
