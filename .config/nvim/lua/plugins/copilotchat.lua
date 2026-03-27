return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      prompts = {
        Rename = {
          prompt = "Please rename the variable correctly in given selection based on context",
          selection = function(source)
            local select = require("CopilotChat.select")
            return select.visual(source)
          end,
        },
      },
    },
    keys = {
      {
        "<leader>zc",
        function()
          return require("CopilotChat").toggle()
        end,
        mode = { "n", "v" },
        desc = "[C]opilot [C]hat Toggle",
      },
      { "<leader>zc", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain Code" },
    },
  },
}
