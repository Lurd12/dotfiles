
require("config.lazy")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.cmd [[
  hi Normal guibg=none ctermbg=none
  hi NormalFloat guibg=none ctermbg=none
]]
