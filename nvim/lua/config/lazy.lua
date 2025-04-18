-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})




--Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n','<leader>tt', builtin.find_files, {desc = 'Telescope find files'})

--Neotree keymaps
vim.keymap.set('n','<leader>nt', ':Neotree<CR>', {desc = 'Telescope find files'})

vim.keymap.set("n", "<C-h>", "<Cmd>SmartCursorMoveLeft<CR>")
vim.keymap.set("n", "<C-l>", "<Cmd>SmartCursorMoveRight<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>SmartCursorMoveUp<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>SmartCursorMoveDown<CR>")


--ToggleTerm
vim.keymap.set("n", "<leader>q", ":ToggleTerm size=10<CR>")

vim.opt.number = true
vim.opt.relativenumber = true


--Colorscheme
vim.cmd.colorscheme "maple_dark"


--Lua line 
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {
      '%=', --[[ add your center compoentnts here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}



-- Define que cada tab equivale a 4 espacios
vim.opt.tabstop = 4

-- Define que la indentación usa 4 espacios
vim.opt.shiftwidth = 4

-- Convierte los tabuladores en espacios
vim.opt.expandtab = true

--portapapeles
vim.opt.clipboard = 'unnamedplus'

--git colors

  vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitSignsAdd' })
  vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitSignsChange' })
  vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitSignsChange' })
  vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitSignsDelete' })
  vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitSignsDelete' })



