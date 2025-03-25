return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  dependencies = {
    "zbirenbaum/copilot-cmp",
  },
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<c-a>",
          accept_word = false,
          accept_line = false,
          next = "<c-j>",
          prev = "<c-k>",
          dismiss = "<C-e>",
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_next = "<c-j>",
          jump_prev = "<c-k>",
          accept = "<c-a>",
          refresh = "r",
          open = "<M-CR>",
        },
        layout = {
          position = "bottom",
          ratio = 0.4,
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    })
  end,
}
