" highligh group setting
let s:ref=synIDattr(synIDtrans(hlID("PreProc")), "fg#")
hi @lsp.type.parameter gui=italic
hi link cStorageClass Statement
hi link cStructure Statement
hi link cppStructure Statement
exec 'hi cConditional gui=italic guifg=' . s:ref
hi link cRepeat cConditional
hi link cLabel cRepeat
syntax keyword cPrimitive bool char short int long unsigned signed float double void
hi link cPrimitive Statement
syn keyword cControl return break continue
exec 'hi cControl gui=italic guifg='.s:ref
syn match cPunctuation "\(\*\|\,\|\;\|&\|->\|\.\|:\)"
hi link cPunctuation PreProc
syn match cNormalOperator "\(=\|<\|>\)"
hi link cNormalOperator PreProc
