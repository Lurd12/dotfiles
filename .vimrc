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
call plug#begin('~/.config/nvim/plugged')

packadd! doki-theme


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
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Autocomen
Plug 'preservim/nerdcommenter'

call plug#end()



colorscheme aura-dark 
"Nerdtree
let NERDTreeQuitOnOpen=1


"Atajos de teclado
let mapleader=" "

"easymotion
nmap <leader>s <Plug>(easymotion-s2)

"nerdtree
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
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"Show documentation
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


"Open terminal
map <S-t> :vert :term<CR>
