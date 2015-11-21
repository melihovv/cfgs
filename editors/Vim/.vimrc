" No compatible with vi.
set nocompatible

" Load plugins.
runtime bundle/vim-pathogen/autoload/pathogen.vim
silent! execute pathogen#infect()

" Set size of indentation and load plugins, depending on the file type.
filetype indent plugin on

" Highlight file syntax.
syntax enable


"
" PLUGINS
"

" NerdTree
" Close NERDTree bar on file open.
let NERDTreeQuitOnOpen = 0
nnoremap <Leader>d :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
nnoremap <Leader>D :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>

" Show hidden files.
let NERDTreeShowHidden=1

" Open a NERDTree automatically when vim starts up if no files were specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the only window left open is a NERDTree.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" vim-latex
autocmd FileType tex call Tex_MakeMap("<Leader>ll", ":w <CR> <Plug>Tex_Compile", 'n', '<buffer>')
autocmd FileType tex call Tex_MakeMap("<Leader>ll", "<ESC> :w <CR> <Plug>Tex_Compile", 'v', '<buffer>')
let g:tex_flavor='latex'


" vim-airline
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Unicode symbols.
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.crypt = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.whitespace = ''

" Powerline symbols.
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Old vim-powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_close_button = 0

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


" CtrlP
" Setup some default ignores.
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd.
" This makes a lot of sense if you are working on a project that is in
" version control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Easy bindings for its various modes.
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>


"
" Misc.
"

" Gvim.
" Start gvim in fullscreen.
if has("gui_running")
   au GUIEnter * simalt ~x
endif

" Remove menu bar, toolbar, right-hand and left-hand scroll bar.
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L


"
" Buffers.
"

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer.
" This replaces :tabnew which I used to bind to this mapping.
nmap <leader>T :enew<cr>

" Move to the next buffer.
nmap <leader>l :bnext<CR>

" Move to the previous buffer.
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one.
" This replicates the idea of closing a tab.
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status.
nmap <leader>bl :ls<CR>


" How to store symbols into Vim.
set encoding=utf-8
" How to write files.
set fileencoding=utf-8
" List of file encodings for auto detect.
set fileencodings=utf-8,cp1251,koi8-r,cp866
" List of file formats.
set fileformats=unix,dos,mac
" Don't make backups.
set nobackup
" Don't make backup before file overriding.
set nowb
" Don't make swap files.
set noswapfile

" For normal white space removing.
set backspace=indent,eol,start

" Show availible variants above command line when use auto complete.
set wildmenu

" Tab size in spaces.
set tabstop=4
" Number of space with the addition of tab.
set softtabstop=4
" Replace tabs to spaces.
set expandtab
" Количество пробелов, добавляемых командами >> и <<.
" Number of spaces with the addition of commands >> and <<.
set shiftwidth=4

" Copy indentation of previous line.
set autoindent
" Insert additional level of indentation in some cases.
set smartindent

" Wrap long line.
set wrap

" Show lines number.
set number
" Highlight current line.
set cursorline
" Turn of screen blinking and beep when displaying errors.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Enable additional info in the status bar.
set laststatus=2
set statusline=%f%h\ %y\ %m\ %r\ %{&encoding}\
set statusline+=%=Line:%l/%L[%p%%]\ Col:%c\ [%b][0x%B]
set statusline+=\ Buf:%n\

" Change window title.
set title
" Set title as: vim /path/to/file.
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70
" Show info about current line, column, virtual column and relative cursor
" position in file.
set ruler
" Show info about current typing command on the last line of screen.
set showcmd
" Show current mode of Vim.
set showmode
" Format showed info in the right bottom corner.
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

" Save screen update in buffer instead direct output to screen. Usefull with
" fast moving on file.
set lazyredraw

" Highlight search result while typing.
set incsearch
" Hightlight search result.
set hlsearch
" Global flag of replacemnt by default.
set gdefault
" Ignore symbols register when search by / and ?.
set ignorecase
" If pattern contains uppercase symbol it will be considered.
set smartcase

" Update file changed outside of Vim.
set autoread

" In order to improve anti-aliasing when redrawing.
set ttyfast

" Number of commands stored in history.
set history=1000
" Number of states for undo/redo.
set undolevels=1000

" In order the cursor always be in the middle.
set scrolljump=7
set scrolloff=10
set sidescrolloff=10
set sidescroll=1

" Hide unsaved file when opening another file.
set hidden

" Save position before exit.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Add vertical line after textwidth
"set colorcolumn=+1
set colorcolumn=80

" Theme.
colorscheme monokai


"
" Mappings.
"

" Normal mode by jj.
imap jj <Esc>
imap оо <Esc>

" By space pressing turn off highlight of found patterns and clear all printed
" messages.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

