" vim configuration
" Terje Runde <terje.runde@gmail.com>

" ui
syntax on
set nu
set ruler
set wildmenu
colorscheme black_angus
set mouse=a
set scrolloff=3

" get indenting right
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent
set cinoptions=>1s
filetype plugin indent on

set pastetoggle=<F10>

" ignore case in searches
set ignorecase

set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-8859-1

" let's use hjkl, shall we?
map <Left> :echo 'damnit!'<cr>
map <Right> :echo 'you suck!'<cr>
map <Up> :echo 'this is why you fail'<cr>
map <Down> :echo 'nooooo!'<cr>

" resize
nmap <c-w>l :vertical res +20<cr>
nmap <c-w>h :vertical res -20<cr>
nmap <c-w>j :res +20<cr>
nmap <c-w>k :res -20<cr>

" ignore patterns for CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc
nmap <F12> :make!<cr>

set hlsearch
highlight Search ctermbg=LightBlue

" trailing whitespace is evil
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

au BufRead,BufNewFile *.txt,*.tex set tw=80 nocindent
