-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", "<space>xW", function()
  local status, err = pcall(function()
    for _, client in ipairs(vim.lsp.get_clients()) do
      require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
    end
  end)
  if not status then
    vim.notify("Error in populate_workspace_diagnostics: " .. err, vim.log.levels.ERROR)
  end
end, {
  noremap = true,
  desc = "find all diagnostics",
})
