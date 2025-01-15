return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = true,
  opts = {
    strategies = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
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
