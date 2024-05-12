"         _
"   _  __(_)_ _  ________
"  | |/ / /  ' \/ __/ __/
"  |___/_/_/_/_/_/  \__/
"

"""""""""""""""""""""
"+Special variables+"
"""""""""""""""""""""
let mapleader=" "
let &t_SI="\e[6 q" " Change cursor shape to vertical bar in insert mode.
let &t_EI="\e[2 q" " Change cursor shape back to block in other modes.

""""""""""""""""""""
"+Custom functions+"
""""""""""""""""""""

" Toggle though different ways of numbering lines.
let g:n='ABNUM'
function ToggleLineNumbers()
    if &number && !&relativenumber
        setlocal nonumber relativenumber
        let g:n='RENUM'
    elseif !&number && &relativenumber
        setlocal number relativenumber
        let g:n='HYNUM'
    elseif &number && &relativenumber
        setlocal nonumber norelativenumber
        let g:n='NONUM'
    elseif !&number && !&relativenumber
        setlocal number norelativenumber
        let g:n='ABNUM'
    endif
endfunction

" Toggle through different ways of handling tab explansion.
let g:t='EXPN'
function ToggleTabExpansion()
    if !&expandtab
        setlocal shiftwidth=4 tabstop=4 expandtab
        let g:t='EXP4'
    elseif &expandtab && &shiftwidth==4
        setlocal shiftwidth=2 tabstop=2
        let g:t='EXP2'
    elseif &expandtab && &shiftwidth==2
        setlocal shiftwidth=8 tabstop=8 noexpandtab
        let g:t='EXPN'
    endif
endfunction

" Toggle window maximization in window splits.
let g:windowmaximized=0
function ToggleMaximizeWindow()
    if !g:windowmaximized
        execute "normal! \<C-W>_\<C-W>\<BAR>"
        let g:windowmaximized=1
    elseif g:windowmaximized
        execute "normal! \<C-W>="
        let g:windowmaximized=0
    endif
endfunction

" Toggle column highlighting.
let g:columnlimit=79
execute "set colorcolumn=" . g:columnlimit
function ToggleColorColumn()
    if &colorcolumn==""
        execute "set colorcolumn=" . g:columnlimit
    else
        set colorcolumn=
    endif
endfunction

"""""""""""
"+Options+"
"""""""""""
filetype plugin on            " Detect file extensions.
syntax on                     " Enable syntax highlighting.
colorscheme elflord           " Fallback color scheme.
silent! colorscheme habamax   " Default color scheme.

" Statusline format.
set statusline=\ \ %{g:t}\ \❱\ %{g:n}\ ❱\ %{getcwd()}\ ❱\ %m%r%y\ ❱\ [%n]
set statusline+=%=%4l/%L:%-4v
set mouse=a                   " Enable mouse support.
set clipboard=unnamedplus     " Use system register for copy/paste.
set undodir=~/.cache/vim/undo " Set undo files directory.
set matchpairs+=<:>           " Add more characters which form pairs.
set history=1024              " Set length of the command history.
set scrolloff=999             " Cursorline always in the middle of the screen.
set pumheight=8               " Maximum autocompletion pop-up height.
set laststatus=2              " Always show statusline.
set showtabline=2             " Always show tabline.
set wildmenu                  " Enable command autocompletion.
set nocompatible              " Disable Vi compatibility mode.
set incsearch                 " Update search results dynamically.
set hlsearch                  " Hightlight the search results.
set noshowmode                " Don't show the input mode.
set smartindent               " 'Smart' auto indentation.
set ttyfast                   " Sometimes improves smoothness of redrawing.
set lazyredraw                " Disable redrawing while executing commands.
set number                    " Enable absolute line numbers.
set showcmd                   " Show the last executed command.
set splitbelow                " Horizontal splits always appear below.
set splitright                " Hertical splits always appear on the right.
set smarttab                  " Delete starting whitespace with a backspace.
set cursorline                " Highlight the current line.
set confirm                   " Confirm quitting vim.
set hidden                    " Switch between buffers without saving changes.
set magic                     " No need to escape special characters in regex.
set secure                    " Prevent automatic execution of external files.
set nomore                    " Fully output long listings.
set noswapfile                " Disable the creation of swap files.
set undofile                  " Enable the creation of undo files.

""""""""""
"+Colors+"
""""""""""
highlight CursorLine ctermbg=Black cterm=Bold " No underline for cursorline.
highlight ColorColumn ctermbg=Black           " Cursorline color.
highlight ExtraWhitespace ctermbg=DarkGrey    " Trailing whitespace color.
match ExtraWhitespace /\s\+$/                 " Match trailing whitespace.

""""""""""""""""""""""
"+Custom keybindings+"
""""""""""""""""""""""

" Prevent accidental entry into the Ex mode.
nn             Q                   <nop>
nn             q:                  <nop>

" Treat movement over wrapped line as movement between different lines.
nn             j                   gj
nn             k                   gk

" Continuous visual mode shifting for selections.
xn             <                   <gv
xn             >                   >gv

" Movement around windows.
nn             <C-h>               <C-W>h
nn             <C-j>               <C-W>j
nn             <C-k>               <C-W>k
nn             <C-l>               <C-W>l

" Movement around buffers and tabs.
nn <silent>    <S-h>               :tabprevious                    <CR>
nn <silent>    <S-j>               :bprevious                      <CR>
nn <silent>    <S-k>               :bnext                          <CR>
nn <silent>    <S-l>               :tabnext                        <CR>

" Split controls.
nn <silent>    <leader>v           :vsplit                         <CR>
nn <silent>    <leader>h           :split                          <CR>

" Quitting, closing, and writing (windows/buffers).
nn <silent>    ZS                  :w                              <CR>
nn <silent>    <leader>w           :w                              <CR>
nn <silent>    <leader>qq          :q                              <CR>
nn <silent>    <leader>qc          :bd                             <CR>

" Double tap <leader> to turn off highlighting.
nn <silent>    <leader><leader>    :noh                            <CR>

" Custom function calls.
nn <silent>    <leader>n           :call ToggleLineNumbers()       <CR>
nn <silent>    <leader>t           :call ToggleTabExpansion()      <CR>
nn <silent>    <leader>m           :call ToggleMaximizeWindow()    <CR>
nn <silent>    <leader>b           :call ToggleColorColumn()       <CR>

