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
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    lazy = true,
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
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets'
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
  "christoomey/vim-tmux-navigator",
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = "make install_jsregexp"
  },
  {
    "sontungexpt/url-open",
    branch = "mini",
    event = "VeryLazy",
    cmd = "URLOpenUnderCursor",
    config = function()
      local status_ok, _ = pcall(require, "url-open")
      if not status_ok then
        return
      end
      require('plugins.url');
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_lines = false })
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
  },
  {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    config = function()
      require('plugins.dap')
    end,
  }


})

require("plugins.log").setup({
  register = "l",
  mappings = {
    ["go"] = "fmt.Println(x)",
    ["php"] = "var_dump(x);",
    ["lua"] = "print(x)",
    ["js tsx"] = "console.log(x);",
  }
})
