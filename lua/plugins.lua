vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.loader.enable()

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
      vim.cmd [[hi! Normal ctermbg=none ctermfg=none guifg=none guibg=none]]
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
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
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
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },
  "virchau13/tree-sitter-astro",
  "mbbill/undotree",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
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
  "nvimtools/none-ls.nvim",
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim'
    }
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path'
    },
  },
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
    config = true,
    require = function()
      require("plugins.conflict")
    end,
  },
  "j-hui/fidget.nvim",
  "christoomey/vim-tmux-navigator",
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = "make install_jsregexp"
  },
  "rafamadriz/friendly-snippets"
})

require("plugins.log").setup({
  ["php"] = "print_r(x);",
  ["lua"] = "print(x)",
  ["js tsx"] = "console.log(x);",
})
