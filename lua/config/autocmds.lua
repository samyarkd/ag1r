-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Remove unused imports on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("ts_imports"),
  pattern = { "*.tsx,*.ts" },
  callback = function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "quickfix" },
        diagnostics = {},
      },
    })
  end,
})
