-- ==============================================================================
-- CodeCompanion.nvim - AI Orchestration for Ollama DeepSeek / Qwen Models
-- ==============================================================================

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "folke/edgy.nvim", optional = true },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
        },
        agent = {
          adapter = "ollama",
        },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = {
              url = "http://127.0.0.1:11434",
            },
            schema = {
              model = {
                default = "qwen2.5-coder:7b", -- Opciones recomendadas: deepseek-coder:6.7b, llama3
              },
              num_ctx = {
                default = 16384,
              },
            },
          })
        end,
      },
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions Menu" },
      { "<leader>at", "<cmd>CodeCompanionToggle<cr>", mode = { "n", "v" }, desc = "Toggle AI Chat Window" },
      { "<leader>ae", "<cmd>CodeCompanionEvaluate<cr>", mode = { "v" }, desc = "Evaluate Code Block" },
    },
  },
}