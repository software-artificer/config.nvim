local function setupLightBulb()
  require('nvim-lightbulb').setup({
    sign = {
      enabled = true,
      text = '',
    },
    autocmd = { enabled = true },
  })
end

return {
  'kosayoda/nvim-lightbulb',
  version = '^1',
  config = setupLightBulb,
}
