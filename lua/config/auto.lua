local function augroup(name)
  return vim.api.nvim_create_augroup("augroup_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({
      timeout = 100
    })
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("nvim_start"),
  pattern = "*",
  nested = true,
  callback = function()
    local a = vim.fn.expand("%")

    if require('plenary').path:new(a):exists() or a == "." then
      require("telescope.builtin").oldfiles({
        only_cwd = true,
        initial_mode = "normal",
      })
    end
  end,
})
