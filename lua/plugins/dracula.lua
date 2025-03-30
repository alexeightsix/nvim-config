return {
  "Mofiqul/dracula.nvim",
  priority = 5000,
  lazy = false,
  config = function()
    vim.cmd([[
			colorscheme dracula
			hi! Normal ctermbg=none ctermfg=none guifg=none guibg=none
			hi SpecialKey    guifg=#61AFEF
			hi SpecialKeyWin guifg=#61AFEF
			set winhighlight=SpecialKey:SpecialKeyWin
		]])
  end
}
