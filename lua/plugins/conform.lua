return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = {
        "stylua"
      },
      javascript = {
        "prettierd",
        "prettier",
        stop_after_first = true
      },
    }
  }
}
