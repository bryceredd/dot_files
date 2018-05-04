let g:fzf_install = 'yes | ./install'

" Activate markdown for .txt
let g:vim_markdown_auto_extension_ext = 'txt'

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'sbdchd/neoformat'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'vim-syntastic/syntastic'
Plug 'joonty/vim-do'
Plug 'vim-scripts/marvim'

" JS 
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --js-completer' }

" Python
Plug 'vim-python/python-syntax'
call plug#end()

" Obj-c++
Plug 'SolaWing/vim-objc-syntax'
Plug 'rhysd/vim-clang-format'
Plug 'octol/vim-cpp-enhanced-highlight'

" Do
nmap <Leader>r :DoAgain<CR>

" Marvim - don't prefix macros
let marvim_prefix = 0 
let marvim_store_key = 'ms'
let marvim_find_key = 'mf'

" Javascript
let g:javascript_plugin_jsdoc = 1
let g:neoformat_try_formatprg = 1
"let g:ycm_min_num_of_chars_for_completion = 2
"let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_enable_diagnostic_highlighting = 1
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
noremap <C-i> :TernDef<CR>
nnoremap <C-i> :TernDef<CR>

augroup fmt
  autocmd!
  autocmd BufWritePre *.js,*.css,*.scss undojoin | Neoformat prettier
  autocmd BufWritePre *.json undojoin | Neoformat 
  autocmd BufWritePre *.html undojoin | Neoformat htmlbeautify
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

" fuzzy word search
let $FZF_DEFAULT_COMMAND = 'rg --files -g ""'
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
noremap <C-o> :Files<CR>
nnoremap <C-o> :Files<CR>
noremap <C-p> :Find<CR>
nnoremap <C-p> :Find<CR>
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


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
