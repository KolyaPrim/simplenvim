-- LSP: Mason + mason-lspconfig + lspconfig (+ neodev for lua)
local M = {}

function M.setup()
  local ok_lsp, lspconfig = pcall(require, "lspconfig")
  if not ok_lsp then return end

  local ok_mason, mason = pcall(require, "mason")
  if ok_mason then
    mason.setup({ ui = { border = "rounded" }, max_concurrent_installers = 4 })
  end

  local ok_mlsp, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not ok_mlsp then return end

  -- neodev before lua_ls
  pcall(function()
    require("neodev").setup({
      library = { enabled = true, runtime = true, types = true },
    })
  end)

  local servers_list = { "lua_ls", "bashls", "jsonls", "yamlls", "lemminx", "dockerls", "marksman" }

  mason_lspconfig.setup({
    ensure_installed = servers_list,
    automatic_installation = true,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok_cmp, cmp_caps = pcall(require, "cmp_nvim_lsp")
  capabilities = ok_cmp and cmp_caps.default_capabilities(capabilities) or capabilities

  -- Diagnostics (global)
  vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = { border = "rounded", source = "always", header = "", prefix = "" },
  })

  -- Toggle diagnostics virtual text
  vim.keymap.set("n", "<leader>uv", function()
    local cfg = vim.diagnostic.config()
    vim.diagnostic.config({ virtual_text = not cfg.virtual_text })
  end, { desc = "Toggle diagnostics virtual text" })

  local util_ok, util = pcall(require, "lspconfig.util")

  local on_attach = function(client, bufnr)
    -- omnifunc
    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

    -- Inlay hints if supported
    local ih = vim.lsp.inlay_hint
    pcall(function()
      if ih and type(ih.enable) == "function" then
        ih.enable(true, { bufnr = bufnr })
      end
    end)

    -- Document highlight if supported
    if client.server_capabilities.documentHighlightProvider then
      local grp = vim.api.nvim_create_augroup("LspDocumentHighlight" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd("CursorHold",
        { buffer = bufnr, group = grp, callback = vim.lsp.buf.document_highlight })
      vim.api.nvim_create_autocmd("CursorMoved", { buffer = bufnr, group = grp, callback = vim.lsp.buf.clear_references })
    end
  end

  local function setup_server(server_name)
    local opts = { on_attach = on_attach, capabilities = capabilities }

    if server_name == "lua_ls" then
      if util_ok then
        opts.root_dir = function(fname)
          return util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml",
                "selene.toml", "selene.yml", "neodev.json")(fname)
              or util.find_git_ancestor(fname)
              or util.root_pattern("lua")(fname)
              or vim.fn.stdpath("config")
        end
      end
      opts.single_file_support = true
      opts.settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              vim.fn.stdpath("config"),
            },
          },
          telemetry = { enable = false },
        },
      }
    elseif server_name == "jsonls" then
      local ok_schema, schemastore = pcall(require, "schemastore")
      opts.settings = {
        json = { schemas = ok_schema and schemastore.json.schemas() or {}, validate = { enable = true } },
      }
    elseif server_name == "yamlls" then
      local ok_schema, schemastore = pcall(require, "schemastore")
      opts.settings = {
        yaml = {
          schemaStore = { enable = false, url = "" },
          schemas = ok_schema and schemastore.yaml.schemas() or {},
          keyOrdering = false,
        },
      }
    end

    lspconfig[server_name].setup(opts)
  end

  -- Compatible with old mason-lspconfig
  if type(mason_lspconfig.setup_handlers) == "function" then
    mason_lspconfig.setup_handlers({
      function(server_name) setup_server(server_name) end,
    })
  else
    for _, server_name in ipairs(servers_list) do
      setup_server(server_name)
    end
  end
end

return M
