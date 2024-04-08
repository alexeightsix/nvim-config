local dap = require 'dap'
local dapui = require 'dapui'

vim.cmd [[
  autocmd FileType dapui* set statusline=\
  autocmd FileType dap-repl set statusline=\
]]

require('mason-nvim-dap').setup {
  automatic_setup = true,
  handlers = {},
  ensure_installed = {
    'delve',
  },
}

vim.keymap.set('n', '<F7>', dapui.toggle)
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F6>', dap.step_into)
vim.keymap.set('n', '<F7>', dap.step_over)
vim.keymap.set('n', '<F8>', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>bc', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end)

dapui.setup {
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}


dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

require('dap-go').setup()
