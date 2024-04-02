local M = {}

M.exec_get_string = function(cmd)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

M.is_success = function(cmd)
  local _, code, _ = os.execute(cmd .. " > /dev/null 2>&1")
  return code == 0
end

M.checkhealth = function()
  local binary = false
  local health = false
  local ok = M.is_success("which lazyworktree")
  if ok then
    binary = true
  end

  local health = M.is_success("lazyworktree api health")

  if health then
    health = true
  end
  return binary, health
end

M.list_worktrees = function()
  local res = M.exec_get_string("lazyworktree api list")
  local json = vim.fn.json_decode(res)
  local worktrees = {}

  for _, v in pairs(json) do
    table.insert(worktrees, v)
  end

  return worktrees
end

M.api_switch = function(worktree)
  M.exec_get_string("lazyworktree api switch" .. " " .. worktree.value.path)
  vim.api.nvim_set_current_dir(worktree.value.path)
  vim.notify("Switched to " .. worktree.value.baseName)
end

M.load_telescope = function()
  local action_state = require "telescope.actions.state"
  local actions = require "telescope.actions"
  local dropdown = require("telescope.themes").get_dropdown {}
  local finders = require "telescope.finders"
  local pickers = require "telescope.pickers"
  return action_state, actions, dropdown, finders, pickers
end

M.switch = function()
  local binary, is_worktree = M.checkhealth()

  if not binary then
    vim.notify("lazyworktree binary not found")
    return
  end

  if not is_worktree then
    vim.notify("lazyworktree api not found")
    return
  end

  local action_state, actions, dropdown, finders, pickers = M.load_telescope()

  pickers.new(dropdown, {
    prompt_title = "Switch to Worktree",
    finder = finders.new_table {
      results = M.list_worktrees(),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.baseName,
          ordinal = entry.baseName,
        }
      end
    },
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        M.api_switch(action_state.get_selected_entry())
      end)
      return true
    end,
  }):find()
end

return M;
