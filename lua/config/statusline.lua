local navic = require("nvim-navic")

require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = { '' },
    lualine_b = {},
    lualine_c = { 'location', 'diagnostics', { 'filename', path = 2,
      fmt = function(name)
        local git_root = vim.fs.root(0, '.git')
        if git_root then
          local buf_path = vim.fn.expand('%:p')
          if buf_path:sub(1, #git_root) == git_root then
            local root_name = vim.fn.fnamemodify(git_root, ':t')
            return root_name .. buf_path:sub(#git_root + 1)
          end
        end
        return name
      end,
    }, {
      function()
        return navic.get_location()
      end,
      cond = function()
        return navic.is_available()
      end
    },

    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { '' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
