return {
  {
    "j-hui/fidget.nvim",
    ft = { "rust", "lua" },
    config = function()
      require("fidget").setup()
    end,
  }
}
