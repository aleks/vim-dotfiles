" Plugins
call plug#begin('~/.vim/plugged')

" Interface
Plug 'vim-airline/vim-airline' " status line
Plug 'vim-airline/vim-airline-themes' " status line themes
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle'  } " file tree browser
Plug 'wesQ3/vim-windowswap' " swap splits around
Plug 'junegunn/vim-peekaboo' " register preview

" Fuzzy Finders and Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'yuki-ycino/fzf-preview.vim'
Plug 'dyng/ctrlsf.vim'

" Tools
Plug 'tpope/vim-eunuch' " unix commands like :Rename, :Mkdir etc.
Plug 'tpope/vim-surround' " makes it easy to switch sourroundings like 'hello' to double quotes
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair
Plug 'tomtom/tcomment_vim' " better comment creation, i.e. with <ctrl-_>
Plug 'majutsushi/tagbar' " sidebar to show ctags data
Plug 'editorconfig/editorconfig-vim' " use .editorconfig
Plug 'janko-m/vim-test' " shortcut support for most testing frameworks
Plug 'neoclide/coc.nvim', {'branch': 'release'} " does a lot, but mainly code completion via solargraph
" Install additional coc extensions:
" :CocInstall coc-solargraph
" :CocInstall coc-snippets
" :CocInstall coc-vetur
Plug 'maksimr/vim-jsbeautify' " format javascript - needs js-beautify: npm -g install js-beautify

" Ruby / Rails
Plug 'tpope/vim-rails' " adds a bunch of rails helpers
Plug 'slim-template/vim-slim' " support for slim templates
Plug 'asux/vim-capybara' " support for capybara
Plug 'ngmy/vim-rubocop' " support for rubocop

" Git
Plug 'tpope/vim-fugitive' " adds git commands like :Gblame

" Syntax
Plug 'dense-analysis/ale' " nice linter, but can slow down vim
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee'  } " coffee script syntax
Plug 'leafgarland/typescript-vim' " typescript syntax
Plug 'elixir-editors/vim-elixir' " elixir syntax

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" JavaScript
Plug 'posva/vim-vue'

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
let g:fzf_tags_command = 'ctags -R'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
nmap <Leader>t :FZF<CR>
nnoremap <Leader>rg :Rg<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>gl :Commits<CR>
" Use ripgrep instead of ag
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --files'.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" FZF-Preview
nmap <Leader>b :Buffers<CR>
nmap <Leader>g :GFiles?<CR>
nmap <Leader>j :Tags<CR>
nmap <Leader>o :History<CR>

" vim-test mappings
nmap <silent> <leader>r ::TestFile<CR>
nmap <silent> <leader>c :TestNearest<CR>
" Use C-o to switch to normal mode in terminal buffer
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='angr'
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#coc#error_symbol = 'Error: '

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
set shortmess+=c
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-n> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use coc-definition with <Leader>d
nmap <silent><Leader>d :call <SID>GoToDefinition()<CR>
nmap <silent><Leader>ds :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent><Leader>dv :call CocAction('jumpDefinition', 'vsplit')<CR>
" CocAction
nmap <leader>do <Plug>(coc-codeaction)

" Go to definition in a new window
nnoremap <silent><C-]> <C-w><C-]><C-w>T

" Try jumpDefinition from coc, than <C-]> and then search in file
function! s:GoToDefinition()
  if CocAction('jumpDefinition', 'tab drop')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret[:5] =~ "Error"
    call searchdecl(expand('<cword>'))
  endif
endfunction

" Ale.vim
let g:ale_open_list = 1 " open loclist on error
" lint only on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_enter = 0 " Don't lint files on open

" Use only defined linters
let g:ale_linters = {
\  'ruby': ['ruby', 'solargraph', 'sorbet', 'standardrb'],
\  'javascript': ['eslint', 'prettier'],
\  'vue': ['eslint', 'prettier'],
\  'typescript': ['eslint', 'prettier']
\}
let g:ale_linters_explicit = 1 " only use linters from g:ale_linters
let g:ale_lint_on_enter = 0 " don't run ale when opening files


" JsBeautify
map <c-f> :call JsBeautify()<cr>

" Clipboard copy via shortcut
vmap <Leader>cb "*y

" Switch between tabs with Tab
noremap <Tab> :tabn<CR>
noremap <S-Tab> :tabp<CR>

" ctrlsf.vim
nmap <Leader>f <Plug>CtrlSFPrompt
let g:ctrlsf_auto_close = { "normal" : 0, "compact": 0 }
let g:ctrlsf_context = '-B 2 -A 2'

" vim-rubocop
let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '
