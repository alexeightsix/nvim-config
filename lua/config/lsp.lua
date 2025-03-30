local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
require("mason").setup()

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

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  intelephense = {
    files = {
      "**/.git/**",
      "**/node_modules/**",
      "**/vendor/**/{Test,test,Tests,tests}/**/*Test.php",
      "**/vendor/composer/*",
      "**/vendor/faker/*",
      maxSize = 100000,
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
  ensure_installed = {
    "lua_ls",
    "gopls",
    "intelephense",
    "ts_ls",
    "eslint",
    "tailwindcss",
  }
}

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      settings = servers[server_name],
      handlers = handlers,
    })
  end,
})
