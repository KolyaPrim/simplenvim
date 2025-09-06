local M = {}

function M.setup()
  require("bufferline").setup({
    options = {
      mode = "buffers",
      diagnostics = "nvim_lsp",
      separator_style = "slant",
      show_buffer_close_icons = false,
      show_close_icon = false,
      always_show_bufferline = true,
      hover = { enabled = true, delay = 200, reveal = { "close" } },
      offsets = {
        { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", separator = true },
      },
    },
  })
end

return M
