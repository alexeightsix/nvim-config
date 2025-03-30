return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'astro',
        'css',
        'go',
        'html',
        'php',
        'tsx',
        'typescript',
      },
      auto_install = true,
      highlight = {
        enable = true
      }
    })
  end
}
