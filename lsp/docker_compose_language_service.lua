local p = require("utils").mason_path

return {
  default_config = {
    cmd = { p('docker-compose-langserver'), '--stdio' },
    filetypes = { 'yaml.docker-compose' },
    root_markers = {
      'docker-compose.yaml',
      'docker-compose.yml',
      'compose.yaml',
      'compose.yml'
    },
    single_file_support = true,
  }
}
