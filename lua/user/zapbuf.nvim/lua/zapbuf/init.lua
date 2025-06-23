local M = {}

function M.setup(opts) end

local function get_buf_name(buf_id)
  local name = vim.api.nvim_buf_get_name(buf_id)

  if name ~= '' then
    return name
  end

  return '[No Name]'
end

local Action = {
  WRITE = 1,
  DISCARD = 2,
  ABORT = 3,
}

local function handle_buf_modified(buf_id)
  if vim.api.nvim_get_option_value('modified', { buf = buf_id }) then
    local prompt = string.format(
      'Buffer (%d) "%s" is modified. Do you want to save it?',
      buf_id,
      get_buf_name(buf_id)
    )

    local choice = vim.fn.confirm(prompt, '&Yes\n&No\n&Cancel', '3', 'Q')

    if choice == 1 then
      return Action.WRITE
    end

    if choice == 2 then
      return Action.DISCARD
    end

    return Action.ABORT
  end

  return Action.DISCARD
end

local function close_tab()
  local win_ids = vim.api.nvim_tabpage_list_wins(0)

  for _, win_id in next, win_ids do
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local buf_wins = vim.fn.win_findbuf(buf_id)

    if #buf_wins == 1 then
      local action = handle_buf_modified(buf_id)

      if action == Action.ABORT then
        return
      end

      local force = false
      if action == Action.DISCARD then
        force = true
      end

      if action == Action.WRITE then
        vim.api.nvim_buf_call(buf_id, vim.cmd.write)
      end

      vim.api.nvim_buf_delete(buf_id, { force = force })
    else
      vim.api.nvim_win_close(win_id, {})
    end
  end
end

function M.zap()
  local tabs = vim.api.nvim_list_tabpages()
  if #tabs > 1 then
    close_tab()
  end

  if vim.wo.diff then
    for _, win_id in next, vim.api.nvim_list_wins() do
      local buf_id = vim.api.nvim_win_get_buf(win_id)
      local buf_type = vim.api.nvim_buf_get_option(buf_id, 'buftype')

      if buf_type == 'acwrite' then
        vim.api.nvim_win_close(win_id, {})
      end
    end

    return
  end

  local curr_win_id = vim.api.nvim_get_current_win()
  local curr_win_conf = vim.api.nvim_win_get_config(curr_win_id)
  local is_relative_window = curr_win_conf.relative ~= ''
  local is_help_buffer = vim.bo.buftype == 'help'
  if is_relative_window or is_help_buffer then
    vim.api.nvim_win_close(curr_win_id, {})

    return
  end

  local curr_buf_id = vim.api.nvim_get_current_buf()
  local curr_buf_wins = vim.fn.win_findbuf(curr_buf_id)

  local force = false
  if #curr_buf_wins == 1 then
    local action = handle_buf_modified(curr_buf_id)

    if action == Action.ABORT then
      return
    end

    if action == Action.WRITE then
      vim.api.nvim_buf_call(curr_buf_id, vim.cmd.write)
    end

    if action == Action.DISCARD then
      force = true
    end
  end

  local listed_bufs = vim.fn.getbufinfo({ buflisted = 1 })
  table.sort(listed_bufs, function(a, b)
    return (a.lastused or 0) > (b.lastused or 0)
  end)
  local next_buf_id = nil
  for _, buf in next, listed_bufs do
    if buf.bufnr ~= curr_buf_id and #buf.windows == 0 then
      next_buf_id = buf.bufnr
      break
    end
  end

  if next_buf_id == nil then
    next_buf_id = vim.api.nvim_create_buf(false, false)
  end

  vim.api.nvim_win_set_buf(curr_win_id, next_buf_id)

  if #curr_buf_wins == 1 then
    pcall(function()
      vim.api.nvim_buf_delete(curr_buf_id, { force = force })
    end)
  end
end

return M
