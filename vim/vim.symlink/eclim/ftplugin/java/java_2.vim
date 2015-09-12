"for java use monokai colorscheme
"set 256 color for different colorschmes
" set t_Co=256
" set background=dark

"Import the class under cursor
nnoremap <silent> <buffer> <leader>i :JavaImportOrganize<cr>

"Search for javadocs of the element under the cursor
noremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>

"Perform a context sensitive search of the element under the cursor w/ enter
nnoremap <silent> <buffer> <leader>s :JavaSearchContext<cr>

"black sign columns
highlight SignColumn ctermbg=black ctermfg=white

" Easytags highlight
highlight javaClassTag ctermfg=28 cterm=bold
highlight javaMethodTag ctermfg=28
highlight javaInterfaceTag ctermfg=128 cterm=bold

"cooler signs
let g:EclimQuickfixSignText = "\u25b8"
let g:EclimLoclistSignText = "\u21e8"

"format using java convention
nnoremap <leader>f :%JavaFormat<cr>

"suggest corrections
nnoremap <leader>c :JavaCorrect<cr>

"Project tree map
nnoremap <leader>p :ProjectTreeToggle<cr>

"Refactor rename
nnoremap <leader>r :JavaRename<cr>

"Eric Van Dewoestine settings
nnoremap <silent> <buffer> <leader>jc :JavaDocComment<cr>
nnoremap <silent> <buffer> <leader>jp :JavaDocPreview<cr>

let java_comment_strings = 1
let java_highlight_java_lang_ids = 1
"let java_mark_braces_in_parens_as_errors=1
let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_java_lang_ids=1
" let java_highlight_functions="style"
let java_highlight_functions=1
let java_minlines = 150

" set fold method to fold class and methods only
setlocal foldmethod=syntax
setlocal foldnestmax=2           "Only fold methods after class declarations"
setlocal foldlevel=1             "Opens the first level"


