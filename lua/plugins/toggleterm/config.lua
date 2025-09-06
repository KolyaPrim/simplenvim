local M = {}

function M.setup()
  require("toggleterm").setup({
    size = function(term)
      if term.direction == "horizontal" then return 12 end
      if term.direction == "vertical" then return math.floor(vim.o.columns * 0.35) end
      return 20
    end,
    open_mapping = nil,
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = { border = "rounded" },
  })
end

return M
