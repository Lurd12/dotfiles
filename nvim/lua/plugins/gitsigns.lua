return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",  -- Load the plugin when a buffer is read
  config = function()
    require('gitsigns').setup({
      signs = {
        add = { hl = 'GitSignsAdd', text = '+' },
        change = { hl = 'GitSignsChange', text = '~' },
        delete = { hl = 'GitSignsDelete', text = '_' },
        topdelete = { hl = 'GitSignsDelete', text = '‾' },
        changedelete = { hl = 'GitSignsChange', text = '~' },
      },
    })
  end,
}
