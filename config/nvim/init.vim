" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
" Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Plug 'HerringtonDarkholme/yats.vim' " TS Syntax

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

Plug 'vim-scripts/tComment'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'nelstrom/vim-markdown-folding'
Plug 'dart-lang/dart-vim-plugin' " Dart Syntax
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'

Plug 'vim-crystal/vim-crystal'

Plug 'ap/vim-css-color'

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
set splitright splitbelow                           " Open new split panes to right and bottom, which feels more natural

set shortmess+=F " don't give |ins-completion-menu| messages.
set signcolumn=no " TODO @cuevee check this out as it could affect git gutter
set updatetime=300 " TODO @cuevee check this out

set spellfile=~/.config/nvim/spell/en.utf-8.add

set rtp+=/usr/local/opt/fzf

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
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
" set statusline+=%*
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=\ %{FugitiveStatusline()}
set fillchars=stl:-,stlnc:-,vert:│,fold:·,diff:-
" ===== /STATUSLINE =====

" ===== LEADER AND MAPS =====
let mapleader = ','
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>et :tabedit $HOME/.tmux.conf<cr>
nnoremap <leader>ea :tabedit $HOME/.config/alacritty/alacritty.yml<cr>
nnoremap <leader><leader> <c-^>
nnoremap <leader>q gqip                                     " hard rewrap parahraph
nnoremap <leader>v V`]                                      " reselect the text that was just pasted
nmap <F2> ^y$:<C-R>"<CR>                                    " paste toggle
map <F5> :set nowrap!<CR>                                   " quick wrap toggle
map <F6> :set spell!<CR>                                    " quick spell check toggle

" nmap <Leader>p :call <SID>SynStack()<CR>
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

  autocmd filetype python set sw=4 sts=4 et

  " autocmd bufread *.md set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  autocmd BufRead,BufNewFile *.py setlocal textwidth=80
  autocmd BufRead,BufNewFile *.dart setlocal textwidth=120

  " Setup formatexpr specified filetype(s).
  autocmd FileType javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd FileType python setl formatexpr=CocAction('formatSelected')

  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  " autocmd filetype markdown setlocal spell columns=78  " enable spellchecking for markdow
  autocmd! filetype mkd setlocal syn=off   " don't syntax highlight markdown because it's often wrong

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " autocmd BufWritePre * :%s/\s\+$//e " TODO @cuevee check this out
augroup END

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
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

" function! <SID>SynStack() " Show syntax highlighting groups for word under cursor
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc
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

" ===== PLUGIN: coc.nvim =====
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" \ 'coc-eslint',
" \ 'coc-toml',
let g:coc_global_extensions = [
  \ 'coc-fzf-preview',
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.

inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:python_host_prog='$HOME/.pyenv/shims/python2'
let g:python3_host_prog='$HOME/.pyenv/shims/python3'

let g:coc_snippet_next = '<tab>'

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
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
xmap <leader>ac  <Plug>(coc-codeaction)
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
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

