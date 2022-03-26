"         _              
"   _  __(_)_ _  ________
"  | |/ / /  ' \/ __/ __/
"  |___/_/_/_/_/_/  \__/ 
"                        

"""""""""""""""""""""""
"+Conditional options+"
"""""""""""""""""""""""
" If the ~/.vim/ directory exists, append it to the runtimepath.
if isdirectory("$HOME/.vim")
   set runtimepath+=~/.vim
endif

let g:numbers = 'HYNUM'
function ToggleLineNumbers()
    if &number && &relativenumber
        setlocal number norelativenumber
	let g:numbers = 'ABNUM'
    elseif &number && !&relativenumber
        setlocal nonumber norelativenumber
	let g:numbers = 'NONUM'
    elseif !&number && !&relativenumber
        setlocal number relativenumber
	let g:numbers = 'HYNUM'
    endif
endfunction

function LineNumbersStatus()
	return g:numbers
endfunction

let g:tabs = 'EXP4'
function ToggleTabExpansion()
    if &expandtab && &shiftwidth == 4
        setlocal shiftwidth=8 tabstop=8 noexpandtab
	let g:tabs = 'EXPN'
    elseif !&expandtab
        setlocal shiftwidth=4 tabstop=4 expandtab
	let g:tabs = 'EXP4'
    endif
endfunction

function TabExpansionStatus()
	return g:tabs
endfunction

let g:windowmaximized = 0
function ToggleMaximizeWindow()
    if !g:windowmaximized
        execute "normal! \<C-W>_\<C-W>\<BAR>"
        let g:windowmaximized = 1
    elseif g:windowmaximized
        execute "normal! \<C-W>="
        let g:windowmaximized = 0
    endif
endfunction

" Enable the plugin manager and initialize all plugins.
" https://github.com/junegunn/vim-plug
if !empty(glob("$HOME/.vim/autoload/plug.vim"))
    call plug#begin("$HOME/.vim/plugins")
        Plug 'https://github.com/vimwiki/vimwiki'
            let g:vimwiki_global_ext = 0
            let g:vimwiki_ext2syntax = {'.md': 'markdown'}
            let g:vimwiki_list = [{'path': '~/vimwiki/',
            \'syntax': 'markdown',
            \'ext': '.md'}]
        Plug 'https://github.com/itchyny/lightline.vim'
            set laststatus=2
            set showtabline=2
            let g:lightline = {
		\ 'colorscheme': 'dogrun',
		\ 'active': {
		\   'left': [ [ 'mode', 'paste', 'linenumbers', 'tabexpansion' ],
		\             [ 'readonly', 'filename', 'modified' ] ]
		\ },
		\ 'component_function': {
		\   'linenumbers': 'LineNumbersStatus',
	    	\   'tabexpansion': 'TabExpansionStatus'
	    	\ },
		\ 'tabline': {
		\   'left': [ ['buffers'] ],
		\   'right': [ ['close'] ]
		\ },
		\ 'component_expand': {
		\   'buffers': 'lightline#bufferline#buffers'
		\ },
		\ 'component_type': {
		\   'buffers': 'tabsel'
		\ }
		\ }
        Plug 'https://github.com/mengelbrecht/lightline-bufferline'
        Plug 'https://github.com/lifepillar/vim-mucomplete'
            set completeopt-=preview
            set completeopt+=longest,menuone,noselect
            set shortmess+=c
        Plug 'https://github.com/vim-syntastic/syntastic'
            set statusline+=%#warningmsg#
            set statusline+=%{SyntasticStatuslineFlag()}
            set statusline+=%*
            let g:syntastic_always_populate_loc_list = 1
            let g:syntastic_auto_loc_list = 1
            let g:syntastic_check_on_open = 1
            let g:syntastic_check_on_wq = 0
        Plug 'junegunn/goyo.vim'
        Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
            " let g:mkdp_refresh_slow = 1
            let g:mkdp_command_for_global = 1
            let g:mkdp_browser = 'firefox'
            let g:mkdp_echo_preview_url = 1
            let g:mkdp_page_title = 'Markdown-Preview: ${name}'
            let g:mkdp_markdown_css = '~/retro/css/markdown.css'
        Plug 'https://github.com/ferrine/md-img-paste.vim'
        Plug 'wadackel/vim-dogrun'
        Plug 'dylanaraps/wal.vim'
        Plug 'dracula/vim', { 'as': 'dracula' }
    call plug#end()
endif

" Set the color scheme.
colorscheme ron
if !empty(glob("$HOME/.vim/colors/sfy.vim"))
  colorscheme dogrun
endif
colorscheme dracula

"""""""""""""""""""""""""
"+Unconditional options+"
"""""""""""""""""""""""""
filetype plugin on  " Detect file extensions.
syntax on           " Enable syntax highlighting.
set history=1000    " Set length of the command history.
set wildmenu        " Enable command autocompletion.
set nocompatible    " Disable Vi compatibility mode.
set incsearch       " Update search results dynamically.
set hlsearch        " Hightlight the search results.
set noshowmode      " Don't show the input mode.
set smartindent     " 'Smart' auto indentation.
set ttyfast         " Sometimes improves smoothness of redrawing.
set lazyredraw      " Disable redrawing while executing commands that have not beeen typed.
set ruler           " Show the cursor position.
set number          " Enable absolute line numbers.
set relativenumber  " Enable relative line numbers.
set showcmd         " Show the last executed command.
set splitbelow      " New horizontal splits always appear below.
set splitright      " New vertical splits always appear on the right.
set smarttab        " Delete starting whitespace with a single backspace.
set cursorline      " Highlight the current line.
set shiftwidth=4    " Set shift width in spaces.
set tabstop=4       " Set space tab expansion length.
set expandtab       " Expand tabs to spaces.

""""""""""""""""""""""
"+Custom keybindings+"
""""""""""""""""""""""
" Ignore the ex mode.
map q: <Nop>
nnoremap Q <nop>
" Global keybindings.
autocmd FileType markdown nmap <buffer><silent> .k :call mdip#MarkdownClipboardImage()<CR>
set pastetoggle=.p
nmap .w <Plug>VimwikiIndex
map <silent> ZS :w <CR>
map <silent> .h :noh <CR>
map <silent> .v :call ToggleTabExpansion() <CR>
map <silent> .n :call ToggleLineNumbers() <CR>
map <silent> .t :call TrimTrailingWhitespace() <CR>
map <silent> .u :PlugClean <bar> :PlugUpdate <bar> :PlugUpgrade <CR>
map <silent> .g :Goyo <CR>
map <silent> .m :MarkdownPreview <CR>
map <silent> ,v :vsplit <CR>
map <silent> ,s :split <CR>
nnoremap <silent> ,f :call ToggleMaximizeWindow() <CR>
nnoremap <silent> ,<C-K> :exe "resize " . (winheight(0) * 110/100) <CR>
nnoremap <silent> ,<C-J> :exe "resize " . (winheight(0) * 100/110) <CR>
nnoremap <silent> ,<C-L> :exe "vertical resize " . (winwidth(0) * 110/100) <CR>
nnoremap <silent> ,<C-H> :exe "vertical resize " . (winwidth(0) * 100/110) <CR>
nnoremap ,h <C-W>h
nnoremap ,j <C-W>j
nnoremap ,k <C-W>k
nnoremap ,l <C-W>l
nnoremap ,H <C-W>H
nnoremap ,J <C-W>J
nnoremap ,K <C-W>K
nnoremap ,L <C-W>L
nnoremap ,r <C-W>r
nnoremap ,R <C-W>R

