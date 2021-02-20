" vnoremap <C-c> "*y :let @+=@*<CR>
" map <C-v> "+P
" from https://www.youtube.com/watch?v=XA2WjJbmmoM
" Use find, and Ctrl n and Ctrl f for autocompletion
set path+=**
set path+=.config/**
set path+=.suckless/**
set path+=.local/bin/**
set wildmenu
" file browser using edit
let g:netrw_liststyle=3
" noremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a
" http://philipbradley.net/rspec-into-vim-with-quickfix
" set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter
" :make runs RSpec :cl lists errors :cc# jump to error by number :cn and :cp
" to navigate forward and back
" end

augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:hor20-blinkon1
augroup END

set undofile
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>
:set nu
:set rnu
:set scrolloff=999

let g:airline_powerline_fonts = 1

" air-line
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

call plug#begin('~/.vim/plugged')

   " Make sure you use single quotes

   " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
   Plug 'junegunn/vim-easy-align'

   " Any valid git URL is allowed
   Plug 'https://github.com/junegunn/vim-github-dashboard.git'

   " Multiple Plug commands can be written in a single line using | separators
   Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

   " On-demand loading
   Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
   Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

   " Using a non-master branch
   Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

   " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
   Plug 'fatih/vim-go', { 'tag': '*' }

   " Plugin options
   Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

   " Plugin outside ~/.vim/plugged with post-update hook
   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

   " Unmanaged plugin (manually installed and updated)
   Plug '~/my-prototype-plugin'

function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

   " Initialize plugin system
call plug#end()

   " Using plug

Plug 'dylanaraps/wal.vim'

colorscheme wal

" set cursorcolumn
set cursorline
