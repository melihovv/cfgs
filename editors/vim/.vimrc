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
"                                   A new window is put below the current one.
set splitbelow
"                                A new window is put right of the current one.
set splitright
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
set guifont=Source\ Code\ Pro
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
set background=dark
"                                                   For correct colors in vim.
let g:solarized_termcolors=256
"                                                                       Theme.
colorscheme solarized
augroup misc
    autocmd!
"                                                   Save position before exit.
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
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
augroup END


" mappings -------------------------------------------------------------------
"                                                  To open a new empty buffer.
nnoremap <leader>T :enew<cr>
"                                                     Move to the next buffer.
nnoremap <leader>j :bnext<CR>
"                                                 Move to the previous buffer.
nnoremap <leader>h :bprevious<CR>
"                       Close the current buffer and move to the previous one.
nnoremap <leader>bq :bd<CR>
"                                      Show all open buffers and their status.
nnoremap <leader>bl :ls<CR>
"                                                           Normal mode by jj.
inoremap jk <Esc>
"                                                 Normal mode by лд (Russian).
inoremap лд <Esc>
"                                                            Turn off Ex mode.
nnoremap Q <nop>
"                                                 Usefull when wrapping is on.
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap 0 g0
nnoremap ^ g^
"                                                             Analog to <S-j>.
nnoremap <M-j> a<CR><ESC>k$
"                                                                        Save.
nnoremap <Space>s :w<CR>
"         Turn off highlight of found patterns and clear all printed messages.
nnoremap <silent> <Space><Space> :nohlsearch<Bar>:echo<CR>
"                                          Insert space before in normal mode.
nnoremap <Space>[ i<Space><Esc>l
"                                           Insert space after in normal mode.
nnoremap <Space>] a<Space><Esc>h
"                                                     Magic search by default.
nnoremap / /\v
"                              Start gvim in fullscreen and toggle fullscreen.
if has('gui_running')
    if has('win32')
        autocmd GUIEnter * simalt ~x
        if filereadable($ProgramFiles . '/Vim/vim74/gvimfullscreen.dll')
            nnoremap <F11> <Esc>:call libcallnr('gvimfullscreen.dll',
                \'ToggleFullScreen', 0)<CR>
        endif
    elseif has('unix')
        autocmd GUIEnter * silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
    endif
endif
"                                                                 Edit .vimrc.
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
"                                             When you open file without sudo.
cnoremap w!! w !sudo tee % > /dev/null
"                                             Cd to directory of current file.
cnoremap cd!! cd %:p:h
"                                                Move selection one line down.
vnoremap J :m '>+1<CR>gv=gv
"                                                  Move selection one line up.
vnoremap K :m '<-2<CR>gv=gv
"                                                       Map key to toggle opt.
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)
"                                                                 Toggle wrap.
MapToggle <F2> wrap
MapToggle <F3> list


" plugins --------------------------------------------------------------------
" NerdTree -------------------------------------------------------------------
"                                             Close NerdTree bar on file open.
let NERDTreeQuitOnOpen = 0
"                                                           Show hidden files.
let NERDTreeShowHidden=1
"                                                          Don't hijack netrw.
let g:NERDTreeHijackNetrw=0
"                                                         Toggle NerdTree bar.
nnoremap <Leader>d :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>
nnoremap <Leader>D :let NERDTreeQuitOnOpen = 0<bar>NERDTreeToggle<CR>


" vim-latex ------------------------------------------------------------------
"                                                           Default file type.
let g:tex_flavor='latex'
augroup latex
    autocmd!
"                                                          Compile latex file.
    autocmd FileType tex call Tex_MakeMap('<Leader>ll',
                \':w <CR> <Plug>Tex_Compile', 'n', '<buffer>')
"                                                                    View pdf.
    autocmd FileType tex call Tex_MakeMap('<Leader>ll',
                \'<ESC> :w <CR> <Plug>Tex_Compile', 'v', '<buffer>')
augroup END


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
  \'dir':  '\v[\/](\.(git|hg|svn)|vendor|node_modules|clockwork)$',
  \'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

"                                   Use the nearest .git directory as the cwd.
let g:ctrlp_working_path_mode = 'r'
"                                         Easy bindings for its various modes.
nnoremap <leader>bb :CtrlPBuffer<cr>
nnoremap <leader>bm :CtrlPMixed<cr>
nnoremap <leader>bs :CtrlPMRU<cr>
nnoremap <leader>bt :CtrlPBufTag<cr>
nnoremap <leader>. :CtrlPTag<cr>

" Tagbar
nnoremap <F8> :TagbarToggle<cr>

" Utilsnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips', 'Ultisnips']
"                             If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsNoPythonWarning=1


" EasyMotion -----------------------------------------------------------------
"                                                         Smart case matching.
let g:EasyMotion_smartcase = 1
"                                                     Bidirectional searching.
map <leader><leader>f <Plug>(easymotion-s)

" EasyAlign ------------------------------------------------------------------
"                                  Start interactive EasyAlign in visual mode.
xmap ga <Plug>(EasyAlign)
"                        Start interactive EasyAlign for a motion/text object.
nmap ga <Plug>(EasyAlign)

"                                                                      BufOnly
nnoremap <leader>ba :BufOnly<cr>

