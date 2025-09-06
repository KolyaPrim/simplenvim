local M = {}

function M.setup()
  local ok, telescope = pcall(require, "telescope")
  if not ok then return end
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        "rg", "--color=never", "--no-heading", "--with-filename",
        "--line-number", "--column", "--smart-case",
      },
      prompt_prefix = "  ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules/", ".DS_Store" },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<Esc>"] = actions.close,
        },
        n = { ["q"] = actions.close },
      },
    },
    pickers = {
      find_files = { find_command = { "rg", "--files", "--hidden", "--glob", "!.git" } },
      live_grep  = { only_sort_text = true },
    },
    extensions = {
      fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
    },
  })
  pcall(telescope.load_extension, "fzf")
end

return M
