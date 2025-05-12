local M = {}

function M.mason_path(bin)
  local p = vim.fn.stdpath("data") .. "/mason/bin/" .. bin
  return p
end

-- https://gthub.com/onosendi/dotfiles/tree/45bc8f59daa8810324187b7d9ffb3cf0bea9b2e8/.config/nvim
function M.get_workspace_folder()
  local root = vim.fn.getcwd()
  return {
    name = vim.fn.fnamemodify(root, ":t"),
    uri = vim.uri_from_fname(root),
  }
end

return M
