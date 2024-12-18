vim.api.nvim_create_user_command("LazyrcGenerate", function()
  local uv = vim.uv or vim.loop
  local lazyrc = vim.fn.stdpath("config") .. "/misc/.lazy.lua"
  local target = vim.fn.getcwd()

  if not target then
    LazyVim.error("Cannot read cwd", { title = "Generate .lazy.lua" })
  else
    target = target .. "/.lazy.lua"
  end

  local res = uv.fs_copyfile(lazyrc, target)

  if res then
    LazyVim.info("Copied `.lazy.lua` to " .. target, { title = "Generate .lazy.lua" })
  else
    LazyVim.error("Failed to copy `.lazy.lua` to " .. target, { title = "Generate .lazy.lua" })
  end
end, { desc = "generate .lazy.lua (overwrite)" })

return {}
