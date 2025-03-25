return {
  "mfussenegger/nvim-dap",
  event = "BufRead",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local virtual_text = require("nvim-dap-virtual-text")
    local dap_go = require("dap-go")

    dap.adapters.lldb = {
      type = "executable",
      command = "lldb-vscode",
      name = "lldb",
    }

    local lldb = {
      name = "Launch lldb",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTermal = false,
    }
    dap.configurations.rust = {
      lldb,
    }

    dapui.setup()
    virtual_text.setup()
    dap_go.setup()
  end,
}
