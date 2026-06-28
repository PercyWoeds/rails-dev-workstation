-- ==============================================================================
-- Rails Productivity Utilities (Oil, Gitsigns, Harpoon, Navigation)
-- ==============================================================================

return {
  -- Oil.nvim para edición de sistemas de archivos como buffers de texto plano
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      columns = { "icon", "permissions", "size" },
      view_options = { show_hidden = true },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Parent Directory" },
    },
  },
  -- Harpoon para marcas rápidas de navegación en Controladores/Modelos críticos
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon Mark File" })
      vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })
    end
  },
  -- Gitsigns para trazabilidad atómica de Git blame e inserciones dentro del buffer
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 500 },
    },
  },
}