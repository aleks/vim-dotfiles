" Leader
let mapleader = ","
map ; :reg<CR>

set backspace=2   " Backspace deletes like most programs in insert mode
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif
" colorscheme smyck

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  " autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" set paste
set hlsearch

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Color scheme
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=4

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" vim-rspec mappings
nnoremap <Leader>tt :call RunCurrentSpecFile()<CR>
nnoremap <Leader>ss :call RunNearestSpec()<CR>
nnoremap <Leader>ll :call RunLastSpec()<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
" set splitbelow
" set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Resize splits
nnoremap <C-k> <C-w>+
nnoremap <C-j> <C-w>-
nnoremap <C-l> <C-w><
nnoremap <C-h> <C-w>>

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" Powerline
set guifont=Mensch\ for\ Powerline:h15
set laststatus=2
let g:Powerline_symbols = 'fancy'

" NERDTree
let g:NERDTreeWinSize = 40
let NERDTreeDirArrows = 1
map <F12> :NERDTreeToggle<CR>

" Toggle Number/NoNumber
nnoremap <F11> :set nonumber!<CR>

" Sane Ignore For ctrlp
let g:ctrlp_map = ',t'
let g:ctrlp_working_path_mode = 'rc'
nnoremap ,b :CtrlPBuffer<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }


" MacVim / GUI Vim
set guifont=Bitstream\ Vera\ Sans\ Mono:h12

" Snippets
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'
