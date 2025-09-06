local M = {}

function M.setup()
  require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    view = {
      width = 60,
      side = "right",
      float = { enable = false },
    },
    renderer = {
      group_empty = false,
      highlight_git = true,
      icons = {
        git_placement = "before",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = { file = true, folder = true, folder_arrow = true },
      },
    },
    actions = {
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = { enable = true },
      },
    },
    filters = {
      dotfiles = false,
      custom = { "node_modules", ".DS_Store" },
    },
    git = { enable = true, ignore = false },
    diagnostics = { enable = true },
  })
end

return M
