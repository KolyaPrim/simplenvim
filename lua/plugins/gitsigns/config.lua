local M = {}

function M.setup()
  require("gitsigns").setup({
    signs = {
      add = { text = "▎" }, change = { text = "▎" },
      delete = { text = "" }, topdelete = { text = "" },
      changedelete = { text = "▎" }, untracked = { text = "▎" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end
      map("n", "]h", gs.next_hunk, "Git hunk: next")
      map("n", "[h", gs.prev_hunk, "Git hunk: prev")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Git hunk: stage")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Git hunk: reset")
      map("n", "<leader>ghS", gs.stage_buffer, "Git buffer: stage")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Git hunk: undo stage")
      map("n", "<leader>ghp", gs.preview_hunk, "Git hunk: preview")
      map("n", "<leader>gtd", gs.toggle_deleted, "Git: toggle deleted")
      map("n", "<leader>gbl", gs.blame_line, "Git: blame line")
    end,
  })
end

return M
