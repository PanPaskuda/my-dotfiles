" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim
set nocompatible

syntax on " line enables syntax highlighting by default.
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set hlsearch
set list listchars=tab:>-,trail:~,extends:>,nbsp:o",space:.
set list

let mapleader=","

"following special code to ommit gnome terminal restrictions for ALT button
"let g:enable_on=1

"if g:enable_on
"    let c='a'
"    while c <= 'z'
"        exec "set <A-".c.">=\e".c
"        exec "imap \e".c." <A-".c.">"
"        let c = nr2char(1+char2nr(c))
"    endw
"endif

"set timeout ttimeoutlen=50
if has("win32")
    set backupdir=$VIM\backup
    set directory=$VIM\tmp
else
    set backupdir=~/.vim/backup
    set directory=~/.vim/swap
endif 

map <F3> :TlistToggle<CR>
map <F4> :NERDTreeToggle<CR>
map <F6> :set cursorline!<CR>
map <F12> :call CreateTags()<CR>

" generate database
map <Leader>csa :!find . -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" > cscope.files<CR>
            \:!cscope -b <CR>
            \:!rm cscope.files<CR>
            \:cscope kill 0<CR>
            \:cscope add cscope.out<CR>

" generate database java
map <Leader>csj :!find . -name "*.java" > cscope.files<CR>
            \:!cscope -b <CR>
            \:!rm cscope.files<CR>
            \:cscope kill 0<CR>
            \:cscope add cscope.out<CR>

"set cscopequickfix=s-,c-,d-,i-,t-,e-,f-
" find callers
map <Leader>csc :cscope f c <cword><CR>

" find callees
map <Leader>csd :cscope f d <cword><CR>

" find defininition
map <Leader>csg :cscope f g <cword><CR>

" find file
map <Leader>csf :cscope f f <cword><CR>

" find files including this
map <Leader>csi :cscope f i %:t<CR>

" find symbol
map <Leader>css :cscope f s <cword><CR>

" find text
map <Leader>cst :cscope f t <cword><CR>

" grep this
map <Leader>cse :cscope f e <cword><CR>   

map <C-q> :qall<CR>

let NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden=1

let EasyGrepModeUser=1 "user group of files - I set group inside plugin 
"to "*.c *.h"
let g:EasyGrepRecursive=1 "recursive search, started from main folder
"pecifies that multiple matches on the same line be treated as
"different matches
let g:EasyGrepEveryMatch=1
let g:EasyGrepFileAssociationsInExplorer=1 "allowed to set group of 
"files in vim by GrepOption




"--------------------------------------------------------------------------------
"my colours
highlight   clear
highlight clear SpellBad
highlight SpellBad ctermbg=yellow
highlight   Pmenu         ctermfg=0 ctermbg=2
highlight   PmenuSel      ctermfg=0 ctermbg=7
highlight   PmenuSbar     ctermfg=7 ctermbg=0
highlight   PmenuThumb    ctermfg=0 ctermbg=7
highlight     preproc        guifg=lightGreen ctermfg=lightGreen
hi Search        guifg=lightGreen        ctermfg=lightGreen ctermbg=darkYellow
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi comment		guifg=lightBlue		ctermfg=lightBlue
"hi NERDTreeDir ctermfg=LightBlue ctermbg=Black
hi NERDTreeDir ctermfg=LightBlue

" TagList options
let Tlist_Close_On_Select = 1 "close taglist window once we selected 
"something
let Tlist_Exit_OnlyWindow = 1 "if taglist window is the only window 
"left, exit vim
let Tlist_Show_One_File = 1 "show tags of only one file
let Tlist_GainFocus_On_ToggleOpen = 1 "automatically switch to taglist
"window
let Tlist_Highlight_Tag_On_BufEnter = 1 "highlight current tag in 
"taglist window
let Tlist_Process_File_Always = 1 "even without taglist window, create
"tags file, required for displaying tag in statusline
let Tlist_Use_Right_Window = 1 "display taglist window on the right
let Tlist_Display_Prototype = 1 "display full prototype instead ofjust function name

""todo the ctags command generated right now tags for definition and
"declaration this shall be changed to the definition only or give some
"possibility of choice for the user
function! CreateTags()
    if has("win32")
        :!c:\tools\ctags58\ctags.exe -R --c++-kinds=+p --fields=+liaS --extra=+q <CR><CR> 
        ":!rm ./tags; /usr/bin/ctags -R --c++-kinds=+p --fields=+liaS --extra=+q <CR><CR> 
        ":silent !ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf .
    else
        :silent !/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf .
    endif
    :redraw!
endfunction
"let Tlist_Ctags_Cmds="C:\Program Files (x86)\ctags58"
"let Tlist_Ctags_Cmd="/usr/bin/ctags" cscope stuff
let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_WinWidth = 70

"because of Vundle
set nocompatible
filetype off

set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

"call vundle#rc()

" Let Vundle manage Vundle
"Bundle 'gmarik/vundle'
Plugin 'VundleVim/Vundle.vim'

" My Bundles
Plugin 'vim-scripts/Command-T' "<leader> t and <leader> b to fuzzy serch a file 
Plugin 'vim-scripts/The-NERD-tree'
"Plugin 'vim-scripts/OmniCppComplete'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/snipMate'
Plugin 'vim-scripts/Mark--Karkat'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'

