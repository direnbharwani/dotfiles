return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      python = { 'ruff_format' },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  },
}
