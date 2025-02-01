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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim' },
      }
    },
  },
}

mason_lspconfig.setup {
  ensure_installed = {
    -- "delve",
    -- "gopls",
    -- "intelephense",
    -- "lua_ls",
    -- "eslint",
    -- "html",
    -- "pyright",
    -- "tailwindcss",
    -- "theme_check",
    -- "ts_ls",
    -- "vimls",
    -- "yamlls",
  },
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
local luasnip = require 'luasnip'

require('luasnip.loaders.from_vscode').lazy_load()

luasnip.config.setup {}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
      and vim.api
      .nvim_buf_get_lines(0, line - 1, line, true)[1]
      :sub(col, col)
      :match("%s")
      == nil
end


cmp.setup {
  snippet = {
    -- expand = function(args)
    --   -- require('luasnip').lsp_expand(args.body)
    -- end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end,
    ['<C-j>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end,
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
    -- { name = "friendly-snippets" },
    -- { name = "vim-dadbod-completion" },
    { name = 'path' },
    { name = 'buffer' }
  }
}

vim.diagnostic.config({
  virtual_text = true
})

cmp.setup.filetype({ "sql" }, {
  sources = {
    -- { name = "vim-dadbod-completion" },
    { name = "buffer" },
  },
})

require "lsp_signature".setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  }
})

local null_ls = require("null-ls")

local null_ls_sources = {}

table.insert(null_ls_sources, null_ls.builtins.formatting.prettier.with {
  filetypes = { 'css', 'scss', 'astro' },
})

table.insert(null_ls_sources, null_ls.builtins.formatting.blade_formatter)

require('lspconfig').intelephense.setup({
  files = {
    '**/.git/**',
    '**/node_modules/**',
    '**/vendor/**/{Test,test,Tests,tests}/**/*Test.php',
    '**/vendor/composer/*',
    '**/vendor/faker/*',
    maxSize = 100000,
  },
  on_init = function(client)
    local res = vim.fn.filereadable(client.config.root_dir .. '/vendor/bin/pint')

    client.server_capabilities.licenceKey = "";

    if res == 1 then
      client.server_capabilities.documentFormattingProvider = false
      local pint = null_ls.builtins.formatting.pint.with {
        filetypes = { 'php' },
      }
      table.insert(null_ls_sources, pint)

      null_ls.setup({
        sources = null_ls_sources
      })
    end
  end,
})

require('lspconfig').on_attach = function()
  null_ls.setup({
    sources = null_ls_sources
  })
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

 require('lspconfig')["astro"].setup({
   capabilities = capabilities,
   on_attach = on_attach,
   filetypes = { "astro" },
  })
