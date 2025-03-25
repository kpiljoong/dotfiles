return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "leoluz/nvim-dap-go",
      "hrsh7th/nvim-cmp",
      -- { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.notify = require("notify")

      require("go").setup({
        capabilities = capabilities,
        lsp_cfg = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
            },
          },
        },
      })
    end,
  },
}
