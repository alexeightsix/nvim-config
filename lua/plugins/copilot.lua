vim.g.copilot_assume_mapped = true

vim.g.copilot_filetypes = {
  ["*"] = true,
}

vim.api.nvim_set_keymap("i", "<C-A-Right>", "<Plug>(copilot-next)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("i", "<C-A-Left>", "<Plug>(copilot-previous)", { noremap = false, silent = true })
