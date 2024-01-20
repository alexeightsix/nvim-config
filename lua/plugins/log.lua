local M = {}

M.defaults = {
  register = "l",
  mappings = {
    ["php"] = "var_dump(x);",
    ["lua"] = "print(x)",
    ["js tsx"] = "console.log(x);",
  }
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

M.set = function(reg, str)
  vim.fn.setreg(reg, str)
end

M.clear = function(reg)
  vim.fn.setreg(reg, "")
end

M.setup = function(params)
  local opts = M.merge(M.defaults, params)
  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("_log",
      {
        clear = true
      }
    ),
    pattern = "*",
    nested = true,
    callback = function()
      M.clear(opts.register)
      local query = M.get(opts.mappings, vim.bo.filetype)
      if (query ~= nil) then
        local _start, _end = M.parse(query)
        local key = M.escape("yiWo" .. _start .. "<ESC>pa" .. _end .. "<CR><ESC>")
        M.set(opts.register, key)
      end
    end
  })
end

return M
