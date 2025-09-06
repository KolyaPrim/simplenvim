-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Editor behavior
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.undofile = true
do
  local undodir = vim.fn.stdpath("state") .. "/undo"
  if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
  end
  vim.opt.undodir = undodir
end
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.conceallevel = 0
vim.opt.concealcursor = "n"
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.shortmess:append("c")
vim.opt.showtabline = 2 -- Always show bufferline/tabline

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Default colorscheme
vim.cmd("colorscheme github_dark")
