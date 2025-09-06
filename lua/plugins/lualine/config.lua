local M = {}

local function clock() return os.date("%H:%M") end
local function date() return os.date("%Y-%m-%d") end

function M.setup()
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
      disabled_filetypes = { statusline = {}, winbar = {} },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "filename", "branch" },
      lualine_c = {
        { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
        "diff",
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { date, clock },
    },
    inactive_sections = {
      lualine_a = {}, lualine_b = {}, lualine_c = { "filename" }, lualine_x = { "location" }, lualine_y = {}, lualine_z = { date, clock },
    },
    tabline = {},
    extensions = { "nvim-tree", "lazy", "trouble" },
  })
end

return M
