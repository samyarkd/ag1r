-- bootstrap lazy.nvim, LazyVim and your plugins require("config.lazy")
require("config.lazy")

-- Enable spell check
vim.cmd("set spell")
vim.cmd("colorscheme terafox")

vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#5D5F71", bg = "#282c31" })
