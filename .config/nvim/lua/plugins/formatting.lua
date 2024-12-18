return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    local prettier = { "prettierd", "prettier", stop_after_first = true }
    opts.formatters_by_ft = {
      go = { "goimports", "gofmt" },
    }
  end,
}
