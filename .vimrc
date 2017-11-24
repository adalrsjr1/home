set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
"colorscheme pablo
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
syntax on                       " turn syntax highlighting on by default
set nu
set smartindent
set autoindent
set tw=80

" replacing tabs for spaces
set tabstop=2
set sw=2
set expandtab

" splitting
set splitright
set splitbelow

" spell checking
autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead *.md, *.mkd, *.markdown set spell spelllang=en_us
autocmd BufNewFile,BufRead *.tex, *.cls set spell spelllang=en_us
autocmd BufNewFile,BufRead *.txt set spell spelllang=en_us
