set nocompatible
set termguicolors

" Status Line stuff
set laststatus=2

" vim-airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0 "disable trailing/mixed-indent whitespace checking
" vim-airline symbol customization
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = ' ℂ:'

" Make <Leader> be comma instead of backslash
let mapleader=","

" Tell vim to use UTF-8 internally instead of ridiculous Latin-1
set encoding=utf-8

" Use DirectWrite on Windows for font rendering instead of GDI
if has("gui_running")
  set renderoptions=type:directx
end

" Use spaces for tabs, and make them 2 spaces wide
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Highlight tab characters, trailing whitespace, and lines that are longer than the window
set list listchars=tab:»·,trail:·,precedes:<,extends:>

" Delete comment character when joining commented lines
if v:version > 703
  set formatoptions+=j
endif

" Draw a line at columns 100 and 120 to remind me not to write lines that are too long
set colorcolumn=100,120

" Don't wrap long lines
set nowrap

" Show the ruler
set ruler

" Don't create backup/swap files
set nobackup
set noswapfile

" Reduce from default of 4000 to speed up vim-gitgutter updates
set updatetime=500

set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*,*\\gen\\*

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Make splits open below or to the right rather than above or to the left
set splitbelow
set splitright

set background=dark
colorscheme base16-eighties

if has("win32")
  let g:vimfiles = $HOME . '\vimfiles\'
else
  let g:vimfiles = '~/.vim/'
endif

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Searching stuff
" Use perl-style regex's by default
"nnoremap / /\v
"vnoremap / /\v
" Highlight matches
set showmatch
set hlsearch
" Clear highlighting
nnoremap <Leader><space> :noh<CR>

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
set smartindent

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Display line numbers on the left
set number

" Highlight the line that the cursor is on
set cursorline

" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Configure vim-indent-guides plugin defaults
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1

" Enable syntax highlighting
syntax on

" Make vim recognize *.dmake files as make for syntax highlighting
augroup dmake
  autocmd!
  autocmd BufNewFile,BufRead *.dmake set filetype=make
  autocmd BufNewFile,BufRead *.dmake set syntax=make
augroup END

" Stop the infernal beeping
set noerrorbells visualbell t_vb=
augroup nobells
  autocmd!
  autocmd GuiEnter * set visualbell t_vb=
augroup END

" Folding
"set foldmethod=syntax
"set foldlevelstart=1
"let javaScript_fold=1
"autocmd FileType javascript set foldlevel=1

" <Leader>ff to reset fold level to its starting value
nnoremap <Leader>ff :let &foldlevel=&foldlevelstart<CR>

" GVIM-only settings
if has("gui_running")
  if has("win32")
    set lines=42 columns=150
    set guifont=Consolas_for_Powerline_FixedD:h12:cANSI
  else
    set lines=50 columns=150
    set guifont=FiraCode-Light:h15
  endif
  " Add tab number to the tab labels for easy switching
  set guitablabel=%N:\ %t\ %r%M
endif


" OmniComplete setup for file types I typically use
augroup omnicomplete_setup
  autocmd!
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType c set omnifunc=ccomplete#Complete
augroup END

" Remove trailing whitespace from each line of the given filetypes as they are written
augroup strip_whitespace
  autocmd!
  autocmd BufWritePre  *.{c,cpp,css,js,less}  call StripTrailingWhiteSpace()
augroup END

function! StripTrailingWhiteSpace()
  let l:winview = winsaveview()
  silent! %s/\s\+$//
  call winrestview(l:winview)
endfunction

nnoremap <silent> <Leader>a :ArgWrap<CR>

nnoremap <Leader>sw :call StripTrailingWhiteSpace()<CR>

" <Leader>w for window commands is faster than <C-w>
nnoremap <Leader>w <C-w>

nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprev<CR>
nnoremap <Leader>bf :bfirst<CR>
nnoremap <Leader>bl :blast<CR>

" Move between windows without doing <C-w> first
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use <Tab> to move to matching brace
noremap <Tab> %

" Yank from cursor to end of line to be consistent with C and D
nnoremap Y y$

" Easier movements to beginning or end of line (never use default H and L anyway)
noremap H ^
noremap L $

" Toggle line numbering between relative and absolute via <C-n>
nnoremap <C-n> :set relativenumber!<CR>

" <C-r> in visual mode to search the buffer for the contents of the visual selection
" and replace it with the text supplied at the prompt
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" // in visual mode to search the buffer for the next occurence of the visual selection
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'

" Change the working directory to the directory of the file open in the current buffer
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Change EasyMotion leader key to just one <Leader> instead of two
" let g:EasyMotion_leader_key = '<Leader>'

" Tell SuperTab how to do its magic
let g:SuperTabDefaultCompletionType = "context"

" NERDTree configuration
let NERDTreeQuitOnOpen = 1
let NERDTreeChDirMode = 2
let NERDTreeWinPos = "right"
let NERDTreeWinSize = 60

" Shortcuts for toggling NERDTree
nnoremap <Leader>nt :NERDTree<CR><C-w>h:NERDTreeFind<CR>

nnoremap <Leader>be :BufExplorer<CR>

" CtrlP
" Custom command to use git-ls so that .gitignore is used as a filter
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
let g:ctrlp_working_path_mode = 'rwa'

" Syntastic stuff
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint']

run SyntasticEnable javascript
run SyntasticEnable typescript
run SyntasticEnable sass

" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd!
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
  augroup END
endif

" Settings that are prose-friendly
function! SoftWrap()
  setlocal formatoptions=1
  setlocal linebreak
  setlocal wrap
  setlocal nolist
  noremap <buffer> j gj
  noremap <buffer> k gk
  setlocal foldcolumn=7
endfunction

" Source ~/.vimrc.local if it exists
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

