local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
  }
  opts.pad_top = 0.1
  opts.pad_bottom = 0.1
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

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
  "eslint",
  "gopls",
  "intelephense",
  "lua_ls",
  "tailwindcss",
  "templ",
  "ts_ls",
  "docker_compose_language_service",
  "dockerls",
  -- "astro",
  -- "rust_analyzer",
  -- "clangd",
  -- "cssls",
  "golangci_lint_ls",
  -- "pyright",
  -- "ruby_lsp",
  -- "zls",
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

require("lspconfig").ts_ls.setup {
  on_attach = on_attach
}

require("lspconfig").gopls.setup {
  on_attach = on_attach
}
