-- Unified, buffer-local LSP keymaps via LspAttach
-- Works regardless of who started the client; compatible with 0.11/0.12

local function diag_jump(delta)
  -- 0.12+: use on_jump; 0.11: use float=true
  local has_012 = vim.fn.has("nvim-0.12") == 1
  if has_012 then
    return function()
      vim.diagnostic.jump({
        count = delta,
        on_jump = function()
          vim.defer_fn(function()
            vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
          end, 0)
        end,
      })
    end
  else
    return function()
      vim.diagnostic.jump({ count = delta, float = true })
    end
  end
end

local function set_lsp_keymaps(bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Core LSP
  map("n", "gD", vim.lsp.buf.declaration, "LSP: Declaration")
  map("n", "gd", vim.lsp.buf.definition, "LSP: Definition")
  map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
  map("n", "gi", vim.lsp.buf.implementation, "LSP: Implementation")
  map("n", "gs", vim.lsp.buf.signature_help, "LSP: Signature help")

  -- Code actions under <leader>l
  map("n", "<leader>lr", vim.lsp.buf.rename, "LSP: Rename")
  map("n", "<leader>la", vim.lsp.buf.code_action, "LSP: Code action")

  -- Formatting via Conform (fallback to LSP)
  map("n", "<leader>lf", function()
    local ok_conform, conform = pcall(require, "conform")
    if ok_conform then
      conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
    else
      vim.lsp.buf.format({ async = false })
    end
  end, "LSP: Format buffer")

  -- Diagnostics
  map("n", "gl", vim.diagnostic.open_float, "Diagnostics: Line")
  map("n", "[d", diag_jump(-1), "Diagnostics: Prev")
  map("n", "]d", diag_jump(1), "Diagnostics: Next")
end

-- Auto-apply on attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttachKeymaps", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    set_lsp_keymaps(bufnr)
  end,
  desc = "Set LSP keymaps on LspAttach",
})

-- Also apply to already-attached buffers (e.g. if this file loads after clients)
for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
  if vim.api.nvim_buf_is_loaded(bufnr) then
    local clients = vim.lsp.get_clients({ buffer = bufnr })
    if clients and #clients > 0 then
      set_lsp_keymaps(bufnr)
    end
  end
end
