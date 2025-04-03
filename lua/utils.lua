local M = {}

function M.mason_path(bin)
  local p = vim.fn.stdpath("data") .. "/mason/bin/" .. bin
  return p
end

return M
