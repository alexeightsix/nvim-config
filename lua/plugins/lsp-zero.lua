local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
  'bashls',
  'cssls',
  'dockerls',
  'emmet_ls',
  'gopls',
  'html',
  'intelephense',
  'jsonls',
  'pyright',
  'sumneko_lua',
  'tailwindcss',
  'theme_check',
  'tsserver',
  'vimls',
  'yamlls',
})



-- local ls = require("luasnip")
-- -- some shorthands...
-- local snip = ls.snippet
-- local node = ls.snippet_node
-- local text = ls.text_node
-- local insert = ls.insert_node
-- local func = ls.function_node
-- local choice = ls.choice_node
-- local dynamicn = ls.dynamic_node
--
-- local date = function() return {os.date('%Y-%m-%d')} end
--
-- ls.add_snippets(nil, {
--     all = {
--         snip({
--             trig = "tinker",
--             namr = "Tinker",
--             dscr = "Date in the form of YYYY-MM-DD",
--         }, {
--             func(function() return "eval(\\Psy\\sh());\n" end, {}),
--         }),
--     },
-- })


-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     vim.keymap.set('n', 'dh', vim.lsp.buf.hover, { buffer = args.buf })
--   end,
-- })
--
--




-- lsp.ensure_installed({
--   'html-lsp',
--   'intelephense',
--   'json-lsp',
--   'lemminx',
--   'lua-language-server',
--   'nginx-language-server',
--   'pyright',
--   'shopify-theme-check',
--   'tailwindcss-language-server',
--   'typescript-language-server',
--   'vim-language-server',
--   'yaml-language-server'
-- })
--
lsp.nvim_workspace()


lsp.setup()


vim.diagnostic.config({ virtual_text = true })

