local has_formatter = vim.fn.executable('stylua') == 1

local function setupFormatter()
  if not has_formatter then
    return
  end

  require('null-ls.sources').register(
    require('null-ls').builtins.formatting.stylua
  )
end

return {
  dependencies = function()
    return {}
  end,
  setup = function()
    setupFormatter()
  end,
}
