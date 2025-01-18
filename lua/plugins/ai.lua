return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "saghen/blink.cmp",
      lazy = false,
      version = "*",
      opts = {
        sources = {
          default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
          cmdline = {},
        },
      },
    },
  },
  opts = {
    strategies = {
      chat = {
        adapter = "openai",
        keymaps = {
          close = {
            modes = { n = "q", i = "<C-q>" },
          },
        },
      },
      inline = {
        adapter = "openai",
      },
    },
    display = {
      chat = {
        diff = {
          enabled = true,
        },
      },
    },
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat<cr>", desc = "Open Chat 🪄" },
    { "<leader>ae", "<cmd>'<,'>CodeCompanion /buffer<cr>", desc = "Edit Selected 🪄", mode = "v" },
    { "<leader>ap", "<cmd>CodeCompanionActions<cr>", desc = "Action Plates 🪄" },
  },
}
