vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.bs",
  command = "set filetype=busan",
})
