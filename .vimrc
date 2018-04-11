let g:fzf_install = 'yes | ./install'

" Activate markdown for .txt
let g:vim_markdown_auto_extension_ext = 'txt'

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
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
Plug 'sbdchd/neoformat'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'vim-syntastic/syntastic'
Plug 'joonty/vim-do'
call plug#end()

" Do
nmap <Leader>r :DoAgain<CR>

" Javascript
let g:javascript_plugin_jsdoc = 1
let g:neoformat_try_formatprg = 1

augroup fmt
  autocmd!
  autocmd BufWritePre *.js undojoin | Neoformat prettier
  autocmd BufWritePre *.json undojoin | Neoformat 
  autocmd BufWritePre *.html undojoin | Neoformat htmlbeautify
  autocmd BufWritePre *.css,*.scss undojoin | Neoformat prettier
augroup END

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*



" Activate python highlighting
let g:python_highlight_all = 1
autocmd BufNewFile,BufRead BUCK,BUCK_DEFS set syntax=python


" NerdTREE find file
" Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" Open nerdtree only when opening vim on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


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

noremap <C-p> :Files<CR>
nnoremap <C-p> :Files<CR>

" auto fold the top level
autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

set foldmethod=syntax
set foldnestmax=2

" tabs
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set paste

" misc
set number
