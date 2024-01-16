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

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("log"),
  nested = true,
  callback = function()
    local dictionary = {
      ["lua"] = "print(x)",
      ["php"] = "var_dump(x);",
      ["js"] = "console.log(x);",
    }
    local q = dictionary[vim.bo.filetype]

    if (q ~= nil) then
      local _, _, o = string.find(q, "(.*)[x]")
      local _, _, c = string.find(q, "[x](.*)")
      local key = vim.api.nvim_replace_termcodes("yiWo" .. o .. "<ESC>pi" .. c .. "\n<ESC>", true, true, true)
      vim.fn.setreg("l", key)
    end
  end,
})
