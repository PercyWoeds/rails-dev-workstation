-- ==============================================================================
-- Conform.nvim - Strict Code Formatter Configuration (RuboCop / StandardRB)
-- ==============================================================================

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ruby = { "rubocop" },
        erb = { "htmlbeautifier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        lua = { "stylua" },
        bash = { "shfmt" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    },
  },
}