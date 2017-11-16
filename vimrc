""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set omnifunc=syntaxcomplete#Complete

" Leader
let mapleader = ","

nnoremap / /\v
vnoremap / /\v

set breakindent                                     " wrap lines without changing the amount of indent
set backspace=2                                     " Backspace deletes like most programs in insert mode
set nobackup                                        " don't make backups at all
set nowritebackup
set directory=/tmp
set noswapfile                                      " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=10000
set ruler                                           " show the cursor position all the time
set showcmd                                         " display incomplete commands
set incsearch                                       " do incremental searching
set laststatus=2                                    " Always display the status line
set autowrite                                       " Automatically :write before running commands
set hls                                             " highlight and incremental search
set clipboard=unnamed                               " use system clipboard
set noeb vb t_vb=                                   " disable bell
set encoding=utf-8
set switchbuf=useopen
set showtabline=1                                   " always show tab header line
set linebreak
set winwidth=79
set autoindent
set backspace=indent,eol,start
set showmode
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set number
set numberwidth=4
set ignorecase smartcase                            " make searches case-sensitive only if they contain upper-case characters
set smartcase
set gdefault                                        " gdefault applies substitutions globally on lines
set showmatch
set hlsearch
set modelines=5
set pastetoggle=<F2>

" If a file is changed outside of vim, automatically reload it without asking
set autoread

" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces

" Default to no wrapping
set nowrap

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JEDI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jedi#completions_command = "<Ctrl-Space>"
" let g:jedi#use_splits_not_buffers = "left"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
nnoremap <leader><leader> <c-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RemoveFancyCharacters COMMAND
" Remove smart quotes, etc.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd BufRead *.md set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  autocmd FileType markdown setlocal spell " Enable spellchecking for Markdow
  autocmd! FileType mkd setlocal syn=off   " Don't syntax highlight markdown because it's often wrong

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM ENTER KEY
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MapCR()
  nnoremap <cr> :nohl<cr>
endfunction
call MapCR()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 " 256 colors

" Color scheme
set background=dark
colorscheme hybrid

" Softtabs, 2 spaces
set tabstop=8         " make literal tabs clearly visible
set softtabstop=2
set shiftwidth=2
set expandtab

set listchars=tab:▸\·,trail:·,eol:¬
set showbreak=…

set wildmode=list:longest,list:full

" Index ctags from any project, including those outside Rails
map <leader>ct :!ctags -R %%<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker line movement
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" No-op arrow keys in insert mode; get out, which is the right thing to do
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <leader>q gqip                                    " hard rewrap parahraph
nnoremap <leader>v V`]                                     " reselect the text that was just pasted
nnoremap <leader>ev :tabedit $MYVIMRC<cr>                  " vedit ~/.vimrc

" configure syntastic syntax checking to check on open as well as save
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:UltiSnipsExpandTrigger = '<C-j>'

nmap <F2> ^y$:<C-R>"<CR>
map <F5> :set nowrap!<CR>
map <F6> :set spell!<CR>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" resize
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" go-vim
let g:go_fmt_command = "goimports"

" folding
set foldlevelstart=0
set foldcolumn=2

nnoremap <Space> za
vnoremap <Space> za

" Tabularize
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a, :Tabularize /,<CR>
  vmap <Leader>a, :Tabularize /,<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a\| :Tabularize /\|<CR>
  vmap <Leader>a\| :Tabularize /\|<CR>
  vmap <Leader>a" :Tabularize /"<CR>
  nmap <Leader>a" :Tabularize /"<CR>
endif

" function! s:align()
"   let p = '^\s*|\s.*\s|\s*$'
"   if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"     let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"     let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"     Tabularize/|/l1
"     normal! 0
"     call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"   endif
" endfunction
" inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" Show syntax highlighting groups for word under cursor
nmap <Leader>p :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" autoremove traililng spaces
autocmd BufWritePre *.py :%s/\s\+$//e

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Git diff map
map <leader>d :Gdiff<cr>

call plug#begin('~/.vim/plugged')

" Define bundles via Github repos
Plug 'danro/rename.vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/ctags.vim'
Plug 'vim-scripts/tComment'
Plug 'tpope/vim-repeat'
Plug 'rking/ag.vim'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'fatih/vim-go'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'nelstrom/vim-markdown-folding'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }

call plug#end()
