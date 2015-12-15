"                                                                  Text width.
set textwidth=80
" vim-latex ------------------------------------------------------------------
"                                                             Default viewver.
let g:Tex_ViewRule_pdf='sumatrapdf'
"                                                       Default target format.
let g:Tex_DefaultTargetFormat='pdf'
"                                            Don't use Makefile for compiling.
let g:Tex_UseMakefile=0

" NerdTree -------------------------------------------------------------------
"                                           Don't show this files in NerdTree.
let NERDTreeIgnore = ['\.aux$', '\.log$', '\.out$', '\.gz$', '\.nav$',
            \'\.pdf$', '\.snm$', '\.toc$']
