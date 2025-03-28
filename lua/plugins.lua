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
			vim.cmd([[
        colorscheme dracula
        hi! Normal ctermbg=none ctermfg=none guifg=none guibg=none
        hi SpecialKey    guifg=#61AFEF
        hi SpecialKeyWin guifg=#61AFEF
        set winhighlight=SpecialKey:SpecialKeyWin
      ]])
		end,
		lazy = false,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		lazy = true,
		config = function()
			require("plugins.telescope")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	},
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
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-path",
		},
	},
	{
		"github/copilot.vim",
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
		build = "make install_jsregexp",
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
			require("plugins.url")
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"almo7aya/openingh.nvim",
	{
		"stevearc/oil.nvim",
		config = function()
			require("plugins.oil")
		end,
		dependencies = { {
			"echasnovski/mini.icons",
			opts = {},
		} },
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"dmmulroy/ts-error-translator.nvim",
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	"boltlessengineer/sense.nvim",
})

require("ts-error-translator").setup()
