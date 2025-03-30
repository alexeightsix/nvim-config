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

vim.lsp.enable({
  "astro_ls",         -- npm install -g @astrojs/language-server
  "cssls",         -- npm i -g vscode-langservers-extracted
  "eslint",        -- npm i -g vscode-langservers-extracted
  "gopls",            -- go get golang.org/x/tools/gopls@latest
  "intelephense",  -- npm i -g intelephense
  "lua_ls",        -- dnf copr enable yorickpeterse/lua-language-server && dnf install lua-language-server
  "tailwindcss",   -- npm i -g tailwindcss-language-server
  "ts_ls",         -- npm i -g typescript typescript-language-server
})
