" Plugins
call plug#begin('~/.vim/plugged')

" Interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle'  }
Plug 'wesQ3/vim-windowswap'

" Fuzzy Finders and Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" Tools
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'misterbuckley/vim-definitive'
Plug 'majutsushi/tagbar'
Plug 'editorconfig/editorconfig-vim'
Plug 'janko-m/vim-test'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Install additional coc extensions:
" :CocInstall coc-solargraph
" :CocInstall coc-snippets

" Ruby / Rails
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'
Plug 'asux/vim-capybara'
Plug 'ngmy/vim-rubocop'

" Git
Plug 'tpope/vim-fugitive'

" Syntax
" Plug 'dense-analysis/ale' " nice linter, but can slow down vim
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee'  }
Plug 'leafgarland/typescript-vim'
Plug 'ElmCast/elm-vim'
Plug 'maksimr/vim-jsbeautify' " needs js-beautify: npm -g install js-beautify

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'


call plug#end()
" Plugins end

" Encoding
set encoding=utf-8

" Leader
let mapleader = ","

" Show register
map ; :reg<CR>

" Settings
syntax on
set backspace=2                   " Backspace deletes like most programs in insert mode
set nocompatible                  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile                    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler                         " show the cursor position all the time
set showcmd                       " display incomplete commands
set incsearch                     " do incremental searching
set laststatus=2                  " Always display the status line
set autowrite                     " Automatically :write before running commands
set hlsearch                      " highlight search
set number                        " show linenumbers
set numberwidth=4                 " linenumbers width
set tabstop=2
set shiftwidth=2
set expandtab
set list listchars=tab:»·,trail:· " Display extra whitespace
set laststatus=2                  " Always display the status line, even if only one window is displayed

" Function Keys
map <F12> :NERDTreeToggle<CR>     " Toggle NERDTree
nnoremap <F11> :set nonumber!<CR> " Toggle linenumbers
nmap <F10> :TagbarToggle<CR>
set pastetoggle=<F9>              " Toggle paste mode with F9

filetype plugin indent on

" Color scheme
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Quick window resizing
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Resize splits
nnoremap <C-k> <C-w>+
nnoremap <C-j> <C-w>-
nnoremap <C-l> <C-w><
nnoremap <C-h> <C-w>>

" Moving splits (with vim-windowswap)
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <C-w>m :call WindowSwap#EasyWindowSwap()<CR>

" Open vsplit with command
nnoremap <Leader>s :split<CR>
nnoremap <Leader>vs :vsplit<CR>

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" NERDTree
let g:NERDTreeWinSize = 35
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1

" FZF / fzf.vim
nmap <Leader>t :FZF<CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <Leader>rg :Rg<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>g :Commits<CR>

" vim-test mappings
nmap <silent> <leader>r ::TestFile<CR>
nmap <silent> <leader>c :TestNearest<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='angr'
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" Snippets
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" Make ctrl-n autocompletion scrollable with j/k
" inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
" inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" Load local settings from vimrc_local
if filereadable( expand("$HOME/vim-dotfiles/vimrc_local")  )
  source ~/vim-dotfiles/vimrc_local
endif

" Elm Settings
let g:elm_setup_keybindings = 0

" Vim Definitive
nnoremap <Leader>d :FindDefinition<CR>

" Go to definition in a new window
nnoremap <silent><C-]> <C-w><C-]><C-w>T

" Vim Rubocop
nnoremap <Leader>rc :RuboCop<CR>

" CoC.nvim
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
" set shortmess+=c

" ale.vim
" let g:ale_open_list = 1
" lint only on save
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0

" JsBeautify
map <c-f> :call JsBeautify()<cr>
