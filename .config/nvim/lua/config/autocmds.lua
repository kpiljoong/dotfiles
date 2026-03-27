-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
local format_group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  pattern = "*.go",
  callback = function()
    -- Run goimports shell command directly
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local input = table.concat(lines, "\n")

    local output = vim.fn.system("goimports", input)

    if vim.v.shell_error == 0 then
      local new_lines = vim.split(output, "\n", { plain = true })
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
    else
      vim.notify("goimports failed: " .. output, vim.log.levels.ERROR)
    end
    -- local pos = vim.api.nvim_win_get_cursor(0)

    -- vim.cmd([[%!goimports]])

    -- pcall(vim.api.nvim_win_set_cursor, 0, pos)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.ts", "*.tsx" },
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end,
})

vim.diagnostic.config({
  virtual_text = {
    wrap = true,
    spacing = 2,
    prefix = "●",
  },
})

require("neo-tree").setup({
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dir_open = false,
    },
    hijack_new_files = "open_default",
  },
})
