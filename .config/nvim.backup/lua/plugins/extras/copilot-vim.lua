return {
  {
    "nvim-cmp",
    opts = function(_, opts)
      opts.experimental.ghost_text = false
    end,
    keys = function()
      return {}
    end,
  },
  {
    "github/copilot.vim",
    --event = "VeryLazy",
    config = function()
      vim.g.copilot_filetypes = {
        ["TelescopePrompt"] = false,
      }
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_workspace_folders = "~/workspace"

      local keymap = vim.keymap.set
      local opts = { silent = true }

      keymap("i", "<C-y>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })

      keymap("i", "<C-j>", "<Plug>(copilot-next)", opts)
      keymap("i", "<C-k>", "<Plug>(copilot-previous)", opts)
      keymap("i", "<C-l>", "<Plug>(copilot-suggest)", opts)

      keymap("i", "<C-d>", "<Plug>(copilot-dismiss)", opts)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local Util = require("lazyvim.util")
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local icon = require("lazyvim.config").icons.kinds.Copilot
          return icon
        end,
        cond = function()
          local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
          return ok and #clients > 0
        end,
        color = function()
          -- return Util.ui.fg("Special")
        end,
      })
    end,
  },
}
