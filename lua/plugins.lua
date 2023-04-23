-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "theprimeagen/vim-be-good",
  -- Improve startup time for Neovim
  {
    priority = 4000,
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient")
    end,
    lazy = false,
  },
  "nvim-tree/nvim-web-devicons",
  -- Dracula colorscheme for neovim written in Lua
  {
    priority = 5000,
    "Mofiqul/dracula.nvim",
    config = function()
      vim.cmd([[colorscheme dracula]])
    end,
    lazy = false,
  },
  -- A blazing fast and easy to configure neovim statusline
  -- plugin written in pure lua.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    config = function()
      require("plugins.lualine")
    end,
  },
  -- Find, Filter, Preview, Pick. All lua, all the time.
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    lazy = false,
    config = function()
      require("plugins.telescope")
    end,
  },
  -- boom Create key bindings that stick. WhichKey is a lua
  -- plugin for Neovim 0.5 that displays a popup with possible
  -- keybindings of the command you started typing.
  { "romgrk/barbar.nvim", dependencies = "nvim-web-devicons" },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("plugins.nvim_tree")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "mbbill/undotree",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.blanklines")
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.comment")
    end,
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("plugins.illuminate")
    end,
  },
  {
    branch = "v1.x",
    "VonHeikemen/lsp-zero.nvim",
    config = function()
      require("plugins.lsp-zero")
      require("plugins.luasnip")
    end,
    dependencies = {
      { "L3MON4D3/LuaSnip" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/nvim-cmp" },
      { "neovim/nvim-lspconfig" },
      { "rafamadriz/friendly-snippets" },
      { "saadparwaiz1/cmp_luasnip" },
      { "williamboman/mason-lspconfig.nvim" },
      { "williamboman/mason.nvim" },
    },
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("plugins.trouble")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.project")
    end,
  },
  "matze/vim-move",
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.null-ls")
    end,
  },
  { "farmergreg/vim-lastplace" },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("plugins.scrollbar")
    end,
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("plugins.auto-session")
    end,
  },
  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline")
    end,
  },
  "editorconfig/editorconfig-vim",
  {
    "github/copilot.vim",
    config = function()
      require("plugins.copilot")
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("plugins.colorizer")
    end,
  },
})
