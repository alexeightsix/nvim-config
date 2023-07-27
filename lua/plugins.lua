-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then
  vim.loader.enable()
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end


vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    priority = 5000,
    "Mofiqul/dracula.nvim",
    config = function()
      vim.cmd([[colorscheme dracula]])
    end,
    lazy = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    config = function()
      require("plugins.lualine")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    lazy = false,
    config = function()
      require("plugins.telescope")
    end,
  },
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
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {}
      },
      'folke/neodev.nvim',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
  },
  { "farmergreg/vim-lastplace" },
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
  "ray-x/lsp_signature.nvim",
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true
  },
  "christoomey/vim-tmux-navigator",
  "stefandtw/quickfix-reflector.vim"
})
