-- ==============================================================================
-- Treesitter - AST Syntax Highlighting for Rails Architecture
-- ==============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "ruby",
        "embedded_template", -- Soporte nativo ERB (.html.erb)
        "javascript",
        "typescript",
        "html",
        "css",
        "lua",
        "dockerfile",
        "yaml",
        "json",
        "sql",
        "bash",
        "markdown",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}