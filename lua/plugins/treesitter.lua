require('nvim-treesitter.configs').setup({
  ensure_installed = { 'astro', 'tsx', 'typescript', 'html', 'css' },
  auto_install = true,
  highlight = {
    enable = true
  }
})
