set title  " Muestra el nombre del archivo en la ventana de la terminal
"set number  " Muestra los números de las líneas
set relativenumber
set mouse=a  " Permite la integración del mouse (seleccionar texto, mover el cursor)

set nowrap  " No dividir la línea si es muy larga
set smartindent
set cursorline  " Resalta la línea actual
set colorcolumn=1200  " Muestra la columna límite a 120 caracteres
"set colorscheme="ayu"

" Indentación a 2 espacios
set cursorline
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab  " Insertar espacios en lugar de <Tab>s
set ignorecase  " Ignorar mayúsculas al hacer una búsqueda
set termguicolors  " Activa true colors en la terminal
set guifont=Iosevka\ Nerd\ Font\ 11

"colorscheme OceanicNext

" Directorio de plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'joshdick/onedark.vim'

" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'

" Utility
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
"Plug 'BufOnly.vim'
Plug 'wesQ3/vim-windowswap'
"Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf'
Plug 'godlygeek/tabular'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'benmills/vimux'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'gilsondev/searchtasks.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'tpope/vim-dispatch'

" Generic Programming Support
"Plug 'jakedouglas/exuberant-ctags'
Plug 'honza/vim-snippets'
Plug 'Townk/vim-autoclose'
Plug 'tomtom/tcomment_vim'
Plug 'tobyS/vmustache'
Plug 'janko-m/vim-test'
Plug 'maksimr/vim-jsbeautify'
Plug 'vim-syntastic/syntastic'
Plug 'neomake/neomake'

" Markdown / Writting
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-markdown'
Plug 'jtratner/vim-flavored-markdown'
"Plug 'LanguageTool'
Plug 'dense-analysis/ale'

" Git Support
Plug 'kablamo/vim-git-log'
Plug 'gregsexton/gitv'
Plug 'tpope/vim-fugitive'
Plug 'jaxbot/github-issues.vim'

" Theme / Interface
Plug 'colors/onedark'
"Plug 'mhartington/oceanic'
Plug 'mhartington/oceanic-next'
Plug 'ayu-theme/ayu-vim'
Plug 'mhartington/oceanic-next'

"Plug 'AnsiEsc.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
"Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plug 'mkarmona/colorsbox'
Plug 'chriskempson/base16-vim'
Plug 'AlessandroYorba/Sierra'
Plug 'effkay/argonaut.vim'
Plug 'atelierbram/Base2Tone-vim'

" Theme / Interface
Plug 'ryanoasis/vim-devicons'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'junegunn/limelight.vim'
Plug 'romainl/Apprentice'
Plug 'Lokaltog/vim-distinguished'
Plug 'w0ng/vim-hybrid'
Plug 'daylerees/colour-schemes'
Plug 'ajh17/Spacegray.vim'
Plug 'colepeters/spacemacs-theme.vim'

"packadd! dracula
syntax enable
"colorscheme dracula

call plug#end()

filetype plugin indent on    " required

" Shorten error/warning flags
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
" I have some custom icons for errors and warnings but feel free to change them.
let g:ale_sign_error = '✘✘'
let g:ale_sign_warning = '⚠⚠'

let g:ale_linters = {
    \ 'cs':['syntax2', 'semantic', 'issues'],
    \ 'python': ['pylint'],
    \ 'java': ['javac']
    \ }

"""""""""""""""""""""""""""""""""""""
" Configuration Section
"""""""""""""""""""""""""""""""""""""
" Show linenumbers
set number
set ruler

" Dictionary
"set spell
"set spelllang=es

" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set encoding=UTF-8
" Always display the status line
set laststatus=2

" Enable Elite mode, No ARRRROWWS!!!!
let g:elite_mode=1

" Enable highlighting of the current line
set cursorline 

" Theme and Styling 
set t_Co=256
set background=dark
colorscheme OceanicNext

"Cursor style
let &t_SR = "\033]12;199\x7\e[3 q"
let &t_SI = "\033]12;199\x7\e[5 q"
let &t_EI = "\033]12;deepskyblue\x7\e[1 q"

augroup myCmds
  au!
  autocmd VimEnter * silent !echo -ne "\033]12;deepskyblue\x7\e[1 q"
augroup END

if (has("termguicolors"))
  set termguicolors
endif

let base16colorspace=256  " Access colors present in 256 colorspace
" colorscheme spacemacs-theme

"Abrir NerdTree al inicio
autocmd vimenter * NERDTree

let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1

" Vim-Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='ayu'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

let g:airline_powerline_fonts = 1

" Key shortcuts
nnoremap <C-s> :w<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-k> :NERDTreeClose<CR>
nnoremap <C-z> :u<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-e> :Explore <CR>
nnoremap <C-f> :buffers <CR>

