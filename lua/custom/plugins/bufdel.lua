return {
  'famiu/bufdelete.nvim',
  opts = {},
  keys = {
    { '<leader>x', '<cmd>bdelete<cr>', desc = 'Close Current Buffer' },
    { ':q<CR>', '<cmd>bdelete<cr>', desc = 'Close Current Buffer' },
  },
  config = function()
    -- Override :q to close the buffer instead of exiting Neovim
    vim.cmd [[
      command! -nargs=0 Q silent! Bdelete
    ]]

    -- Ensure that :q works as expected
    vim.cmd [[
      autocmd BufEnter * if winnr('$') == 1 && &filetype == 'NvimTree' | quit | endif
    ]]
  end,
}
