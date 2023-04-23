local lsp = require("lsp-zero")
local cmp = require("cmp")
local lspkind = require("lspkind")
lsp.preset("recommended")

lsp.ensure_installed({
  "bashls",
  "cssls",
  "dockerls",
  "emmet_ls",
  "gopls",
  "html",
  "intelephense",
  "jsonls",
  "pyright",
  "tailwindcss",
  "theme_check",
  "tsserver",
  "vimls",
  "yamlls",
})

lsp.nvim_workspace()

lsp.setup()

cmp.setup({
  window = {
    completion = {
      col_offset = -3, -- align the abbr and word on cursor (due to fields order below)
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      before = function(entry, vim_item) -- for tailwind css autocomplete
        if vim_item.kind == "Color" and entry.completion_item.documentation then
          local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
          if r then
            local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
            local group = "Tw_" .. color
            if vim.fn.hlID(group) < 1 then
              vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
            end
            vim_item.kind = "■" -- or "⬤" or anything
            vim_item.kind_hl_group = group
            return vim_item
          end
        end
        -- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
        -- or just show the icon
        vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
        return vim_item
      end,
    }),
  },
})

vim.diagnostic.config({ virtual_text = true })
