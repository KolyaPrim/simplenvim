local function tb(builtin, opts)
  return function() require("telescope.builtin")[builtin](opts or {}) end
end

return {
  { "<leader>ff", tb("find_files"),  desc = "Find files" },
  { "<leader>fg", tb("live_grep"),   desc = "Live grep" },
  { "<leader>fb", tb("buffers"),     desc = "Buffers" },
  { "<leader>fh", tb("help_tags"),   desc = "Help tags" },
  { "<leader>fs", tb("grep_string"), desc = "Search word under cursor" },
  { "<leader>fr", tb("oldfiles"),    desc = "Recent files" },
  { "<leader>fd", tb("diagnostics"), desc = "Diagnostics" },
  { "<leader>fz", tb("resume"),      desc = "Resume last picker" },
}
