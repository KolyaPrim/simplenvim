-- Lua filetype specific settings

-- Indentation: 2 spaces
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

-- Run current Lua file
vim.keymap.set("n", "<leader>rl", ":!lua %<CR>", { buffer = true, desc = "Run current Lua file" })
