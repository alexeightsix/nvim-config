local p = require("utils").mason_path

return {
  cmd = {
    p('vscode-css-language-server'), '--stdio'
  },
  filetypes = { 'css', 'scss' },
  init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
  root_markers = {
    'package.json',
  },
  single_file_support = true,
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = false },
  }
}
