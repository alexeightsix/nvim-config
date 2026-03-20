local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

local lsp_servers = {
  "cssls",
  "docker_compose_language_service",
  "dockerls",
  "eslint",
  "gopls",
  "tailwindcss",
  "templ",
  "ts_ls",
}

require("mason-lspconfig").setup {
  ensure_installed = lsp_servers,
}

local navic = require("nvim-navic")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end

    if client.name == "eslint" then
      vim.keymap.set("n", "<leader>fa", function()
        vim.lsp.buf.code_action({
          apply = true,
          context = { diagnostics = {}, only = { "source.fixAll" } },
        })
      end, { buffer = bufnr, noremap = true, silent = true, desc = "Fix all ESLint issues" })
    end
  end,
})

vim.lsp.enable(lsp_servers)
