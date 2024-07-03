return {
  'nvim-tree/nvim-tree.lua',
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle Tree' },
  },
  opts = {
    git = {
      enable = true,
      ignore = false,
      timeout = 400,
    },
  },
}
