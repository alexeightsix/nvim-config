-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  hijack_directories = {
    enable = true,
    auto_open = false,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = {},
  },
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = false,
        folder = false,
        git = false,
        modified = false
      },
    },
  },
  filters = {
    dotfiles = false,
  },
})
