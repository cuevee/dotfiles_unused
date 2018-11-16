filetype plugin indent on

set nocompatible                                    " Be iMproved
set breakindent                                     " wrap lines without changing the amount of indent
set backspace=2                                     " Backspace deletes like most programs in insert mode
set nobackup                                        " don't make backups at all
set nowritebackup
set directory=/tmp
set noswapfile                                      " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=10000
set showcmd                                         " display incomplete commands
set incsearch                                       " do incremental searching
set laststatus=2                                    " Always display the status line
set autowrite                                       " Automatically :write before running commands
set hls                                             " highlight and incremental search
set clipboard=unnamed                               " use system clipboard
set noeb vb t_vb=                                   " disable bell
set switchbuf=useopen
set linebreak
set winwidth=79
set autoindent
set hidden
set wildmenu
set wildmode=list:longest,list:full
set visualbell
" set cursorline
set mouse=a
set number
set ignorecase                                      " make searches case-sensitive only if they contain upper-case characters
set smartcase
set gdefault                                        " gdefault applies substitutions globally on lines
set showmatch
set hlsearch
set modelines=5
set pastetoggle=<F2>
set listchars=tab:▸\·,trail:·,eol:¬
set showbreak=…
set tabstop=8                                       " make literal tabs clearly visible
set softtabstop=2
set shiftwidth=2
set expandtab
set autoread                                        " If a file is changed outside of vim, automatically reload it without asking
set nojoinspaces                                    " Insert only one space when joining lines that contain sentence-terminating punctuation like `.`.
set nowrap
set splitbelow splitright                           " Open new split panes to right and bottom, which feels more natural

" colors
set background=dark
colorscheme hybrid_material

" providers
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/anaconda3/bin/python3'

" folding
set foldlevelstart=0
set foldcolumn=2
nnoremap <Space> za
vnoremap <Space> za

" statusline
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let mapleader = ','

nnoremap / /\v
vnoremap / /\v
nnoremap <leader>ev :tabedit $MYVIMRC<cr>

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
nnoremap <leader><leader> <c-^>

" Quicker line movement
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" inoremap <C-j> <Esc>:m .+1<CR>==gi
" inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Quicker tab movement
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprev<CR>

nnoremap <leader>q gqip                                     " hard rewrap parahraph
nnoremap <leader>v V`]                                      " reselect the text that was just pasted

nmap <F2> ^y$:<C-R>"<CR>
map <F5> :set nowrap!<CR>
map <F6> :set spell!<CR>

nmap <Leader>p :call <SID>SynStack()<CR>
map <leader>n :call RenameFile()<cr>

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" fugitive
map <leader>d :Gdiff<cr>

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

autocmd BufWritePre * :%s/\s\+$//e

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

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

function! MapCR()
  nnoremap <cr> :nohl<cr>
endfunction
call MapCR()

function! <SID>SynStack() " Show syntax highlighting groups for word under cursor
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" deoplete
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option({
"       \  'max_list': 100,
"       \  'smart_case': v:true,
"       \})

" vim-go
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

" syntastic
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1

" ultisnips
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" emmet
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" elm-vim
let g:elm_jump_to_error = 0
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 0
let g:elm_syntastic_show_warnings = 0
let g:elm_browser_command = ""
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 0
let g:elm_setup_keybindings = 1

" ale
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-endwise'
  Plug 'fatih/vim-go'
  Plug 'vim-scripts/tComment'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'kristijanhusak/vim-hybrid-material'

  Plug 'w0rp/ale'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  Plug 'airblade/vim-gitgutter'
  Plug 'elmcast/elm-vim'

  " Completion
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  " Ruby
  Plug 'vim-ruby/vim-ruby', {'type':'opt'}

  " Markdown
  Plug 'nelstrom/vim-markdown-folding'

  " HTML / JS / React
  Plug 'pangloss/vim-javascript'
  Plug 'mattn/emmet-vim'

  " Elixir
  Plug 'elixir-editors/vim-elixir'

  " Reason ML
  Plug 'reasonml-editor/vim-reason-plus'
call plug#end()
