local keys = {
  { "<leader>bb", "<cmd>BufferLinePick<CR>", desc = "Buffer pick" },
}
for i = 1, 9 do
  table.insert(keys, { "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", desc = "Go to buffer " .. i })
end
return keys
