local cmd = vim.cmd

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup({
  function(use)
    -- A use-package inspired plugin manager for Neovim.
    -- Uses native packages, supports Luarocks dependencies,
    -- written in Lua, allows for expressive config
    use({ "wbthomason/packer.nvim", opt = true })

    -- Improve startup time for Neovim
    use({
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
      end,
    })

    use("nvim-tree/nvim-web-devicons")
    
    -- Dracula colorscheme for neovim written in Lua
    use({
      "Mofiqul/dracula.nvim",
      config = function()
        vim.cmd([[colorscheme dracula]])
      end,
    })

    -- A blazing fast and easy to configure neovim statusline
    -- plugin written in pure lua.
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("plugins.lualine")
      end,
    })

    -- Find, Filter, Preview, Pick. All lua, all the time.
    use({
      "nvim-telescope/telescope.nvim",
      tag = "0.1.x",
      requires = { { "nvim-lua/plenary.nvim" } },
    })

    -- boom Create key bindings that stick. WhichKey is a lua
    -- plugin for Neovim 0.5 that displays a popup with possible
    -- keybindings of the command you started typing.
    use({
      "folke/which-key.nvim",
      config = function()
        require("plugins.whichkey")
      end,
    })


    use({ "romgrk/barbar.nvim", requires = "nvim-web-devicons" })

    use({
      "nvim-tree/nvim-tree.lua",
      config = function()
        require("plugins.nvim_tree")
      end,
      requires = {
        "nvim-tree/nvim-web-devicons",
      },
    })

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    use("mbbill/undotree")

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("plugins.autopairs")
      end,
    })

    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("plugins.gitsigns")
      end,
    })

    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("plugins.blanklines")
      end,
    })

    use({
      "numToStr/Comment.nvim",
      config = function()
        require("plugins.comment")
      end,
    })

    use({
      "RRethy/vim-illuminate",
      config = function()
        require("plugins.illuminate")
      end,
    })

    use({
      "VonHeikemen/lsp-zero.nvim",
      config = function()
        require("plugins.lsp-zero")
        require("plugins.luasnip")
      end,
      requires = {
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
    })

    use({
      "folke/trouble.nvim",
      config = function()
        require("plugins.trouble")
      end,
    })

    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("plugins.project")
      end,
    })

    use("matze/vim-move")

    use({
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("plugins.null-ls")
      end,
    })

    use("farmergreg/vim-lastplace")

    use({
      "petertriho/nvim-scrollbar",
      config = function()
        require("plugins.scrollbar")
      end,
    })

    use({
      "rmagatti/auto-session",
      config = function()
        require("plugins.auto-session")
      end,
    })

    use({
      "yamatsum/nvim-cursorline",
      config = function()
        require("nvim-cursorline")
      end,
    })
    use("editorconfig/editorconfig-vim")
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
