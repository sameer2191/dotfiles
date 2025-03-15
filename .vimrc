""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc Configuration File
" A comprehensive configuration file for Vim with essential settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " Use Vim settings, rather than Vi settings
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set history=1000             " Keep 1000 lines of command line history
set ruler                    " Show the cursor position all the time
set showcmd                  " Display incomplete commands
set incsearch                " Do incremental searching
set wildmenu                 " Display completion matches in a status line
set ttimeout                 " Time out for key codes
set ttimeoutlen=100          " Wait up to 100ms after Esc for special key
set display=truncate         " Show @@@ in the last line if it is truncated
set scrolloff=5              " Keep 5 lines above/below cursor visible
set mouse=a                  " Enable mouse usage (all modes)
set autoread                 " Auto-reload files changed outside of Vim
set hidden                   " Allow buffer switching without saving
set ttyfast                  " Speed up scrolling in Vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup, Swap and Undo Files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup                   " Keep a backup file (restore to previous version)
set backupdir=~/.vim/backup// " Store backup files in specific directory
set directory=~/.vim/swap//  " Store swap files in specific directory
set undofile                 " Keep an undo file (undo changes after closing)
set undodir=~/.vim/undo//    " Store undo files in specific directory

" Create directories if they don't exist
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "p", 0700)
endif
if !isdirectory($HOME."/.vim/swap")
    call mkdir($HOME."/.vim/swap", "p", 0700)
endif
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p", 0700)
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on                    " Enable syntax highlighting
set number                   " Show line numbers
set relativenumber           " Show relative line numbers
set cursorline               " Highlight current line
set showmatch                " Show matching brackets
set matchtime=2              " Show matching brackets for 0.2 seconds
set laststatus=2             " Always show status line
set showtabline=2            " Always show tab line
set shortmess+=c             " Don't pass messages to |ins-completion-menu|
set signcolumn=yes           " Always show signcolumn
set colorcolumn=80           " Highlight column 80
set noerrorbells             " No beeps
set visualbell               " No sounds
set t_vb=                    " No visual bell
set title                    " Change the terminal's title

" Status Line
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, Tab and Indent Related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                " Use spaces instead of tabs
set smarttab                 " Smart tab handling
set shiftwidth=4             " Number of spaces to use for each (auto)indent
set tabstop=4                " Number of spaces that a <Tab> counts for
set softtabstop=4            " Number of spaces that a <Tab> counts for while editing
set autoindent               " Copy indent from current line when starting a new line
set smartindent              " Smart autoindenting when starting a new line
set wrap                     " Wrap lines
set linebreak                " Wrap lines at convenient points
set whichwrap+=<,>,h,l       " Allow specified keys to move to the previous/next line

" Show invisible characters
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch                 " Highlight search results
set ignorecase               " Ignore case when searching
set smartcase                " Override 'ignorecase' if search contains upper case
set wrapscan                 " Searches wrap around the end of the file

" Press Space to turn off highlighting and clear any message already displayed
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map leader key to space
let mapleader=" "

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Fast saving
nnoremap <leader>w :w!<CR>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<CR>

" Move between buffers
map <leader>l :bnext<CR>
map <leader>h :bprevious<CR>

" Close the current buffer
map <leader>bd :Bclose<CR>:tabclose<CR>gT

" Close all the buffers
map <leader>ba :bufdo bd<CR>

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<CR>`z
nmap <M-k> mz:m-2<CR>`z
vmap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z

" Disable arrow keys (training)
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Type Specific Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable file type detection
filetype plugin indent on

" Python
augroup python_files
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
augroup END

" Web development
augroup web_files
    autocmd!
    autocmd FileType html,css,javascript,typescript,json setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" Markdown
augroup markdown_files
    autocmd!
    autocmd FileType markdown setlocal wrap linebreak nolist
    autocmd FileType markdown setlocal spell spelllang=en_us
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't close window when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" Delete trailing white space on save
function! DeleteTrailingWS()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction
augroup whitespace
    autocmd!
    autocmd BufWritePre * :call DeleteTrailingWS()
augroup END

" Return to last edit position when opening files
augroup remember_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

