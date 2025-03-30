return {
  "ray-x/lsp_signature.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
  },
  opts = {
    bind = false,
    handler_opts = {
      border = "rounded",
    }
  }
}
