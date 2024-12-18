-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
pcall(require, "config/usercmds")

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvimv_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNew" }, {
  pattern = { "*.ipf" },
  callback = function()
    vim.o.commentstring = "// %s"
  end,
})
