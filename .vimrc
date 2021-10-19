"
" https://github.com/junegunn/vim-plug
"
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
"call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
"Plug 'rhysd/vim-grammarous'

" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
"
" " Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
" " Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
" " Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
"
" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Initialize plugin system
"call plug#end()

" Grammarous Plugin Customization
" https://github.com/rhysd/vim-grammarous
" nnoremap <leader>g :GrammarousCheck<CR>
" let g:grammarous#hooks = {}
" function! g:grammarous#hooks.on_check(errs) abort
"     nmap <buffer><leader><Right>  <Plug>(grammarous-move-to-next-error)
"     nmap <buffer><leader><Left>   <Plug>(grammarous-move-to-previous-error)
"     nmap <buffer><leader><Down>   <Plug>(grammarous-fixit) \| <Plug>(grammarous-close-info-window)<CR>
"     nmap <buffer><leader><Up>     <Plug>(grammarous-close-info-window)<CR>
"
" endfunction
"
" function! g:grammarous#hooks.on_reset(errs) abort
"     nunmap <buffer><leader><Right>
"     nunmap <buffer><leader><Left>
"     nunmap <buffer><leader><Up>
"     nunmap <buffer><leader><Down>
" endfunction

set nohlsearch                  " stop highlight all searches
set encoding=utf8               " set enconding to utf-8
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
"colorscheme pablo " moonscape
set t_Co=16                     " set vim to terminal's 16-colors
set showmode                    " show the current mode
syntax on                       " turn syntax highlighting on by default
set nu
set smartindent
set autoindent
set tw=80
set formatoptions-=t            " avoid wrap line while writing
set noswapfile
set nobackup
set fileformat=unix

" remap esc
inoremap jk <Esc>
" Note: In command mode mappings to esc run the command for some odd
" historical vi compatibility reason. We use the alternate method of
" existing which is Ctrl-C
cnoremap jk <Esc> <C-C>
" timeout between keystrokes
set timeoutlen=1000 ttimeoutlen=0


" visual selection color
:hi Visual cterm=underline,bold ctermbg=None

" highlight cursor
set cursorline
:hi CursorColumn cterm=reverse,bold " ctermbg=darkred ctermfg=None guibg=darkred guifg=white
:hi CursorLine cterm=bold

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

" wrapping and unwrapping paragraphs
nnoremap <Leader>w gqip
nnoremap <Leader>W vipJ

" spell checking
set complete+=kspell
autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead *.mkd setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead *.markdown setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead *.tex setlocal spell spelllang=en_us
"autocmd FileType *.tex set spell spelllang=en_us
"autocmd FileType *.txt set spell spelllang=en_us
"autocmd FileType *.md set spell spelllang=en_us

highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

set spellfile=~/.vim/spellfile.add

" latex configuration
au BufNewFile,BufRead *.tex
    \ set formatoptions+=t | " auto wrapline

au BufNewFile,BufRead *.md
    \ set formatoptions+=t | " auto wrapline

" python configuration
au BufNewFile,BufRead *.py
    \ set tabstop=4        |
    \ set softtabstop=4    |
    \ set shiftwidth=4     |
    \ set textwidth=79     |
    \ set expandtab        |
    \ set autoindent       |
    \ set makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p |
    \ set errorformat=%f:%l:\ %m |
" antlr grammar syntax configuration
" https://github.com/dylon/vim-antlr
au BufRead,BufNewFile *.g set filetype=antlr3
au BufRead,BufNewFile *.g4 set filetype=antlr4


" make configuration
au BufNewFile,BufRead Makefile
    \ set tabstop=4        |
    \ set noexpandtab      |
    \ set shiftwidth=4     |
    \ set autoindent       |
    \ set fileformat=unix  |

" html configuration
au BufNewFile,BufRead *.html
    \ map <F2> :0r ~/.vimsnippets/html  <CR> | " http://vim.wikia.com/wiki/Insert_a_file

" python configuration
au BufNewFile,BufRead **/contests/**/*.py
    \ map <F2> :0r ~/.vimsnippets/pythoncontest <CR> |

au BufNewFile,BufRead *.py
    \ map <F2> :0r ~/.vimsnippets/python <CR> |

" highlight bad whitespaces
highlight BadWhitespace cterm=inverse,bold
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$\| \+\ze\t/
au BufRead,BufNewFile *.* match BadWhitespace /\s\+$\| \+\ze\t/
au Syntax * syn match BadWhitespace /\s\+$\| \+\ze\t/

" insert timestamp
nnoremap <leader>r :r !date "+\%Y-\%m-\%d \%H:\%M:\%S"<CR><CR>

" Status Line {
        set laststatus=2                             " always show statusbar
        set statusline=
        set statusline+=%-10.3n\                     " buffer number
        set statusline+=%f\                          " filename
        set statusline+=%h%m%r%w                     " status flags
        set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
        set statusline+=%=                           " right align remainder
        set statusline+=0x%-8B                       " character value
        set statusline+=%-14(%l,%c%V%)               " line, character
        set statusline+=%<%P                         " file position
"}

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
nnoremap <leader>n :bnext<CR>:redraw<CR>:ls<CR><CR>
nnoremap <leader>p :bprevious<CR>:redraw<CR>:ls<CR><CR>

" mapping make key
nnoremap <leader>m :w<CR>:make<CR>
" mapping vertical split
nnoremap <leader>% :vsp<Space>

" mapping horizontal split
nnoremap <leader>" :sp<Space>
" split horizontally current buffer
nnoremap <leader>' :sp<Cr>

" reload .vimrc
nnoremap <leader>r :w<Cr> :source ~/.vimrc<Cr>

" https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim
" mapping clipboard copy/paste
" first check it vim supports clipboard
"   :echo has('clipboard')
" if 0, install vim-gnome or vim-gtk or MacVim
" https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>Y "*y
nnoremap <leader>P "*p
"set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
set clipboard=unnamedplus

" open explorer
nnoremap <leader><TAB> :Texplore<CR>
nnoremap <leader>e :Vexplore<CR>
nnoremap <leader>E :Hexplore<CR>

" handling tabs
nnoremap <leader>t :tabedit %<CR>       " move widow to tab
nnoremap <leader><CR> :tabnext<CR>      " go to next tab
nnoremap <leader><Bs> :tabprevious<CR>  " go to previous tab
nnoremap <leader>q :q<CR>               " close tab
nnoremap <leader>s :w<CR>               " save tab
" open file into new tab
nnoremap <leader>T :tabedit<Space> %:h/

" customizing tabs
:hi TabLineFill ctermfg=DarkGreen ctermbg=LightGreen
:hi TabLineSel ctermfg=Black ctermbg=White cterm=bold,reverse
:hi TabLine ctermfg=Black ctermbg=DarkGreen

" finding files
" search down on into subfolders
" provides tab completion
set path+=**
" open buffer search
nnoremap <leader>l :br
" open file search
nnoremap <leader>L :find
" display all matching files when use tab
set wildmenu

" tag jumping
" should install ctags through homebrew
command! MakeTags !ctags -R .
" use ^] to jump to a tag under curson
" use g^] to show all tags
" use ^t to jump back

" autocomplete
" ^x^n for just file
" ^x^f for filenames
" ^x^] for tags only
" ^n or ^p for anything specified by the complete option

" syntax highlight for Vue
" git clone https://github.com/posva/vim-vue.git ~/.vim/pack/plugins/start/vim-vue
