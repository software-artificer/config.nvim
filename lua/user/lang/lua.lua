local has_formatter = vim.fn.executable('stylua') == 1

local function setupFormatter()
  if not has_formatter then
    return
  end

  local none_ls = require('null-ls')
  none_ls.register(none_ls.builtins.formatting.stylua)
end

return {
  dependencies = function()
    return {}
  end,
  setup = function()
    setupFormatter()
  end,
}
