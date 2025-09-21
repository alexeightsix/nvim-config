return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = {
      preset = 'none',
      ['<C-Up>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-Down>'] = { 'scroll_documentation_down', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-k>'] = {
        function(cmp)
          if cmp.is_menu_visible() then
            cmp.select_prev()
          else
            cmp.show()
          end
        end
      },
      ['<C-j>'] = {
        function(cmp)
          if cmp.is_menu_visible() then
            cmp.select_next()
          else
            cmp.show()
          end
        end
      },
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      ghost_text = {
        enabled = true
      }
    },
    sources = {
      default = { 'lsp', 'path', 'buffer' },
      -- Disable snippets
      transform_items = function(_, items)
        return vim.tbl_filter(function(item)
          return item.kind ~= require('blink.cmp.types').CompletionItemKind.Snippet
        end, items)
      end,
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
