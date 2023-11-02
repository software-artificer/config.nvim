vim.keymap.set(
  'n',
  '<leader>q',
  vim.cmd.bwipeout,
  { desc = 'Close current buffer' }
)
vim.keymap.set(
  'n',
  '<leader>d',
  vim.diagnostic.open_float,
  { desc = 'Show [d]iagnostic popup' }
)
vim.keymap.set(
  'n',
  ']d',
  vim.diagnostic.goto_next,
  { desc = 'Go to next [d]iagnostic message' }
)
vim.keymap.set(
  'n',
  '[d',
  vim.diagnostic.goto_prev,
  { desc = 'Go to previous [d]iagnostic message' }
)
vim.keymap.set(
  'n',
  '<leader>F',
  vim.lsp.buf.format,
  { desc = '[F]ormat document using LSP' }
)
