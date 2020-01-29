set nu
set wrap!
set ignorecase
set smartcase
set incsearch
set hlsearch

set cursorline
syntax on
set nocompatible
set nobackup
set scs
" highlight strings inside C comments

let c_comment_strings=1
set nolbr
set textwidth=0 
set wrapmargin=0
nnoremap <silent> <F8> :TlistToggle<CR>
"filetype plugin on
"set ofu=syntaxcomplete#Complete

set guicursor=n-v-c:blinkon0-block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175  
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right scrollbar 
set guioptions+=l  "add seft scrollbar 
set guioptions+=b  "add seft scrollbar 
set autochdir "set dir to the current 
set guifont=Monospace\ 9

so ~/.vim/syntax/verilog_systemverilog.vim
au Syntax sv runtime! syntax/verilog_systemverilog.vim

set encoding=utf-8
set ff=unix

map <A-1> <Esc>:tabprev<CR>
map <A-2> <Esc>:tabnext<CR>

map <C-t> <Esc>:tabnew<CR>
map <C-r> <Esc>:q!<CR>
map <C-e> <Esc>:NERDTree<CR>                                                                                                                        

colorscheme delek 
"colorscheme desert
"colorscheme koehler

"function! SuperCleverTab()
"    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
"        return "\<Tab>"
"    else
"        if &omnifunc != ''
"            return "\<C-X>\<C-O>"
"        elseif &dictionary != ''
"            return "\<C-K>"
"        else
"            return "\<C-N>"
"        endif
"    endif
"endfunction

"inoremap <Tab> <C-R>=SuperCleverTab()<cr>

map <C-M-left> :execute "tabmove" tabpagenr() - 2 <CR>
map <C-M-right> :execute "tabmove" tabpagenr() <CR>

" I don't think I need pathogen any more, it was added when NERDTree was introduced
" set guitablabel=\[%N\]\ %t\ %M execute pathogen#infect()
" call pathogen#helptags()

"let g:NERDTreeDirArrows=0
"let g:NERDTreeDirArrowExpandable = '>'
"let g:NERDTreeDirArrowCollapsible = '_'

""automatically reload the file if changed
set autoread
""or type :edit to update manually

"C-w gf   to open the link in new tab
"20 C-w >   to make current tab wider by 20

""enable Verilog syntax highlighting
"cal SetSyn("verilog")


" "open syntax menu to allow SynCal function
" let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu
" autocmd BufRead,BufNewFile *.sv cal SetSyn("verilog")
" autocmd BufRead,BufNewFile *.v cal SetSyn("verilog")

" " Do not create temp swap files / or use deditatec directory for that purpose
set noswapfile
" set dir=~/vim_tmp_swap

""" commenting out - potentially this was causing file format issues
"" hide carriage return ^M characters from the file
"set fileformats=dos
