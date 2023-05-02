local telescope = require("telescope.builtin")

-- lsp
vim.keymap.set("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>fd", "<CMD>LspZeroFormat<CR>")

vim.keymap.set("n", "<leader>ff", function()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    telescope.git_files({
      show_untracked = true,
    })
  else
    telescope.find_files()
  end
end)

vim.keymap.set("n", "<leader>faf", function()
  telescope.find_files({
    no_ignore = true,
    hidden = true,
  })
end)

vim.keymap.set("n", "<leader>faw", function()
  telescope.live_grep({
    no_ignore = true,
    hidden = true,
  })
end)


vim.keymap.set("n", "<leader>of", function()
  telescope.oldfiles({
    only_cwd = true,
    initial_mode = "normal",
  })
end)

vim.keymap.set("n", "<leader>fW", function()
  local word = vim.fn.expand("<cword>")

  if word == "" then
    return telescope.live_grep()
  end

  telescope.grep_string({
    initial_mode = "normal",
  })
end)

vim.keymap.set("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fc", "<CMD>Telescope commands<CR>")
vim.keymap.set("n", "<leader>ds", "<CMD>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>")

-- buffer
vim.keymap.set("n", "<S-Tab>", "<CMD>:BufferPrevious<CR>")

-- sidebar
vim.keymap.set("n", "<leader>e", "<CMD>:NvimTreeToggle<CR>")

-- trouble
vim.keymap.set("n", "<leader>tt", "<CMD>:TroubleToggle<CR>")

-- undotree
vim.keymap.set("n", "<leader>ut", "<CMD>:UndotreeToggle<CR>")

-- open neovim config
vim.keymap.set("n", "<leader>nc", "<CMD>:edit $MYVIMRC<CR><CMD>:e $MYVIMRC<CR>")
