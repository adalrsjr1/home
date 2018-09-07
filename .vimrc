" https://dougblack.io/words/a-good-vimrc.html

set encoding=utf8               " set enconding to utf-8
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
colorscheme pablo
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
syntax on                       " turn syntax highlighting on by default
set nu
set smartindent
set autoindent
set tw=70
"set formatoptions-=t            " avoid wrap line while writing
set noswapfile
set nobackup

" highlight cursor
set cursorline
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorLine cterm=bold "ctermbg=darkgray ctermbg=darkgray guibg=darkgray guifg=darkgray
" \c to locate the cursor
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" replacing tabs for spaces
set tabstop=2
set sw=2
set expandtab
set softtabstop=2
set shiftwidth=2

" enable folding za
set foldenable
set foldlevelstart=99
set foldmethod=indent
set foldnestmax=10
set foldlevel=99

" splitting
set splitright
set splitbelow

" spell checking
set complete+=kspell
autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us
"autocmd BufNewFile,BufRead *.md, *.mkd, *.markdown set spell spelllang=en_us
"autocmd BufNewFile,BufRead *.tex, set syntax spell toplevel spelllang=en_us
autocmd FileType tex set spell spelllang=en_us

highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

set spellfile=~/.vim/spellfile.add

" python configuration
au BufNewFile,BufRead *.py
    \ set tabstop=4        |
    \ set softtabstop=4    |
    \ set shiftwidth=4     |
    \ set textwidth=79     |
    \ set expandtab        |
    \ set autoindent       |
    \ set fileformat=unix  |
    \ set formatoptions-=t |


" make configuration
au BufNewFile,BufRead Makefile
    \ set tabstop=4        |
    \ set noexpandtab      |
    \ set shiftwidth=4     |
    \ set autoindent       |
    \ set fileformat=unix  |
    \ set formatoptions-=t |

" html configuration
au BufNewFile,BufRead *.html
    \ set formatoptions-=t |
    \ set fileformat=unix  |
    \ map <F2> :0r ~/.vimsnippets/html  <CR> | " http://vim.wikia.com/wiki/Insert_a_file

" highlight bad whitespaces
highlight BadWhitespace ctermbg=red guibg=red
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$\| \+\ze\t/
au BufRead,BufNewFile *.* match BadWhitespace /\s\+$\| \+\ze\t/
au Syntax * syn match BadWhitespace /\s\+$\| \+\ze\t/

" move through splits
nnoremap <leader>j <C-w>j
nnoremap <leader>l <C-w>l
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h

" resize splits
nnoremap <silent> <C-j> <C-W>-
nnoremap <silent> <C-k> <C-W>+
nnoremap <silent> <C-h> <C-W>>
nnoremap <silent> <C-l> <C-W><

" swap splits
nnoremap <leader>J <C-w>J
nnoremap <leader>L <C-w>L
nnoremap <leader>K <C-w>K
nnoremap <leader>H <C-w>H

" cycle through buffers
nnoremap <leader>n :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <leader>p :bprevious<CR>:redraw<CR>:ls<CR>

" mapping make key
nnoremap <leader>m :w<CR>:make<CR>

" mapping vertical split
nnoremap <leader>" :vsp<Space>

" mapping horizontal split
nnoremap <leader>% :sp<Space>

" https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
" mapping clipboard copy/paste
" first check it vim supports clipboard
"   :echo has('clipboard')
" if 0, install vim-gnome or vim-gtk
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>Y "*y
nnoremap <leader>P "*p


" open explorer
nnoremap <leader><TAB> :Texplore<CR>
nnoremap <leader>e :Vexplore<CR>
nnoremap <leader>E :Hexplore<CR>
" close tab
nnoremap <leader>q :q<CR>

" save tab
nnoremap <leader>s :w<CR>

" http://ctrlpvim.github.io/ctrlp.vim/#installation
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1 " show hidden files
let g:ctrlp_root_markers = ['pom.xml']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pdf|png|jpg|jpeg|zip|bz2|gz|jar|rar|7z)$',
  \ }
