-- local format_sync_grp = vim.api.nvim_create_augroup("GoImports", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   callback = function()
--     require("go.format").goimports()
--   end,
--   group = format_sync_grp,
-- })
--
-- vim.keymap.set("n", "<leader>i", ":GoImports<cr>", { silent = true })
--
-- return {
--   "ray-x/go.nvim",
--   dependencies = {
--     "ray-x/guihua.lua",
--     "neovim/nvim-lspconfig",
--     "nvim-treesitter/nvim-treesitter",
--   },
--   config = function()
--     require("go").setup()
--   end,
--   event = { "CmdlineEnter" },
--   ft = { "go", "gomod" },
--   build = ':lua require("go.install").update_all_sync()'
-- }
return {

}
