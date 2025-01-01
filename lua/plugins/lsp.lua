local opts = {
  inlay_hints = { enabled = false },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = opts,
    dependencies = {
      { "hrsh7th/cmp-cmdline" },
    },
  },
}
