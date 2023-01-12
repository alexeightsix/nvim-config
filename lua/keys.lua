vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- telescope
vim.keymap.set("n", "<C-p>", "<CMD>Telescope find_files<CR>")
vim.keymap.set("n", "<C-f>", "<CMD>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fc", "<CMD>Telescope commands<CR>")

-- buffer
vim.keymap.set("n", "<S-Tab>", "<CMD>:BufferLineCycleNext<CR>")
vim.keymap.set('n', "<leader>e", "<CMD>:NvimTreeToggle<CR>")

vim.keymap.set('n', '<leader>ut', "<CMD>:UndotreeToggle<CR>")

-- lsp



local wk = require("which-key")
local telescope = require("telescope")

wk.register({
        ["<leader>f"] = {
            ["p"] = { telescope.extensions.projects.projects, "Projects" },
        },
})
