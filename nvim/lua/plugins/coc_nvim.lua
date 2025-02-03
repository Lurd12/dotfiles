return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    build = "yarn install --frozen-lockfile", -- Instala las dependencias de coc.nvim
    config = function()
      -- Configuración básica de coc.nvim
      vim.g.coc_global_extensions = {
        'coc-tsserver',  -- Soporte para TypeScript/JavaScript
        'coc-pyright',   -- Soporte para Python
        'coc-json',      -- Soporte para JSON
        'coc-rust-analyzer', -- Soporte para Rust
      }

      -- Atajos de teclado personalizados
      vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'K', ':call CocActionAsync("doHover")<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', { noremap = true, silent = true })
    end,
  },
}
