" Call pathogen first.
runtime bundle/vim-pathogen/autoload/pathogen.vim
silent! execute pathogen#infect()

" important ------------------------------------------------------------------
"                                                       No compatible with vi.
set nocompatible
"                  When making a change to one line, don't redisplay the line.
set cpoptions+=$
" moving around, searching and patterns --------------------------------------
"                                        Highlight search result while typing.
set incsearch
"                     Ignore symbols register when search by / and ? commands.
set ignorecase
"                  If pattern contains uppercase symbol it will be considered.
set smartcase
" tags -----------------------------------------------------------------------
" displaying text ------------------------------------------------------------
"                            Number of screen lines to show around the cursor.
set scrolloff=5
"                                                              Wrap long line.
set wrap
"          Break long line at a character in 'breakat' rather than at the last
"                                           character that fits on the screen.
set linebreak
"                            Minimal number of columns to scroll horizontally.
set sidescroll=1
"              Minimal number of columns to keep left and right of the cursor.
set sidescrolloff=5
"                                         Don't redraw while executing macros.
set lazyredraw
"                                          Show the line number for each line.
set number
"                                     Show relative line number for each line.
set relativenumber
" syntax, highlighting and spelling ------------------------------------------
"                                                    Hightlight search result.
set hlsearch
"                                                      Highlight current line.
set cursorline
"                                                        Columns to highlight.
set colorcolumn=80
" multiple windows------------------------------------------------------------
"                                                     Always show status line.
set laststatus=2
set statusline=%f%h\ %y\ %m\ %r\ %{&encoding}\
set statusline+=%=Line:%l/%L[%p%%]\ Col:%c\ [%b][0x%B]
set statusline+=\ Buf:%n\
"                      Don't unload a buffer when no longer shown in a window.
set hidden
" multiple tab pages ---------------------------------------------------------
" terminal -------------------------------------------------------------------
"                                                     Use custom window title.
set title
"                                             Title format: Vim /path/to/file.
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70
"                                       For improving smoothness of redrawing.
set ttyfast
" using the mouse ------------------------------------------------------------
" GUI ------------------------------------------------------------------------
set guifont=Consolas:h9
"                                                             Remove menu bar.
set guioptions-=m
"                                                              Remove toolbar.
set guioptions-=T
"                                                Remove right-hand scroll bar.
set guioptions-=r
"                                                 Remove left-hand scroll bar.
set guioptions-=L
" printing -------------------------------------------------------------------
" messages and info ----------------------------------------------------------
"                              Show (partial) command keys in the status line.
set showcmd
"                                 Display the current mode in the status line.
set showmode
"                                      Show cursor position below each window.
set ruler
"                                   Alternate format to be used for the ruler.
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
"                                      Don't ring the bell for error messages.
set noerrorbells
"                                        Use a visual bell for error messages.
set visualbell t_vb=
" selecting text -------------------------------------------------------------
" editing text ---------------------------------------------------------------
"     Allow backspacing over autoindent, line breaks, and the start of insert.
set backspace=indent,eol,start
" tabs and indenting ---------------------------------------------------------
"                                                          Tab size in spaces.
set tabstop=4
"                         Number of spaces used for each step of (auto)indent.
set shiftwidth=4
"                                      Number of spaces to insert for a <Tab>.
set softtabstop=4
"                                       Expand <Tab> to spaces in Insert mode.
set expandtab
"                                  Automatically set the indent of a new line.
set autoindent
"                                                     Do clever autoindenting.
set smartindent

" folding --------------------------------------------------------------------
" diff mode ------------------------------------------------------------------
" mapping --------------------------------------------------------------------
" reading and writing files --------------------------------------------------
"                        List of file formats to look for when editing a file.
set fileformats=unix,dos,mac
"                         Don't write a backup file before overwriting a file.
set nowb
"                                Don't keep a backup after overwriting a file.
set nobackup
"               Automatically read a file when it was modified outside of Vim.
set autoread
" the swap file --------------------------------------------------------------
"                                                       Don't make swap files.
set noswapfile
" command line editing -------------------------------------------------------
"                                       How many command lines are remembered.
set history=1000
"                             Command-line completion shows a list of matches.
set wildmenu
" executing external commands ------------------------------------------------
" running make and jumping to errors -----------------------------------------
" system specific ------------------------------------------------------------
" language specific ----------------------------------------------------------
" multi-byte characters ------------------------------------------------------
"                                              Character encoding used in Vim.
set encoding=utf-8
"                                     Character encoding for the current file.
set fileencoding=utf-8
"                                  Automatically detected character encodings.
set fileencodings=utf-8,cp1251,koi8-r,cp866
" various --------------------------------------------------------------------
"                                                       Allow virtual editing.
set virtualedit=all
"                               Use the 'g' flag for ":substitute" by default.
set gdefault


