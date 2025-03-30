return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'astro',
    'blade',
    'css',
    'gohtml',
    'gohtmltmpl',
    'html',
    'javascript',
    'javascriptreact',
    'liquid',
    'php',
    'postcss',
    'sass',
    'scss',
    'stylus',
    'svelte',
    'templ',
    'twig',
    'typescript',
    'typescriptreact',
    'vue',
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      classAttributes = {
        'class',
        'className',
        'class:list',
        'classList',
        'ngClass',
      },
      includeLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        templ = 'html',
        htmlangular = 'html',
      },
    },
  },
  root_markers = {
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.ts',
  },
}
