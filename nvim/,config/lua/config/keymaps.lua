-- ==============================================================================
-- Custom Core Keymaps (Vim-Style Enhanced Navigation)
-- ==============================================================================

local map = vim.keymap.set

-- Navegación fluida entre ventanas integrando Tmux splits
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Window Left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Window Down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Window Up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Window Right" })

-- Manipulación e identación de bloques visuales manteniendo selección
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- Mover líneas arriba/abajo en modo visual respetando contexto
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Line Down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Line Up" })

-- Atajos rápidos de guardado y salida
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })