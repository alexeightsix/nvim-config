local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'bashls',
  'cssls',
  'dockerls',
  'emmet_ls',
  'gopls',
  'html',
  'intelephense',
  'jsonls',
  'pyright',
  'tailwindcss',
  'theme_check',
  'tsserver',
  'vimls',
  'yamlls',
})

lsp.nvim_workspace()

lsp.setup()

vim.diagnostic.config({ virtual_text = true })
