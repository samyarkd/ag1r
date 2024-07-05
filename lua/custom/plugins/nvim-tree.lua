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

    update_cwd = true,

    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
  },
}
