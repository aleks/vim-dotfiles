" Plugins
call plug#begin('~/.vim/plugged')

" LSP Plugin
Plug 'neovim/nvim-lspconfig'

" TODO:
" Add plugins
" https://github.com/mg979/vim-visual-multi
" https://github.com/nvim-telescope/telescope.nvim
" https://github.com/nvim-treesitter/nvim-treesitter

" Autocompletion plugins, using LS
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'ojroques/nvim-lspfuzzy' " Use FZF with LSP

" Interface
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle'  } " file tree browser
Plug 'wesQ3/vim-windowswap' " swap splits around

" Fuzzy Finders and Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" Tools
Plug 'tpope/vim-eunuch' " unix commands like :Rename, :Mkdir etc.
Plug 'tpope/vim-surround' " makes it easy to switch sourroundings like 'hello' to double quotes
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair
Plug 'tomtom/tcomment_vim' " better comment creation, i.e. with <ctrl-_>
Plug 'editorconfig/editorconfig-vim' " use .editorconfig
Plug 'janko-m/vim-test' " shortcut support for most testing frameworks

" Ruby / Rails
" Plug 'tpope/vim-rails' " adds a bunch of rails helpers
Plug 'slim-template/vim-slim' " support for slim templates
Plug 'asux/vim-capybara' " support for capybara
Plug 'ngmy/vim-rubocop' " support for rubocop

" Go
Plug 'fatih/vim-go'

" Git
Plug 'tpope/vim-fugitive' " adds git commands like :Git blame
Plug 'kdheepak/lazygit.nvim'
Plug 'ruanyl/vim-gh-line' " open current line on github

" Syntax
" Plug 'kchmck/vim-coffee-script', { 'for': 'coffee'  } " coffee script syntax
Plug 'leafgarland/typescript-vim' " typescript syntax
Plug 'elixir-editors/vim-elixir' " elixir syntax
Plug 'jparise/vim-graphql' " GraphQL highlighting
Plug 'posva/vim-vue' " Vue highlighting
Plug 'pantharshit00/vim-prisma' " Prisma highlighting
Plug 'hashivim/vim-terraform'

call plug#end()
" Plugins end

" LSP Config
lua << END

-- Enable FZF in LSP
require('lspfuzzy').setup {}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- LSP Server Config
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- denols specific setting, remove when no longer needed
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

-- Install packages:
-- solargraph: gem install --user-install solargraph (maybe install in specific ruby as well)
-- tsserver: npm install -g typescript typescript-language-server
-- eslint: npm i -g vscode-langservers-extracted
-- cssls: npm i -g vscode-langservers-extracted
-- dockerls: npm install -g dockerfile-language-server-nodejs
-- graphql: npm install -g graphql-language-service-cli
-- volar: npm install -g @volar/vue-language-server
-- gopls: go install golang.org/x/tools/gopls@latest

local servers = {
  'solargraph',
  'tsserver',
  'eslint',
  'cssls',
  'dockerls',
  'graphql',
  'gopls',
  -- 'denols',
  'rust_analyzer'
}

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
-- LSP Server Config End

-- Autocompletion Setup End

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-n>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { 
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      },
    },
  },
}

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("ruby", {"rails"})
-- Autocompletion Setup End

END
" LSP Config End

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
set numberwidth=4                 " linenumbers width
set tabstop=2
set shiftwidth=2
set expandtab
" set list listchars=tab:»·,trail:· " Display extra whitespace
set laststatus=2                  " Always display the status line, even if only one window is displayed

set splitbelow                    " Horizontal split below current.
set splitright                    " Vertical split to right of current.

" Enable/disable relative linenumbers when switching buffers
set number relativenumber         " Enable relative linenumbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Function Keys
map <F12> :NERDTreeToggle<CR>               " Toggle NERDTree
map <F11> :set relativenumber!<CR>          " Toggle relative line numbers
set pastetoggle=<F9>                        " Toggle paste mode with F9

filetype plugin indent on

" Color scheme - get colors via `:highlight`
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0
highlight Pmenu ctermbg=0 ctermfg=248
highlight PmenuSel ctermbg=11 ctermfg=0

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

" Center view when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzz
nnoremap N Nzz

" Moving splits with vim-windowswap
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
nmap <Leader>t :Files<CR>
nnoremap <Leader>rg :Rg<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>gl :Commits<CR>
nmap <Leader>w :Windows<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>j :BTags<CR>
nmap <Leader>m :Marks<CR>
nmap <Leader>p :Commands<CR>

" vim-test mappings
let g:test#javascript#runner = 'jest'
let test#strategy = 'neovim'
nmap <silent> <leader>r ::TestFile<CR>
nmap <silent> <leader>c :TestNearest<CR>
" Use C-o to switch to normal mode in terminal buffer
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Lualine
lua << END
require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'nord',
  },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true,  -- displays file status (readonly status, modified status)
        path = 1,            -- 0 = just filename, 1 = relative path, 2 = absolute path

      }
    },
    lualine_x = {
      'lsp_progress',      -- from arkav/lualine-lsp-progress
    },
  }
}
END

" Clipboard copy via shortcut
vmap <Leader>cb "*y

" Switch between tabs with Tab
noremap <Tab> :tabn<CR>
noremap <S-Tab> :tabp<CR>

" vim-rubocop
nnoremap <Leader>rc :RuboCop<CR>
let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '

" Lazygit
nnoremap <silent> <leader>lg :LazyGit<CR>

" vim-gh-line
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 1
let g:gh_use_canonical = 1
let g:gh_line_map = '<leader>gh'
