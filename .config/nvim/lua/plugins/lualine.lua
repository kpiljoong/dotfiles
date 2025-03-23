return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  enabled = true,
  dependencies = {
    "AndreM222/copilot-lualine",
  },
  config = function()
    require("lualine").setup({
      options = {
        icon_enabled = true,
        theme = "auto",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
        },
        lualine_c = { "filename" },
        lualine_x = { "copilot", "encoding", "fileformat", "filetype" },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        -- Disable lualine_z section which shows the time
        lualine_z = {},
      },
      extensions = { "lazy", "fzf" },
    })
  end,
}
