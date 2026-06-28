-- ==============================================================================
-- Language Server Protocol (LSP) Config for Ruby on Rails, Solargraph & TailWind
-- ==============================================================================

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          enabled = true,
        },
        solargraph = {
          enabled = true,
          settings = {
            solargraph = {
              diagnostics = true,
              completion = true,
              folding = true,
            }
          }
        },
        tailwindcss = {
          filetypes = { "html", "erb", "ruby", "javascript", "css" },
        },
        dockerls = {},
        sqlls = {},
        bashls = {},
      },
    },
  },
}