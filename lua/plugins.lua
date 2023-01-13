local cmd = vim.cmd

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

-- Boostrap Packer
local packer_bootstrap = ensure_packer()

-- Rerun PackerCompile everytime plugins.lua is updated
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({ function(use)

  use({ 'wbthomason/packer.nvim', opt = true })

  use({ 'Mofiqul/dracula.nvim' })

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('plugins.lualine') end
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }

  use {
    "folke/which-key.nvim",
    config = function() require('plugins.whichkey') end
  }

  use({
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function() require('plugins.bufferline') end
  })

  use {
    'nvim-tree/nvim-tree.lua',
    config = function() require('plugins.nvim_tree') end,
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }
  }

  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

  use('mbbill/undotree')

  use {
    "windwp/nvim-autopairs",
    config = function() require("plugins.autopairs") end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.gitsigns') end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('plugins.blanklines') end
  }

  use {
    'numToStr/Comment.nvim',
    config = function() require('plugins.comment') end
  }

  use {
    'RRethy/vim-illuminate',
    config = function() require('plugins.illuminate') end
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    config = function()
      require('plugins.lsp-zero')
      require('plugins.luasnip')
    end,
    requires = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/nvim-cmp' },
      { 'neovim/nvim-lspconfig' },
      { 'rafamadriz/friendly-snippets' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'williamboman/mason.nvim' },
    }
  }

  use("kyazdani42/nvim-web-devicons");

  use {
    "folke/trouble.nvim",
    config = function() require("plugins.trouble") end
  }

  use {
    'ahmedkhalf/project.nvim',
    config = function() require('plugins.project') end
  }

  use("matze/vim-move")

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function() require('plugins.null-ls') end
  }

  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end
  }


  use("farmergreg/vim-lastplace")
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
})
