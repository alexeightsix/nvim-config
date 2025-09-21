local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
capabilities = vim.tbl_deep_extend('force', capabilities, {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = false,
      }
    },
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
  }
})

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
  handlers = handlers,
})

local lsp_servers = {
  astro = { enabled = false },
  clangd = { enabled = false },
  cssls = { enabled = false },
  docker_compose_language_service = { enabled = true },
  dockerls = { enabled = true },
  eslint = { enabled = true },
  golangci_lint_ls = { enabled = true },
  gopls = { enabled = true },
  intelephense = { enabled = true },
  lua_ls = { enabled = true },
  pyright = { enabled = false },
  ruby_lsp = { enabled = false },
  rust_analyzer = { enabled = false },
  tailwindcss = { enabled = true },
  templ = { enabled = true },
  ts_ls = { enabled = true },
  zls = { enabled = false },
}

local enabled_lsp_servers = {}

for name, opts in pairs(lsp_servers) do
  if opts.enabled then
    table.insert(enabled_lsp_servers, name)
  end
end

require("mason-lspconfig").setup {
  ensure_installed = enabled_lsp_servers,
}

local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

vim.lsp.config("ts_ls", {
  on_attach = on_attach,
})


vim.lsp.config("gopls", {
  on_attach = on_attach,
})
