" Vim color file
" Maintainer:	Shawn Axsom
" Last Change:	2017-06-04 21:04:17 EDT
" Version:	1.0

" This color scheme is inspired by predawn.vim, and based on void.vim (Andrew Lyon <orthecreedence@gmail.com>).
" void.vim was in turn based off of desert.vim (Hans Fugal <hans@fugal.net>),
" and mixed with some of slate.vim (Ralph Amissah <ralph@amissah.com>).

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="null"


hi Normal	guifg=#e0e0e0 guibg=grey9 ctermbg=235 ctermfg=253

" highlight groups
hi Cursor	guibg=khaki guifg=slategrey
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit	guibg=black guifg=black gui=none
hi Folded	guibg=grey30 guifg=gold
hi FoldColumn	guibg=grey30 guifg=tan
hi IncSearch	guifg=slategrey guibg=khaki
"hi LineNr
hi ModeMsg	guifg=goldenrod
hi MoreMsg	guifg=SeaGreen
hi NonText	guifg=LightBlue guibg=grey9
hi Question	guifg=springgreen
hi Search	guibg=peru guifg=wheat
hi SpecialKey	guifg=yellowgreen
hi StatusLine	guibg=black guifg=#cccccc gui=none
hi StatusLineNC	guibg=black guifg=grey40 gui=none
hi Title	guifg=indianred
hi Visual	gui=none guifg=khaki guibg=olivedrab
"hi VisualNOS
hi WarningMsg	guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" syntax highlighting groups
hi Comment	guifg=grey50 ctermfg=65
hi Constant	guifg=#e09085 ctermfg=222
hi Identifier	guifg=#d0d0b0
hi Statement	guifg=#ccaa88 gui=bold cterm=bold term=bold
"hi Statement	guifg=darkkhaki
hi PreProc	guifg=#c8e0b0
hi Type		guifg=#99cccc term=NONE cterm=NONE gui=NONE
hi Special	guifg=#bbccee cterm=bold term=bold
hi Operator guifg=navajowhite cterm=NONE
"hi Underlined
hi Ignore	guifg=grey40
"hi Error
hi Todo		guifg=orangered guibg=yellow2
hi Todo		guifg=orange guibg=gray40

" Fuf/menu stuff
hi Pmenu		guifg=#aadddd guibg=#333333
hi PmenuSel		guifg=#ddeeee guibg=#335533

" color terminal definitions
hi SpecialKey	ctermfg=darkgreen
hi NonText	guibg=grey9 cterm=bold ctermfg=darkblue
hi Directory	ctermfg=brown  guifg=#ddbb66
hi ErrorMsg	cterm=bold ctermfg=7 ctermbg=1
hi IncSearch	cterm=NONE ctermfg=yellow ctermbg=green
hi Search	cterm=NONE ctermfg=grey ctermbg=blue
hi MoreMsg	ctermfg=darkgreen
hi ModeMsg	cterm=NONE ctermfg=brown
hi LineNr guifg=grey50 ctermfg=251
hi Question	ctermfg=green
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit	cterm=reverse
hi Title	ctermfg=191
hi Visual	cterm=reverse
hi VisualNOS	cterm=bold,underline
hi WarningMsg	ctermfg=1
hi WildMenu	ctermfg=0 ctermbg=3
hi Folded	ctermfg=139 ctermbg=NONE
hi FoldColumn	ctermfg=darkgrey ctermbg=NONE
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=1
hi Special	ctermfg=3
" hi Identifier	ctermfg=158
" hi Identifier	ctermfg=117
hi Identifier	ctermfg=74
" hi Statement	ctermfg=3
hi Statement	ctermfg=227
hi PreProc	ctermfg=209
hi Type		ctermfg=79
hi Underlined	cterm=underline ctermfg=5
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=darkgrey
hi Error	cterm=bold ctermfg=7 ctermbg=1
hi Operator	cterm=bold ctermfg=229
hi String 	ctermfg=196 ctermbg=NONE cterm=NONE guifg=#bddcdc guibg=NONE gui=NONE

" python specific highlighting
hi link pythonOperator Statement

" javascript specific highlighting
hi javaScriptObjectKey     ctermfg=185
hi javaScriptBrowserObjects ctermfg=157
hi javaScriptDOMObjects ctermfg=112
hi javaScriptDOMMethods ctermfg=193
hi javaScriptGlobalObjects ctermfg=118
hi xmlTagName              ctermfg=86
hi xmlEndTag               ctermfg=81
hi xmlAttrib               ctermfg=158
hi xmlRegion               ctermfg=230
