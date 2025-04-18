return   {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      -- Coc.nvim configuration
      vim.g.coc_global_extensions = {
        'coc-pyright',  -- Python language server
        'coc-tsserver', -- JavaScript/TypeScript
        'coc-eslint',   -- ESLint integration
        'coc-json',     -- JSON support
      }

      -- Map Tab to select the completion item
      vim.cmd [[
        " Use <Tab> to confirm the completion
        inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-y>"
        " Use <S-Tab> to move to the previous item
        inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"       
        inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      ]]
    end
  }
