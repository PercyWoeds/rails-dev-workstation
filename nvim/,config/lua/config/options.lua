-- ==============================================================================
-- Global Neovim Options & Editor Behavior
-- ==============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 200