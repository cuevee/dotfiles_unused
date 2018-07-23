" Version:      1.0
" Maintainer:	Henrique C. Alves (hcarvalhoalves@gmail.com)
" Last Change:	September 25 2008

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "mustang"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine ctermbg=234 cterm=bold
	hi CursorColumn ctermbg=234
  hi MatchParen ctermfg=157 ctermbg=237 cterm=bold
  hi Pmenu 		ctermfg=255 ctermbg=238
  hi PmenuSel 	ctermfg=0 ctermbg=148
endif

" General colors
hi Cursor 		ctermbg=241
hi Normal 		ctermfg=253 ctermbg=234
hi NonText 		ctermfg=253 ctermbg=234
hi CursorLineNr 		ctermfg=white
hi LineNr 		ctermfg=240
hi StatusLine 	ctermfg=160 ctermbg=234 cterm=none
hi StatusLineNC ctermfg=244 ctermbg=234 cterm=none
hi VertSplit 	ctermfg=234 ctermbg=238
hi HorizSplit 	ctermfg=234 ctermbg=238
hi Folded 		ctermbg=235 ctermfg=248
hi Title		ctermfg=254 cterm=bold
hi Visual		ctermfg=16 ctermbg=4
hi SpecialKey	ctermfg=244 ctermbg=236

" Syntax highlighting
hi Comment 		ctermfg=244
hi Todo 		ctermfg=247 ctermbg=236
hi Boolean      ctermfg=148
hi String 		ctermfg=148
hi Identifier 	ctermfg=148
hi Function 	ctermfg=255
hi Type 		ctermfg=103
hi Statement 	ctermfg=103
hi Keyword		ctermfg=208
hi Constant 	ctermfg=208
hi Number		ctermfg=208
hi Special		ctermfg=208
hi PreProc 		ctermfg=230
hi Todo         gui=italic

" Code-specific colors
" python
hi pythonOperator ctermfg=103

" elixir
hi elixirDocString 		ctermfg=244

hi Search     ctermfg=yellow ctermbg=none cterm=underline

