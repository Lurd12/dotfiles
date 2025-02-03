set number 
set mouse=a 
set numberwidth=1
set clipboard=unnamed
syntax enable
set showcmd 
set ruler
set encoding=utf-8
set showmatch
set laststatus=2
set splitright
set clipboard+=unnamedplus 
set signcolumn=yes
call plug#begin('~/.config/nvim/plugged')



" Temas
Plug 'morhetz/gruvbox'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } 
Plug 'daltonmenezes/aura-theme', { 'rtp': 'packages/neovim' }
" IDE
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/indentLine' 


"Syntax
Plug 'scrooloose/nerdtree'

"Tree
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'

"
"Typing
Plug 'jiangmiao/auto-pairs'

"Autocomplete

Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Autocomen
Plug 'preservim/nerdcommenter'

"Transparences
Plug 'xiyaowong/transparent.nvim'

call plug#end()



colorscheme aura-dark 
"Nerdtree
let NERDTreeQuitOnOpen=1


"Atajos de teclado
let mapleader=" "

"easymotion
nmap <leader>s <Plug>(easymotion-s2)

"nerdtrenoree
nmap <leader>nt : NERDTreeFind<CR>

"Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"

"Resize
nnoremap <leader>> 10<C-w>>
nnoremap <leader>< 10<C-w><

"fast navigation
nnoremap <C-j> 10<C-e>
nnoremap <C-k> 10<C-y>

"CoC config"
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
nnoremap <leader>f :CocCommand editor.action.formatDocument<CR>  

"Open terminal
map <S-t> :vert :term<CR>



