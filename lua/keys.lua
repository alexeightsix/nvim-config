local telescope = require("telescope.builtin")
local lsp = require("lsp-zero")

lsp.on_attach(function()
  vim.keymap.set("n", "<leader>ds", "<CMD>Telescope lsp_document_symbols<CR>")
  vim.keymap.set("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>")
  vim.keymap.set("n", "<leader>fd", "<CMD>LspZeroFormat<CR>")
  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end)
end)

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

vim.keymap.set("n", "<leader>tt", function()
  telescope.diagnostics(require("telescope.themes").get_dropdown({
    initial_mode = "normal",
    layout_config = {
      width = 0.9,
      height = 0.3,
    },
  }))
end)

vim.keymap.set("n", "<leader>t", "<CMD>lua vim.diagnostic.open_float(0, {scope='line'})<CR>")

vim.keymap.set("n", "<leader>faf", function()
  telescope.find_files({
    no_ignore = true,
    hidden = true,
  })
end)

vim.keymap.set("n", "<leader>s", function()
  return ":%s/"
end, { expr = true })

vim.keymap.set("v", "<leader>s", function()
  return ":'<,'>s/"
end, { expr = true })

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

-- sidebar
vim.keymap.set("n", "<leader>e", "<CMD>:NvimTreeToggle<CR>")

--git
vim.keymap.set("n", "<leader>td", "<CMD>Gitsigns toggle_deleted<CR>")
vim.keymap.set("n", "<leader>bl", "<CMD>Gitsigns blame_line<CR>")

-- undotree
vim.keymap.set("n", "<leader>ut", "<CMD>:UndotreeToggle<CR>")

-- open neovim config
vim.keymap.set("n", "<leader>nc", "<CMD>:edit $MYVIMRC<CR><CMD>:e $MYVIMRC<CR>")

-- copilot
vim.api.nvim_set_keymap("i", "<C-A-Up>", "<Plug>(copilot-next)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("i", "<C-A-Down>", "<Plug>(copilot-previous)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("i", "<C-A-Right>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
