local function toggle_bottom()
  local count = vim.v.count > 0 and vim.v.count or 1
  vim.cmd(count .. "ToggleTerm direction=horizontal")
end

return {
  { "<C-/>", toggle_bottom, desc = "Toggle Terminal (bottom; count selects session)", mode = { "n", "t" } },
  { "<Esc>", [[<C-\><C-n>]], desc = "Terminal normal mode", mode = "t" },
}
