let g:crystal_auto_format=1

noremap <leader>el :tabedit ~/.config/nvim/ftplugin/crystal.vim<cr>

noremap <leader>x :!crystal %<cr>

noremap <leader>ta :CrystalSpecRunAll<cr>
noremap <leader>tr :CrystalSpecRunCurrent<cr>

inoremap <C-l> <space>=><space>
