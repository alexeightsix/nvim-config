return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_filetypes = {
      ["*"] = true,
      ["copilot_filetypes"] = false,
    }
  end
}
