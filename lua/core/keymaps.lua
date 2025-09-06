local map = vim.keymap.set

-- Disable disruptive defaults
map("n", "Q", "<nop>", { desc = "Disable Q (Ex mode)" })
map("n", "<C-z>", "<nop>", { desc = "Disable Ctrl-Z (suspend)" })

-- === General Keymaps ===

-- Save/Quit
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit Neovim" })
map("n", "<leader>wq", ":wq<CR>", { desc = "Save and Quit" })
map("n", "<leader>x", ":x<CR>", { desc = "Save and Quit (if modified)" })

-- Buffers
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete current buffer" })
map("n", "<leader>bl", ":buffers<CR>", { desc = "List buffers" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resizing
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Colorscheme picker
local colors = {
  "tokyonight-night", "catppuccin-mocha", "gruvbox", "kanagawa",
  "onedark", "rose-pine", "nightfox", "github_dark", "github_light",
}
map("n", "<leader>ut", function()
  vim.ui.select(colors, { prompt = "Select colorscheme:" }, function(choice)
    if choice then pcall(vim.cmd.colorscheme, choice) end
  end)
end, { desc = "Switch Colorscheme" })

-- Clear search highlight
map("n", "<leader>nh", ":nohlsearch<CR>", { desc = "No Highlight Search" })

-- Lazy UI
map("n", "<leader>L", ":Lazy<CR>", { desc = "Lazy: UI" })
map("n", "<leader>Ls", ":Lazy sync<CR>", { desc = "Lazy: Sync" })
map("n", "<leader>Lu", ":Lazy update<CR>", { desc = "Lazy: Update" })
