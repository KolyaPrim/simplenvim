local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general_augroup = augroup("GeneralAutocmds", { clear = true })

-- Autosave on focus lost
autocmd("FocusLost", {
  group = general_augroup,
  callback = function()
    if vim.opt.modified:get() then vim.cmd("w") end
  end,
  desc = "Autosave on focus lost",
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = general_augroup,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Briefly highlight yanked text",
})

-- Set filetype for Dockerfile
autocmd({ "BufRead", "BufNewFile" }, {
  group = general_augroup,
  pattern = { "Dockerfile", "dockerfile.*" },
  command = "set filetype=dockerfile",
  desc = "Set filetype for Dockerfile",
})
