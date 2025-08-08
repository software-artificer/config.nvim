local M = {}

local extmark_ns = nil
local debounce_timer = nil
local extmark_update_pending = nil
local lsp_request_pending = nil
local autocmd_group = nil
local lsp_util = nil

local function delete_extmark(bufnr)
  if vim.b[bufnr].lightbulb.extmark_id ~= nil then
    vim.api.nvim_buf_del_extmark(
      bufnr,
      extmark_ns,
      vim.b[bufnr].lightbulb.extmark_id
    )
  end
end

local function update_extmark(bufnr, lnum)
  if extmark_update_pending then
    return
  end

  extmark_update_pending = true

  if vim.b[bufnr] == nil then
    extmark_update_pending = false

    return
  end

  if lnum == nil then
    vim.F.npcall(delete_extmark, bufnr)

    extmark_update_pending = false

    return
  end

  local extmark_id = vim.api.nvim_buf_set_extmark(bufnr, extmark_ns, lnum, 0, {
    id = vim.b[bufnr].lightbulb.extmark_id,
    virt_text_pos = 'overlay',
    virt_text_win_col = -1,
    virt_text = { { '', 'LightbulbHl' } },
    hl_mode = 'combine',
  })

  vim.b[bufnr].lightbulb = { extmark_id = extmark_id }

  extmark_update_pending = false
end

local function make_lsp_response_handler(bufnr, lnum)
  return function(resp)
    lsp_request_pending = nil

    for client_id, res in next, resp do
      if res.result and #res.result > 0 then
        update_extmark(bufnr, lnum)

        return
      end
    end
  end
end

local function check_code_actions(bufnr)
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

  local params = lsp_util.make_range_params(0, 'utf-8')
  params.context = {
    diagnostics = vim.lsp.diagnostic.from(
      vim.diagnostic.get(bufnr, { lnum = lnum })
    ),
  }

  lsp_request_pending = vim.F.npcall(
    vim.lsp.buf_request_all,
    bufnr,
    'textDocument/codeAction',
    params,
    make_lsp_response_handler(bufnr, lnum)
  )
end

local function cancel_inflight_operations(event)
  debounce_timer:stop()

  vim.schedule_wrap(update_extmark)(event.buf, nil)

  if lsp_request_pending then
    pcall(lsp_request_pending)

    lsp_request_pending = nil
  end
end

M.setup = function(opts)
  extmark_ns = vim.api.nvim_create_namespace('lightbulb')
  debounce_timer = vim.uv.new_timer()
  autocmd_group =
    vim.api.nvim_create_augroup('LightbulbHandlers', { clear = true })
  lsp_util = require('vim.lsp.util')
end

M.attach = function(bufnr)
  if vim.b[bufnr].lightbulb ~= nil then
    return
  end

  vim.b[bufnr].lightbulb = {}

  vim.api.nvim_create_autocmd({ 'InsertLeave', 'CursorMoved' }, {
    callback = function(event)
      cancel_inflight_operations(event)

      debounce_timer:start(300, 0, function()
        vim.schedule_wrap(check_code_actions)(event.buf)
      end)
    end,
    buffer = bufnr,
    desc = 'Schedule an update to the lightbulb indicator',
    group = 'LightbulbHandlers',
  })

  vim.api.nvim_create_autocmd({ 'BufLeave', 'InsertEnter' }, {
    callback = cancel_inflight_operations,
    buffer = bufnr,
    desc = 'Cancel any pending lightbulb updates',
    group = 'LightbulbHandlers',
  })
end

return M
