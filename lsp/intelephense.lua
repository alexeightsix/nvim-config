return {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_markers = {
      'composer.json',
    },
    files = {
      "**/.git/**",
      "**/node_modules/**",
      "**/vendor/**/{Test,test,Tests,tests}/**/*Test.php",
      "**/vendor/composer/*",
      "**/vendor/faker/*",
      maxSize = 100000,
    }
}
