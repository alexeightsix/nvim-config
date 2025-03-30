return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luacheckrc',
    '.luarc.json',
    '.luarc.jsonc',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    'lua-language-server.json',
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      }
    },
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning
}
