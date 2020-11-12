" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
"Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

Plug 'HerringtonDarkholme/yats.vim' " TS Syntax

Plug 'vim-scripts/tComment'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'nelstrom/vim-markdown-folding'
Plug 'dart-lang/dart-vim-plugin' " Dart Syntax
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'vimwiki/vimwiki'

" Initialize plugin system
call plug#end()

" ===== SET =====
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
set cursorline

" set mouse=a
set number
set ignorecase                                      " make searches case-sensitive only if they contain upper-case characters
set smartcase
set gdefault                                        " gdefault applies substitutions globally on lines
set showmatch
set hlsearch
set modelines=5
" set pastetoggle=<F2>
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

set shortmess+=F " don't give |ins-completion-menu| messages.
set signcolumn=no " TODO @cuevee check this out as it could affect git gutter
set updatetime=300 " TODO @cuevee check this out
" ===== /SET =====

" ===== FOLDING =====
set foldlevelstart=0
set foldcolumn=2
nnoremap <Space> za
vnoremap <Space> za
" ===== /FOLDING =====

" ===== STATUSLINE =====
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set statusline+=%#warningmsg#
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=%*
set fillchars=stl:-,stlnc:-,vert:│,fold:·,diff:-
" ===== /STATUSLINE =====

" ===== LEADER AND MAPS =====
let mapleader = ','
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader><leader> <c-^>
nnoremap <leader>q gqip                                     " hard rewrap parahraph
nnoremap <leader>v V`]                                      " reselect the text that was just pasted
" nmap <F2> ^y$:<C-R>"<CR>                                    " paste toggle
map <F5> :set nowrap!<CR>                                   " quick wrap toggle
map <F6> :set spell!<CR>                                    " quick spell check toggle

nmap <Leader>p :call <SID>SynStack()<CR>
map <leader>n :call RenameFile()<cr>

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

map <leader>d :Gdiff<cr>                                    " fugitive map
" ===== /LEADER AND MAPS =====

" ===== AUTOCMDS =====
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " autocmd filetype ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  " autocmd filetype python set sw=4 sts=4 et

  " autocmd bufread *.md set ai formatoptions=tcroqn2 comments=n:&gt;
  " autocmd bufread,bufnewfile *.md setlocal textwidth=80

  autocmd bufread,bufnewfile *.dart setlocal textwidth=120

  " Setup formatexpr specified filetype(s).
  autocmd FileType javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  autocmd filetype markdown setlocal spell " enable spellchecking for markdow
  autocmd! filetype mkd setlocal syn=off   " don't syntax highlight markdown because it's often wrong

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " autocmd BufWritePre * :%s/\s\+$//e " TODO @cuevee check this out
augroup END
" ===== /AUTOCMDS =====

" ===== FUNCTIONS =====
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
" ===== /FUNCTIONS =====

" ===== QUICKER LINE MOVEMENT =====
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" ===== /QUICKER LINE MOVEMENT =====

" ===== QUICKER TAB MOVEMENT =====
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprev<CR>
" ===== /QUICKER TAB MOVEMENT =====

" ===== THEME AND COLORS =====
" set termguicolors
" let g:hybrid_custom_term_colors = 1
syntax enable
set background=dark
colorscheme hybrid_material
" ===== /THEME AND COLORS =====

" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync


" j/k will move virtual lines (lines that wrap)
" TODO: @cuevee check this out
" noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
" noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" ===== PLUGIN: dart-vim-plugin =====
let dart_format_on_save = 1
let dart_style_guide = 2
let dart_html_in_string=v:true
" ===== /PLUGIN: dart-vim-plugin =====

" ===== PLUGIN: vimwiki =====
let g:vimwiki_list = [{'path': '~/.vimwiki', 'syntax': 'markdown', 'ext': '.md', 'auto_toc': 1, 'links_space_char': '-',}]

" ===== /PLUGIN: vimwiki =====


" ===== PLUGIN: coc.nvim =====
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-fzf-preview',
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh() " Use <c-space> to trigger completion.

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" ===== /PLUGIN: coc.nvim =====

" ===== MORE MAPS ===== TODO @cuevee move these
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold TODO @cuevee find a place for this
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver. TODO @cuevee check this out
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" ===== /MORE MAPS ===== TODO @cuevee move these

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" FIXME: @cuevee re-enable Coc with spaceless trigger leader
" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
