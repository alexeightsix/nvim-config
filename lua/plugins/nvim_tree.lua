vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup({
  hijack_directories = {
    enable = true,
    auto_open = false,
  },
  trash = {
    cmd = "rm -r",
  },
  git = {
    enable = false,
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
        file = true,
        folder = true,
        git = true,
        modified = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
})
