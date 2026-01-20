local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
  handlers = handlers,
})

local lsp_servers = {
  "astro",
  "cssls",
  "docker_compose_language_service",
  "dockerls",
  "eslint",
  "golangci_lint_ls",
  "gopls",
  "clangd",
  "intelephense",
  "lua_ls",
  "pyright",
  "rust_analyzer",
  "tailwindcss",
  "templ",
  "ts_ls",
  "zls",
}

require("mason-lspconfig").setup {
  ensure_installed = lsp_servers,
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
