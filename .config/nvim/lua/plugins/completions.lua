local IS_DEV = false

local prompts = {
  Explain = "Please explain how the following code works.",
}

return {
  { import = "plugins.extras.copilot-vim" },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
        { "gm", group = "+Copilot chat" },
        { "gmh", desc = "Show help" },
      },
    },
  },

  --  {
  --    "CopilotC-Nvim/CopilotChat.nvim",
  --    -- branch = "main",
  --    dependencies = {
  --      { "github/copilot.vim" },
  --      { "nvim-telescope/telescope.nvim" },
  --      { "nvim-lua/plenary.nvim" },
  --    },
  --    opts = {
  --      question_header = "## User ",
  --      answer_header = "## Copilot ",
  --      error_header = "## Error ",
  --      prompt = prompts,
  --      auto_follow_cursor = false,
  --      show_help = false,
  --      mappings = {
  --        complete = {
  --          detail = "Use @<Tab> or /<Tab> for options",
  --          insert = "<Tab>",
  --        },
  --      },
  --    },
  --    config = function(_, opts)
  --      local chat = require("CopilotChat")
  --      local select = require("CopilotChat.select")
  --      opts.selection = select.unnamed
  --
  --      chat.setup(opts)
  --      require("CopilotChat.integrations.cmp").setup()
  --
  --      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
  --        chat.ask(args.args, { selection = select.visual })
  --      end, { nargs = "*", range = true })
  --    end,
  --    event = "VeryLazy",
  --    keys = {
  --      {
  --        "<leader>ah",
  --        function()
  --          local actions = require("CopilotChat.actions")
  --          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
  --        end,
  --      },
  --    },
  --  },
}
