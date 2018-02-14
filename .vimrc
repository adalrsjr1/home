set fileencoding=utf8           " set enconding to utf-8

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
set tw=70
set noswapfile

" highlight cursor
set cursorline
:hi CursorLine   cterm=bold ctermbg=black "ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" \c to locate the cursor
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" replacing tabs for spaces
set tabstop=2
set sw=2
set expandtab

" splitting
set splitright
set splitbelow

" spell checking
set complete+=kspell
autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us
"autocmd BufNewFile,BufRead *.md, *.mkd, *.markdown set spell spelllang=en_us
"autocmd BufNewFile,BufRead *.tex, set syntax spell toplevel spelllang=en_us
autocmd FileType tex set spell spelllang=en_us
autocmd BufNewFile,BufRead *.txt, *.md *.mkd, *.markdown set spell spelllang=en_us

highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

set spellfile=~/.vim/spellfile.add