call vundle#end()

"YouCompleteMe
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion = ['<Up>']
"let g:ycm_enable_diagnostic_signs = 0

"OmniCppComplete
"set ofu=syntaxcomplete#Complete
"let OmniCpp_GlobalScopeSearch   = 1
"let OmniCpp_DisplayMode         = 1
"let OmniCpp_ShowScopeInAbbr     = 0
"let OmniCpp_ShowAccess          = 1
"let OmniCpp_SelectFirstItem     = 1
"let OmniCpp_MayCompleteDot = 1 " autocomplete with .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
"let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files set to 2
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e.  parameters) in popup window
"format of popup menu
set completeopt=menuone,menu,longest

filetype plugin indent on

function! StringTrailingWhiteSpace()
    " store current possition
    let l = line(".")
    let c = col(".")

    "if getline(".")[col(".")-1] == ' '

    call cursor(l,c-1)
    while getline(".")[col(".")-1] == ' '
        execute "normal x"
        let c = c - 1
        call cursor(l,c-1)
    endwhile

    call cursor(l,c)

endfunction

"set spell checking to english
set spl=en spell
set nospell

"sugestion for spell check
nmap <leader>s z=

"put enter and strip in previous line all spaces till the nearest non space
"sign
nmap K :call StringTrailingWhiteSpace()<CR>i<CR><ESC>

"strip all spaces till the nearest non space sign
nmap <leader><SPACE> :call StringTrailingWhiteSpace()<CR>i<SPACE><ESC>

"YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"jump back
nmap <leader>jb <C-O>
"jump forward
nmap <leader>jf <C-I>

"tabs
"create tab
nmap <leader>tc :tabnew<CR>
"close tab
nmap <leader>tcl :tabclose<CR>
"move tab
nmap <leader>tm :tabmove<CR>
"next tab
nmap <leader>tn :tabnext<CR>
"previous tab
nmap <leader>tp :tabprevious<CR>
"first tab
nmap <leader>tf :tabfirst<CR>

"sugestion for autocompletion C/C++ word
imap <leader>c <C-x><C-o>

"coment-out
nmap <leader>o 'aO#if 0<ESC>'zo#endif<ESC>0

"nawigate like in normal mode
imap <A-j> <down>
imap <A-k> <up>
imap <A-h> <left>
imap <A-l> <right>

"nawigate like in cmd mode
cmap <A-j> <down>
cmap <A-k> <up>
cmap <A-h> <left>
cmap <A-l> <right>

"delete sign - like 'x' in normal mode
imap <A-x> <del>
cmap <A-x> <del>

"use to jump window
nmap <A-j> <PageDown>
nmap <A-k> <PageUp>
cmap <A-j> <PageDown>
cmap <A-k> <PageUp>

"display in new smal window definition of current word or function
nmap <F2> <C-w>s<C-w>j<C-w>20-:YcmCompleter GoToDefinitionElseDeclaration<CR>

"close current window
nmap <S-F2> <C-w>c

"actions for window: resize, equal, navigate
nmap <C-=> <C-w>=
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-0> <C-w>+
nmap <C-9> <C-w>-

"rotate window
nmap <A-r> <C-w>r

"copy rest text of a current line
nmap <S-y> y$

"jump to first and last character on the current line
nmap <A-h> ^
nmap <A-l> $
vmap <A-h> ^
vmap <A-l> $

"set buffer for copy/paste
map <A-a> "a
map <A-b> "b
map <A-c> "c

"set relative number
nmap <F1> :set rnu<CR>

"set number
nmap <S-F1> :set nu<CR>

"enable/disable spell checking
nmap <F5> :set spell!<CR>

"tab set to 4 spaces
set tabstop=4

"remove tab to spaces
set expandtab

set sw=4

"set relative number
set rnu

"set current line number
set number

"set colorScheme
colorscheme slate

"set coding border
set colorcolumn=100

"disable creation backup files
set nobackup

"treat *.cog files as "c" files
au BufRead,BufNewFile *.cog        setfiletype c

"if cursor doesn't move, check whether the current file is up to date
au CursorHold * checktime

"modify the status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [LEN=%L]\ %{&fenc}%=%P
"set statusline=%t\ -\ FileType:\ %y\ FileEncoding:\ %{&fenc}%=%P\ 0x%02B\ %3c
set laststatus=2

" === VIEW and SESSION ===
set viewdir=$VIMHOME/views/
autocmd BufWinLeave * mkview
autocmd BufWinEnter * silent loadview

autocmd VimEnter * call LoadSession()
autocmd VimLeave * call SaveSession()
function! SaveSession()
    execute 'mksession! $HOME/.vim/sessions/session.vim'
endfunction
function! LoadSession()
    if argc() == 0
    execute 'source $HOME/.vim/sessions/session.vim'
    endif
endfunction

"set terminal encoding to latin1 to support ALT key and macros, but it means
"that mouse doesn't work
set termencoding=latin1

syntax keyword todoKeywords FIXME Fixme fixme TODO Todo todo NOTE Note note WORKAROUND Workaround TBD Tbd tbd 
syntax region todoComments start=/\/\*/ end=/\*\// contains=todoKeywords

"TODO, FIX TBD NOTE: TODO:, WORKAROUND todo <TODO> TOFIX /* todo TODO FIXME NOTE XXX */
