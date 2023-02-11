-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- telescope
vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>of", "<CMD>Telescope oldfiles<CR>")
vim.keymap.set("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fc", "<CMD>Telescope commands<CR>")
vim.keymap.set("n", "<leader>fsy", "<CMD>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<leader>lp", "<CMD>Telescope resume<CR>")

vim.keymap.set("n", "<leader>fp", "<CMD>Telescope projects<CR>")

-- format document
vim.keymap.set("n", "<leader>fd", "<CMD>LspZeroFormat<CR>")

-- execute current file
vim.keymap.set('n', '<leader>x', ':!%:p<CR>')

-- buffer
vim.keymap.set("n", "<S-Tab>", "<CMD>:BufferPrevious<CR>")
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>")

-- sidebar
vim.keymap.set('n', "<leader>e", "<CMD>:NvimTreeToggle<CR>")

-- undotree
vim.keymap.set('n', '<leader>ut', "<CMD>:UndotreeToggle<CR>")

-- open neovim config
vim.keymap.set('n', '<leader>nc', "<CMD>:edit $MYVIMRC<CR><CMD>:e $MYVIMRC<CR>")

