return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = true,
  opts = {
    adapters = {
      groq = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = "GROQ_API_KEY",
          },
          name = "Groq",
          url = "https://api.groq.com/openai/v1/chat/completions",
          schema = {
            model = {
              default = "llama-3.3-70b-versatile",
              choices = {
                "llama-3.2-90b-text-preview",
                "llama-3.2-11b-text-preview",
                "mixtral-8x7b-32768",
                "llama-3.1-70b-versatile",
                "llama-3.3-70b-versatile",
              },
            },
          },
          max_tokens = {
            default = 6000,
          },
          temperature = {
            default = 0.3,
          },
          handlers = {
            form_messages = function(self, messages)
              for i, msg in ipairs(messages) do
                -- Remove 'id' and 'opts' properties from all messages
                msg.id = nil
                msg.opts = nil

                -- Ensure 'name' is a string if present, otherwise remove it
                if msg.name then
                  msg.name = tostring(msg.name)
                else
                  msg.name = nil
                end

                -- Ensure only supported properties are present
                local supported_props = { role = true, content = true, name = true }
                for prop in pairs(msg) do
                  if not supported_props[prop] then
                    msg[prop] = nil
                  end
                end
              end
              return { messages = messages }
            end,
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "groq",
      },
      inline = {
        adapter = "groq",
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
