map <leader>x :!elixir %<cr>
map <leader>s :!iex -S mix<cr>
map <leader>tu :execute("!mix test %:" . line("."))<cr>
map <leader>ta :!mix test<cr>
map <leader>tt :!mix test %<cr>
map <leader>tm :!mix test test/models<cr>

" imap <C-l> <space>-><space>
imap <C-h> <space><-<space>
imap <C-S-l> <space><bar>><space>

