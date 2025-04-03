local p = require("utils").mason_path

return {
  cmd = { p('gopls') },
  filetypes = { 'go', 'gomod', 'gosum' },
  root_markers = {
    'go.mod',
    'go.sum',
  }
}
