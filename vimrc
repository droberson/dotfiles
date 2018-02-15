" Daniel Roberson's .vimrc

" Fixes arrow keys
set t_ku=OA
set t_kd=OB
set t_kr=OC
set t_kl=OD

" Allows mouse usage in terminal
set mouse=a

" UTF8
set encoding=utf-8

" Use syntax highlighting 
syntax on
filetype on

" I think the desert theme is easier to read..
colorscheme desert

" Python stuff. Mostly ripped from:
"   https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile, *.py,*.pyw match BadWhitespace /\s\+$/

set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Lua stuff
au BufNewFile,BufRead *.nse,*.lua
    \ set syntax=lua |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab

" C stuff
au BufNewFile,BufRead *.c,*.h
    \ set syntax=c |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent

au BufRead,BufNewFile, *.c,*.h match BadWhitespace /\s\+$/
