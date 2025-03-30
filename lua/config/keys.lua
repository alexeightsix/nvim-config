local telescope = require("telescope.builtin")
local print_ln = require("custom.log")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.keymap.set("n", "<S-k>", function()
      vim.lsp.buf.hover()
    end)

    vim.keymap.set("n", "@l", function()
      print_ln.setup()
    end)

    vim.keymap.set("n", "<leader>rn", function()
      vim.lsp.buf.rename()
    end)

    vim.keymap.set("n", "<leader>fd", function()
      require("conform").format(
        {
          lsp_format = "fallback",
          async = true
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

    vim.keymap.set("n", "@cn", function()
      local line = vim.api.nvim_get_current_line()
      local new_line = line:gsub('className="([^"]+)"', 'className={cn("%1")}')
      vim.api.nvim_set_current_line(new_line)

      local ft = vim.api.nvim_buf_get_option(0, "filetype")

      if ft == "typescriptreact" then
        vim.lsp.buf.code_action({
          apply = true,
          context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
        })
      end
    end)

    vim.keymap.set("n", "<leader>wd", function()
      telescope.diagnostics({
        initial_mode = "normal",
      })
    end)

    vim.api.nvim_set_keymap("n", "<Leader>ls", ":LspRestart <CR>", { silent = true, noremap = true })

    vim.keymap.set("n", "<leader>fs", function()
      telescope.lsp_document_symbols()
    end)

    vim.keymap.set("n", "gd", function()
      telescope.lsp_definitions({
        initial_mode = "normal",
      })
    end)
  end,
})

vim.keymap.set("n", "gd", "<Nop>")

vim.api.nvim_set_keymap("n", "<Leader>gh", ":OpenInGHFileLines <CR>", { silent = true, noremap = true })

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

local function cycle_quickfix()
  local quickfix_list = vim.fn.getqflist()
  local current_idx = vim.fn.getqflist({ idx = 0 }).idx
  if current_idx == #quickfix_list then
    vim.cmd("cc 1")
  else
    vim.cmd("cc " .. (current_idx + 1))
  end
end
vim.keymap.set("n", "<S-Tab>", cycle_quickfix, { noremap = true, silent = true })

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

vim.api.nvim_create_user_command("OilToggle", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_filetype = vim.api.nvim_buf_get_option(current_buf, "filetype")
  if current_filetype == "oil" then
    require("oil").toggle_float()
  else
    require("oil").toggle_float()
  end
end, { nargs = 0 })

-- filetree
vim.keymap.set("n", "<leader>e", "<CMD>:OilToggle<CR>")

--git
vim.keymap.set("n", "<leader>td", "<CMD>Gitsigns toggle_deleted<CR>")
vim.keymap.set("n", "<leader>bl", "<CMD>Gitsigns blame_line<CR>")

-- url
vim.keymap.set("n", "gx", "<CMD>URLOpenUnderCursor<CR>")

-- undotree
vim.keymap.set("n", "<leader>ut", "<CMD>:UndotreeToggle<CR>")

-- config
vim.keymap.set("n", "<leader>nc", function()
  vim.cmd("cd ~/.config/nvim")
  vim.cmd("e init.lua")
end)

-- remap
vim.cmd([[
  command! W write
  command! Bd bdelete
]])

-- copilot
vim.api.nvim_set_keymap("i", "<C-A-Right>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
