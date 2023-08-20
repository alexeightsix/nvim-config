local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})

local function exists(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

local function is_dir(path)
  return exists(path .. "/")
end

local group_id = vim.api.nvim_create_augroup("nvim_start", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = group_id,
  pattern = "*",
  nested = true,
  callback = function()
    vim.cmd([[SessionRestore]])
    -- open telescope files if we are in a directory
    local a = vim.fn.expand("%")

    if is_dir(a) or a == "." then
      require("telescope.builtin").oldfiles({
        only_cwd = true,
        initial_mode = "normal",
      })
    end
  end,
})