" misc -----------------------------------------------------------------------
"      Enable file type detection, automatic indendation, and loading plugins.
filetype indent plugin on
"                                                            Highlight syntax.
syntax enable
"                                                                       Theme.
colorscheme monokai
"                                                    Start gvim in fullscreen.
if has("gui_running")
   autocmd GUIEnter * simalt ~x
endif
"                                                   Save position before exit.
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g`\"" | endif
"                                          Source $MYVIMRC when it is changed.
augroup vimscript
    autocmd!
    autocmd BufWritePost .vimrc source $MYVIMRC
augroup END
"                                                 Remove trailing whitespaces.
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()


" mappings -------------------------------------------------------------------
"                                                  To open a new empty buffer.
nnoremap <leader>T :enew<cr>
"                                                     Move to the next buffer.
noremap <leader>l :bnext<CR>
"                                                 Move to the previous buffer.
noremap <leader>h :bprevious<CR>
"                       Close the current buffer and move to the previous one.
noremap <leader>bq :bp <BAR> bd #<CR>
"                                      Show all open buffers and their status.
noremap <leader>bl :ls<CR>
"                                                           Normal mode by jj.
inoremap jj <Esc>
"                                                 Normal mode by оо (Russian).
inoremap оо <Esc>
"                                                            Turn off Ex mode.
nnoremap Q <nop>
"         Turn off highlight of found patterns and clear all printed messages.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
"                                                                  Fullscreen.
if has('win32')
    if filereadable($ProgramFiles . '/Vim/vim74/gvimfullscreen.dll')
        noremap <F11> <Esc>:call libcallnr("gvimfullscreen.dll",
                    \"ToggleFullScreen", 0)<CR>
    endif
endif
"                                                                 Edit .vimrc.
nnoremap <leader>ev :vsplit $MYVIMRC<cr>


" plugins --------------------------------------------------------------------
" NerdTree -------------------------------------------------------------------
"                                             Close NerdTree bar on file open.
let NERDTreeQuitOnOpen = 0
"                                                           Show hidden files.
let NERDTreeShowHidden=1
"                                                         Toggle NerdTree bar.
nnoremap <Leader>d :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
nnoremap <Leader>D :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>
"    Open a NERDTree automatically when vim starts if no files were specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"                      Close vim if the only window left opened is a NerdTree.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
    \&& b:NERDTreeType == "primary") | q | endif


" vim-latex ------------------------------------------------------------------
"                                                           Default file type.
let g:tex_flavor='latex'
"                                                          Compile latex file.
autocmd FileType tex call Tex_MakeMap("<Leader>ll",
            \":w <CR> <Plug>Tex_Compile", 'n', '<buffer>')
"                                                                    View pdf.
autocmd FileType tex call Tex_MakeMap("<Leader>ll",
            \"<ESC> :w <CR> <Plug>Tex_Compile", 'v', '<buffer>')


" vim-airline ----------------------------------------------------------------
"                                                         Use powerline fonts.
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"                                                             Unicode symbols.
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
"                                                           Powerline symbols.
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
"                                                   Old vim-powerline symbols.
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
"                                                              Enable tabline.
let g:airline#extensions#tabline#enabled = 1
"                                 Enable displaying buffers with a single tab.
let g:airline#extensions#tabline#show_buffers = 1
"                            Configure whether buffer numbers should be shown.
let g:airline#extensions#tabline#buffer_nr_show = 1
"                              Configure whether close button should be shown.
let g:airline#extensions#tabline#show_close_button = 0
"                                                      Show just the filename.
let g:airline#extensions#tabline#fnamemod = ':t'
"                                                            Custom z section.
let g:airline_section_z='%p%% %l %c %V'


" CtrlP ----------------------------------------------------------------------
"                                                  Setup some default ignores.
let g:ctrlp_custom_ignore = {
  \'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

"                                   Use the nearest .git directory as the cwd.
let g:ctrlp_working_path_mode = 'r'
"                                         Easy bindings for its various modes.
noremap <leader>bb :CtrlPBuffer<cr>
noremap <leader>bm :CtrlPMixed<cr>
noremap <leader>bs :CtrlPMRU<cr>


" EasyMotion -----------------------------------------------------------------
"                                                         Smart case matching.
let g:EasyMotion_smartcase = 1
"                                                     Bidirectional searching.
noremap <leader><leader>f <Plug>(easymotion-s)

" EasyAlign ------------------------------------------------------------------
"                                  Start interactive EasyAlign in visual mode.
xnoremap ga <Plug>(EasyAlign)
"                        Start interactive EasyAlign for a motion/text object.
noremap ga <Plug>(EasyAlign)

