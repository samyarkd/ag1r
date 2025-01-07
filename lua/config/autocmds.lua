-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Run on buffer attach (a new buffer is opened)
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("BufAttachGroup"),
  pattern = "*",
  callback = function()
    -- run a command on when buffer entered
  end,
})
