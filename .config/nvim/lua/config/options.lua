-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.incsearch = true
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- If set to 0 it shows all the symbols in a file
vim.opt.conceallevel = 0

vim.opt.timeoutlen = 1000

vim.opt.wrap = true
vim.opt.colorcolumn = "80"

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.showtabline = 1
vim.opt.smartcase = true

vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.laststatus = 3

vim.opt.ruler = false
vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append({
  stl = " ",
})

vim.opt.shortmess:append("c")

vim.opt.guifont = "SauceCodePro Nerd Font:h12"

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
