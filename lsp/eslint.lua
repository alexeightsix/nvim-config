local utils = require("utils")

local function set_keymap(opts)
  local mode = opts.mode or "n"
  local bufnr = opts.bufnr or 0
  local expr = opts.expr or false

  vim.keymap.set(
    mode,
    opts.key,
    opts.cmd,
    {
      expr = expr,
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = opts.desc,
    }
  )
end

local function set_eslint_keymaps(bufnr)
  set_keymap({
    key = '<leader>fa',
    cmd = function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          diagnostics = {},
          only = { "source.fixAll" },
        }
      })
    end,
    desc = "Fix all ESLint issues",
    bufnr = bufnr,
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('eslint.lsp', { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    if client.name == "eslint" then
      set_eslint_keymaps(bufnr)
    end
  end
})

return {
  cmd = { utils.mason_path("vscode-eslint-language-server"), "--stdio" },
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  root_markers = {
    "eslint.config.js",
    ".eslintrc.json",
    "package.json",
    "tsconfig.json",
    ".git"
  },
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine"
      },
      showDocumentation = {
        enable = true
      }
    },
    codeActionOnSave = {
      enable = false,
      mode = "all"
    },
    experimental = {
      useFlatConfig = false
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    problems = {
      shortenToSingleLine = false
    },
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = { mode = "location" },
    workspaceFolder = utils.get_workspace_folder(),
  }
}
