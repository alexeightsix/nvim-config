-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- move line up or down
vim.keymap.set('n', '<C-s>', ':update<CR>')
vim.keymap.set('v', '<C-s>', ':update<CR>')
vim.keymap.set('i', '<C-s>', '<Esc>:update<CR>li')

-- telescope
vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fc", "<CMD>Telescope commands<CR>")

-- buffer
vim.keymap.set("n", "<S-Tab>", "<CMD>:BufferLineCycleNext<CR>")

-- sidebar
vim.keymap.set('n', "<leader>e", "<CMD>:NvimTreeToggle<CR>")

-- undotree
vim.keymap.set('n', '<leader>ut', "<CMD>:UndotreeToggle<CR>")

-- open config
vim.keymap.set('n', '<leader>nc', "<CMD>:edit $MYVIMRC<CR><CMD>:e $MYVIMRC<CR>")

local wk = require("which-key")
local telescope = require("telescope")

wk.register({
  ["<leader>f"] = {
    ["p"] = { telescope.extensions.projects.projects, "Projects" },
  },
})
