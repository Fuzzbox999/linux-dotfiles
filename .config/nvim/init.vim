" vnoremap <C-c> "*y :let @+=@*<CR>
" map <C-v> "+P
" from https://www.youtube.com/watch?v=XA2WjJbmmoM
" Use find, and Ctrl n and Ctrl f for autocompletion

" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

set path+=**
set path+=.config/**
set path+=.cache/suckless/**
set path+=.local/bin/**
set wildmenu
set hlsearch
set smarttab
set showcmd
" set termguicolors
set formatoptions+=c
set formatoptions+=q
set clipboard+=unnamedplus
set completeopt=menuone,longest
"setlocal spell spelllang=fr
"set complete+=kspell

" file browser using edit
let g:netrw_liststyle=3

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

" syntax on

" execute the current line of text as a shell command
" noremap  Q !!$SHELL<CR>

" Command-line mode mapping for alt-v
" Replace the command-line with the text beneath the cursor in the buffer
" cnoremap <Esc>q <C-\>esubstitute(getline('.'), '^\s*\(' . escape(substitute(&commentstring, '%s.*$', '', ''), '*') . '\)*\s*:*' , '', '')<CR>
" cnoremap <Esc>v <C-\>esubstitute(getline('.'), '^\s*\(' . escape(substitute(&commentstring, '%s.*$', '', ''), '*') . '\)*\s*:*' , '', '')<CR>

" Use <C-L> to clear search highlighting and redraw the screen
noremap  <silent> <C-l>      :nohlsearch <bar> redraw!<CR>
inoremap <silent> <C-l> <C-O>:nohlsearch <bar> redraw!<CR>

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

   Plug 'nvim-lua/popup.nvim'
   Plug 'nvim-lua/plenary.nvim'
   Plug 'nvim-telescope/telescope.nvim'

   " We recommend updating the parsers on update
   Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
   
   " Colorizer
"   Plug 'norcalli/nvim-colorizer.lua'

   Plug 'dylanaraps/wal.vim'

   function! Chomp(str)
   return substitute(a:str, '\n$', '', '')
endfunction

   " Initialize plugin system
call plug#end()

" lua require'colorizer'.setup()

colorscheme wal

" set cursorcolumn
" set cursorline
" hi CursorLine term=bold cterm=bold
" :hi CursorLine cterm=underline term=underline ctermbg=NONE guibg=NONE
" :au Colorscheme * :hi CursorLine cterm=underline term=underline ctermbg=NONE guibg=NONE

