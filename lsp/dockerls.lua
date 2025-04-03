local p = require("utils").mason_path

return {
  cmd = { p('docker-langserver'), '--stdio' },
  filetypes = { 'dockerfile' },
  root_markers = {
    'Dockerfile',
  }
}
