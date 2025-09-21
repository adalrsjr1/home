" ========================
"    LSP CONFIGURATION
" ========================
" Keymaps are buffer-local and enabled when LSP attaches

" Insert Mode:
" <C-Space>      - Trigger LSP completion (omnifunc)
" .,             - Alternative completion trigger

" Normal Mode:
" gD             - Jump to declaration
" gd             - Jump to definition
" gi             - Jump to implementation
" <F2>           - Rename symbol (with LSP support)
" <leader>f      - Format buffer asynchronously
" <C-Space>      - Show hover documentation

" Diagnostics:
" [d             - Previous diagnostic
" ]d             - Next diagnostic
" <space>e       - Show diagnostic in floating window
" <space>q       - Add diagnostics to location list

" Help & Info:
" <leader>?      - Open init.vim in split for reference"

" ========================
"       AUTOCOMPLETION
" ========================
" Insert mode completion commands:
" <C-x><C-n> - Keyword completion
" <C-x><C-f> - Filename completion
" <C-x><C-]> - Tag completion
" <C-n>/<C-p> - General completion navigation

" ========================
"         Plugins
" ========================
if has('nvim')
    " load plugins earlier to avoid incompatibility
    source ~/.config/nvim/plugins.lua
endif


" ========================
"       MAPPINGS
" ========================
let mapleader = "\\"                     " Leader key (Backslash)
nmap <leader>? :split $MYVIMRC<CR>

" Code Formatting
" ---------------
nmap <leader>/ vgc                       " Toggle comment (normal mode)
vmap <leader>/ gc                        " Toggle comment (visual mode)

" Navigation & UI
" ---------------
inoremap jk <Esc>                        " Escape insert mode
vnoremap jk <Esc>                        " Escape visual mode
cnoremap jk <Esc>                        " Escape command mode
set timeoutlen=100                       " Timeout between consecutive key hits

" ========================
"      CORE SETTINGS
" ========================
" Essential Behavior
set nocompatible                " Disable vi compatibility
set encoding=utf-8              " Default: 'latin1' or system locale
set backspace=indent,eol,start  " Full backspace behavior
set fileformat=unix             " Unix-style line endings

" File Management
set nobackup                    " Disable backup files
set noswapfile                  " Disable swap files

" UI Configuration
set number                      " Show line numbers
set ruler                       " Show cursor position
set showmode                    " Display current mode
set showmatch                   " Highlight matching brackets
set visualbell                  " Use visual bell (no audio)
set laststatus=2                " Always show status line
" set nohlsearch                " Disable search highlighting
set cmdheight=0                 " Hide command line when unused
nnoremap <silent> q :call ToggleMacroRecording()<CR>
function! ToggleMacroRecording()
    if reg_recording() !=# ''
        " stop recording and reset cmdheight
        set cmdheight=0
        execute "normal! q"
    else
        " start recording and set cmdheight=1
        let l:reg = nr2char(getchar()) " get target register (e.g., 'a', 'b')
        set cmdheight=1
        execute "normal! q" . l:reg
    endif
endfunction

autocmd User MacroRecordingStart * echo "Macro recording started in register " . expand("<amatch>")

" ========================
"    VISUAL CUSTOMIZATION
" ========================
" Display Settings
set cursorline                  " Highlight current line

highlight StatusLine guibg=NONE guifg=NvimLightGreen

" Whitespace Handling
highlight BadWhitespace guibg=NvimDarkGray4 " Trailing whitespace

" ========================
"   INDENTATION & FORMATTING
" ========================
set autoindent                  " Maintain indentation
set smartindent                 " Context-aware indentation
set tabstop=4                   " Visual tab width
set softtabstop=4               " Spaces per tab in insert mode
set shiftwidth=4                " Indent size for >>/<<
set expandtab                   " Convert tabs to spaces
set formatoptions-=t            " Disable auto-text-wrapping (default: tcqj)
set textwidth=0                 " Line wrap column

" ========================
"     WINDOW MANAGEMENT
" ========================
set splitright                  " Vertical splits open right
set splitbelow                  " Horizontal splits open below

" ========================
"   SYSTEM INTEGRATION
" ========================
set clipboard+=unnamedplus      " Sync with system clipboard

" ========================
"      STATUS LINE
" ========================
set statusline=
set statusline+=%-10.3n\                     " Buffer number
set statusline+=%f\                          " Filename
set statusline+=%h%m%r%w                     " File status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " Filetype
set statusline+=%=                           " Right-align remainder
set statusline+=0x%-8B                       " Current character value
set statusline+=%-14(%l,%c%V%)               " Line/column position
set statusline+=%<%P                         " File position percentage

if has('nvim')
    source ~/.config/nvim/lsp.lua
endif

