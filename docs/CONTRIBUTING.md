# Contributing

Thanks for your interest in improving this Neovim config! The goals are:
- Minimal and robust base that 99% of developers can use daily
- Explicit, consistent structure (1 plugin = 1 folder = init.lua + config.lua + keys.lua)
- Easy to extend and safe to maintain

Before you start:
- Use Neovim 0.11+ (0.12 recommended)
- Use the consistent plugin pattern
- Keep comments concise and only when non-obvious

Repository guidelines:
- Structure:
  - Global keymaps: lua/core/keymaps.lua
  - LSP buffer keymaps: lua/core/lsp_keymaps.lua (LspAttach-based)
  - which-key groups: lua/core/whichkey_groups.lua
  - Plugins: lua/plugins/<name>/{init.lua,config.lua,keys.lua}
- LSP:
  - Configure servers in lua/plugins/lsp/config.lua
  - Prefer mason-lspconfig ensure_installed
  - Buffer-local behavior only in on_attach or via LspAttach
- Formatting:
  - Use conform.nvim (lua/plugins/conform/config.lua)
  - format_on_save enabled with LSP fallback
- Treesitter:
  - Only essential languages by default; add more on demand

Coding style:
- Lua: idiomatic, explicit for meaningful defaults
- Avoid deprecated APIs (see :h deprecated)
- Use vim.uv instead of vim.loop (0.10+)
- Keep plugin configs small and clear; extract helpers if needed

Commit messages:
- Prefer Conventional Commits (feat:, fix:, docs:, refactor:, chore:)
- Keep messages descriptive and scoped

Testing:
- Basic: nvim --headless "+Lazy! sync" +qa
- Open a few common filetypes; check :LspInfo, :checkhealth
- Try [d / ]d diagnostics, <leader>lf format, Telescope, NvimTree

Pull Requests:
- Describe the problem and the solution
- Include OS/Neovim version
- Reference related issues if applicable
- Keep changes focused (avoid unrelated reformatting)
