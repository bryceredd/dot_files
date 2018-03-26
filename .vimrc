let g:fzf_install = 'yes | ./install'

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'SolaWing/vim-objc-syntax'
Plug 'rhysd/vim-clang-format'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-python/python-syntax'
Plug 'jelera/vim-javascript-syntax'
Plug 'walm/jshint.vim'
" Plug 'quark-zju/vim-cpp-auto-include' "Auto include hoses objc
" Plug 'valloric/youcompleteme', { 'dir': '~/.vim/plugged/youcompleteme', 'do': './install.py --clang-completer --system-libclang --system-boost'}
call plug#end()


" Activate python highlighting
"let g:python_highlight_all = 1
"autocmd BufNewFile,BufRead BUCK,BUCK_DEFS set syntax=python


" Open nerdtree only when opening vim on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


" Activate cpp auto include
"autocmd BufWritePre /**.cpp :ruby CppAutoInclude::process


let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
" Toggle auto formatting:
autocmd FileType c,cpp,hpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,hpp vnoremap <buffer><Leader>cf :ClangFormat<CR>
autocmd FileType c,cpp,hpp  ClangFormatAutoEnable
nmap <Leader>C :ClangFormat<CR>
let g:clang_format#style_options = {
			\"UseTab": "Never"}


" if you install vim-operator-user
"autocmd FileType c,cpp,objc,hpp map <buffer><Leader>x <Plug>(operator-clang-format)

" auto fold the top level
autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

set foldmethod=syntax
set foldnestmax=2

" tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" misc
set number
