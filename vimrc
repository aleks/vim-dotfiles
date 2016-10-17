" Plugins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle'  }

" Interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle'  }
Plug 'wesQ3/vim-windowswap'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'easymotion/vim-easymotion'

" Fuzzy Finders
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

" Tools
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/vim-easy-align'
Plug 'ervandew/supertab'

" App Integration
Plug 'mileszs/ack.vim'
Plug 'rizzatti/dash.vim'  " Mac only!

" Ruby / Rails
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'janko-m/vim-test'
Plug 'slim-template/vim-slim'
Plug 'asux/vim-capybara'

" Jekyll
Plug 'csexton/jekyll.vim'
Plug 'junegunn/goyo.vim' " Distraction-free writing in Vim.

" Syntax
Plug 'scrooloose/syntastic'
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee'  }

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

call plug#end()
" Plugins end


" Leader
let mapleader = ","

" EasyMotion
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Show register
map ; :reg<CR>

" Settings
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
set pastetoggle=<F9>              " Toggle paste mode with F9
map <F10> :Dash<CR>               " Map Dash.app Search to F9
nnoremap <F11> :set nonumber!<CR> " Toggle linenumbers
map <F12> :NERDTreeToggle<CR>     " Toggle NERDTree
map <F7> :Goyo<CR>                " Toggle Goyo (distraction-free writing)

" Switch syntax highlighting on, when the terminal has colors
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

" Color scheme
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0


" Show register
map ; :reg<CR>

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

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" NERDTree
let g:NERDTreeWinSize = 40
let NERDTreeDirArrows = 1

" FZF / fzf.vim
nmap <Leader>t :FZF<CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>

" Ctrlp
let g:ctrlp_map = ',p'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }

" vim-test mappings
nmap <silent> <leader>c :TestNearest<CR>
nmap <silent> <leader>C :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" Snippets
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" Make ctrl-n autocompletion scrollable with j/k
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" Load local settings from vimrc_local
if filereadable( expand("$HOME/vim-dotfiles/vimrc_local")  )
  source ~/vim-dotfiles/vimrc_local
endif

" binding.pry
nnoremap <Leader>pry ibinding.pry
