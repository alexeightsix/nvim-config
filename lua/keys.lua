local telescope = require("telescope.builtin")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    vim.keymap.set('n', '<S-k>', function()
      vim.lsp.buf.hover()
    end)

    vim.keymap.set('n', '<leader>rn', function()
      vim.lsp.buf.rename()
    end)

    vim.keymap.set("n", "<leader>fd", function()
      vim.lsp.buf.format(
        {
          async = false,
          timeout_ms = 10000,
        })
    end)

    vim.keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end)

    vim.keymap.set("n", "<leader>fr", function() -- find references
      telescope.lsp_references({
        initial_mode = "normal",
      })
    end)

    vim.keymap.set("n", "<leader>wd", function()
      telescope.diagnostics({
        initial_mode = "normal",
      })
    end)


    vim.keymap.set("n", "gd", function()
      telescope.lsp_definitions({
        initial_mode = "normal",
      })
    end)
  end
})

vim.keymap.set("n", "gd", "<Nop>")

vim.keymap.set("n", "<leader>ff", function()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    telescope.git_files({
      show_untracked = true,
    })
  else
    telescope.find_files()
  end
end)

vim.keymap.set("n", "<leader>tt", function()
  require("trouble").toggle({
    position = "right",
  })
end)

vim.keymap.set("n", "<leader>rg", function()
  telescope.registers({
    initial_mode = "normal",
  })
end)

vim.keymap.set("n", "<leader>t", "<CMD>lua vim.diagnostic.open_float(0, {scope='line'})<CR>")
vim.keymap.set("n", "<S-Tab>", "<CMD>:cn<CR>")

vim.keymap.set("n", "<leader>faf", function()
  telescope.find_files({
    no_ignore = true,
    hidden = true,
  })
end)

vim.keymap.set("n", "<leader>s", function()
  return ":%s/"
end, { expr = true })

vim.keymap.set("v", "<leader>s", function()
  return ":s/"
end, { expr = true })

vim.keymap.set("n", "<leader>faw", function()
  telescope.live_grep({
    no_ignore = true,
    hidden = true,
  })
end)

vim.keymap.set("n", "<leader>of", function()
  telescope.oldfiles({
    only_cwd = true,
    initial_mode = "normal",
  })
end)

vim.keymap.set("n", "<leader>fW", function()
  local word = vim.fn.expand("<cword>")

  if word == "" then
    return telescope.live_grep()
  end

  telescope.grep_string({
    initial_mode = "normal",
  })
end)

vim.keymap.set("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")

-- vim.keymap.set("n", "<leader>e", "<CMD>:NvimTreeToggle<CR>")
vim.api.nvim_create_user_command("OilToggle", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_filetype = vim.api.nvim_buf_get_option(current_buf, "filetype")
  local git_root_path =
      require("plenary.job"):new({ command = "git", args = { "rev-parse", "--show-toplevel" } }):sync()[1]
  if current_filetype == "oil" then
    require("oil").toggle_float()
  else
    -- Open oil if not already in an oil buffer
    require("oil").toggle_float()
  end
end, { nargs = 0 })


vim.keymap.set("n", "<leader>e", "<CMD>:OilToggle<CR>")

vim.keymap.set("n", "<leader>db", "<CMD>:DBUIToggle<CR>")

--git
vim.keymap.set("n", "<leader>td", "<CMD>Gitsigns toggle_deleted<CR>")
vim.keymap.set("n", "<leader>bl", "<CMD>Gitsigns blame_line<CR>")

-- url
vim.keymap.set("n", "gx", "<CMD>URLOpenUnderCursor<CR>");

-- undotree
vim.keymap.set("n", "<leader>ut", "<CMD>:UndotreeToggle<CR>")

vim.keymap.set("n", "<leader>nc", function()
  vim.cmd("cd ~/.config/nvim")
  vim.cmd("e init.lua")
end)

vim.cmd [[
  command! W write
  command! Bd bdelete
]]

vim.api.nvim_set_keymap("i", "<C-A-Right>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
vim.fn.setreg("t", vim.api.nvim_replace_termcodes("oeval(\\Psy\\sh());\n<ESC>", true, true, true))

vim.keymap.set('n', '<leader>wt', function()
  require("plugins.lwt").switch()
end)
