require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = border
  opts.pad_top = 0.1
  opts.pad_bottom = 0.1
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      settings = servers[server_name],
      handlers = handlers,
    }
  end
}
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
}




-- require("lsp_signature").setup({
--   floating_window = false,
-- })


-- local null_ls = require("null-ls")
--
-- null_ls.setup({
--     sources = {
--         -- null_ls.builtins.formatting.phpcsfixer,
--         -- null_ls.builtins.formatting.pint,
--         null_ls.builtins.formatting.stylua,
--         null_ls.builtins.diagnostics.eslint,
--         null_ls.builtins.completion.spell,
--     },
-- })
--


--
-- -- lsp.ensure_installed({
-- --   "bashls",
-- --   "cssls",
-- --   "dockerls",
-- --   "emmet_ls",
-- --   "gopls",
-- --   "html",
-- --   "intelephense",
-- --   "jsonls",
-- --   "pyright",
-- --   "tailwindcss",
-- --   "theme_check",
-- --   "tsserver",
-- --   "vimls",
-- --   "yamlls",
-- -- })
--
-- lsp.nvim_workspace()
--
-- lsp.setup()
--
--
-- cmp.setup({
--   window = {
--     completion = {
--       col_offset = -3, -- align the abbr and word on cursor (due to fields order below)
--     },
--   },
--   formatting = {
--     fields = { "kind", "abbr", "menu" },
--     format = lspkind.cmp_format({
--       before = function(entry, vim_item) -- for tailwind css autocomplete
--         if vim_item.kind == "Color" and entry.completion_item.documentation then
--           local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
--           if r then
--             local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
--             local group = "Tw_" .. color
--             if vim.fn.hlID(group) < 1 then
--               vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
--             end
--             vim_item.kind = "■" -- or "⬤" or anything
--             vim_item.kind_hl_group = group
--             return vim_item
--           end
--         end
--         -- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
--         -- or just show the icon
--         vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
--         return vim_item
--       end,
--     }),
--   },
-- })
--

vim.diagnostic.config({
  virtual_text = true
})

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with {
      filetypes = { 'css', 'scss' },
    }, }
})
