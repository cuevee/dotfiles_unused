" set omnifunc=syntaxcomplete#Complete

filetype plugin indent on

" Leader
let mapleader = ","

" nnoremap / /\v
" vnoremap / /\v

" set ttyfast
" set termguicolors
set autoindent
set autoread                                        " If a file is changed outside of vim, automatically reload it without asking
set autowrite                                       " Automatically :write before running commands
set backspace=2                                     " Backspace deletes like most programs in insert mode
set backspace=indent,eol,start
set breakindent                                     " wrap lines without changing the amount of indent
set clipboard=unnamed                               " use system clipboard
set cursorline
set directory=/tmp
set encoding=utf-8
set foldcolumn=2
set foldlevelstart=0
set gdefault                                        " gdefault applies substitutions globally on lines
set hidden
set history=10000
set hls                                             " highlight and incremental search
set hlsearch
set ignorecase smartcase                            " make searches case-sensitive only if they contain upper-case characters
set incsearch                                       " do incremental searching
set laststatus=2                                    " Always display the status line
set linebreak
set modelines=5
set nobackup                                        " don't make backups at all
set noeb vb t_vb=                                   " disable bell
set nojoinspaces
set noswapfile                                      " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set nowrap
set nowritebackup
set number
set numberwidth=4
set pastetoggle=<F2>
set ruler                                           " show the cursor position all the time
set showcmd                                         " display incomplete commands
set showmatch
set showmode
set showtabline=1                                   " always show tab header line
set smartcase
set splitbelow
set splitright
set switchbuf=useopen
set visualbell
set wildmenu
set wildmode=list:longest
set winwidth=79

set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Softtabs, 2 spaces
set tabstop=8                                       " make literal tabs clearly visible
set softtabstop=2
set shiftwidth=2
set expandtab

set listchars=tab:▸\·,trail:·,eol:¬
set showbreak=…
set wildmode=list:longest,list:full

nnoremap <leader><leader> <c-^>                      " Switch between the last two files

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Quicker tab movement
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprev<CR>

imap <c-c> <esc>                                     " can't be bothered to understand ESC vs <c-c> in insert mode
nnoremap <leader><leader> <c-^>

" Quicker line movement
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nnoremap <leader>q gqip                              " hard rewrap parahraph
nnoremap <leader>v V`]                               " reselect the text that was just pasted
nnoremap <leader>ev :tabedit $MYVIMRC<cr>            " vedit ~/.vimrc

nnoremap <C-p> :<C-u>FZF<CR>

nmap <F2> ^y$:<C-R>"<CR>
map <F5> :set nowrap!<CR>
map <F6> :set spell!<CR>

" resize windows
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

nnoremap <Space> za

vnoremap <Space> za
" Color
" set t_Co=256 " 256 colors
set background=dark
colorscheme hybrid_material
" set background=light
" colorscheme solarized8_light

map <leader>ct :!ctags -R %%<CR>                    " Index ctags from any project, including those outside Rails

" Custom enter key
function! MapCR()
  nnoremap <cr> :nohl<cr>
endfunction
call MapCR()

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <Leader>p :call <SID>SynStack()<CR>

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Git diff map
map <leader>d :Gdiff<cr>

" Neovim-specific maps
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/tComment'
Plug 'jremmen/vim-ripgrep'
Plug 'janko-m/vim-test'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'nelstrom/vim-markdown-folding'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'fatih/vim-go'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'pangloss/vim-javascript'

" Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" Plug 'godlygeek/tabular'

call plug#end()
