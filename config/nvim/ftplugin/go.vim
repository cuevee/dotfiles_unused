nmap <leader>x <Plug>(go-run)
nmap <leader>b <Plug>(go-build)
nmap <leader>t <Plug>(go-test)
nmap <leader>c <Plug>(go-coverage)

nmap <C-]> <Plug>(go-def)
nmap <leader>ds <Plug>(go-def-split)
nmap <leader>dv <Plug>(go-def-vertical)
nmap <leader>dt <Plug>(go-def-tab)

nmap <leader>gd <Plug>(go-doc)
nmap <leader>gv <Plug>(go-doc-vertical)

nmap <leader>i <Plug>(go-info)
nmap <leader>e <Plug>(go-rename)

nmap <leader>rt <Plug>(go-run-tab)
nmap <leader>rs <Plug>(go-run-split)
nmap <leader>rv <Plug>(go-run-vertical)

setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" let g:go_term_mode = "split"

let g:syntastic_go_checkers = ['gometalinter', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
