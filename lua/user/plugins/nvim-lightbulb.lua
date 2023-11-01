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
  tag = 'v1.0.0',
  config = setupLightBulb,
}
