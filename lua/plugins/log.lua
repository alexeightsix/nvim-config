local M = {}

M.dict = {
  ["lua"] = "print(x)",
  ["php"] = "var_dump(x);",
  ["js tsx"] = "console.log(x);",
}

M.escape = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.get = function(dict, ext)
  for key, value in pairs(dict) do
    local q = string.find(key, ext)
    if (q ~= nil) then
      return value
    end
  end
end

M.parse = function(str)
  local _, _, _start = string.find(str, "(.*)[x]")
  local _, _, _end = string.find(str, "[x](.*)")
  return _start, _end
end

M.merge = function(a, b)
  for k, v in pairs(b) do
    if type(v) == 'table' and type(a[k] or false) == 'table' then
      M.merge(a[k], v)
    else
      a[k] = v
    end
  end
  return a
end

M.setup = function(opts)
  local dict = M.merge(M.dict, opts)
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    nested = true,
    callback = function()
      vim.fn.setreg("l", "")
      local q = M.get(dict, vim.bo.filetype)
      if (q ~= nil) then
        local _start, _end = M.parse(q)
        local key = M.escape("yiWo" .. _start .. "<ESC>pa" .. _end .. "<CR><ESC>")
        vim.fn.setreg("l", key)
      end
    end
  })
end

return M
