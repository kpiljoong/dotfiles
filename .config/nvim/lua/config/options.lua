-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opt = vim.opt

-- Line wrapping
opt.wrap = true

-- Search options
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true

opt.signcolumn = 'yes'

-- Backspace
opt.backspace = 'indent,eol,start'

-- Clipboard
-- opt.clipboard:append("unnamedplus")

-- Split windows-- Split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")
