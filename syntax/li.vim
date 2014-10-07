" Vim syntax file
" Language:	Casey's Lisp
" Last Change:	2014 October 7
" Maintainer:   Casey Dwyer <caseydwyer@gmail.com>	

" Initializing:

" Fascist highlighting: everything that doesn't fit the rules is an error...

syn match	liError	![^ \t()\[\]";]*!
syn match	liError	")"

" Quoted and backquoted stuff

syn region liQuoted matchgroup=Delimiter start="['`]" end=![ \t()\[\]";]!me=e-1 contains=ALLBUT,liStruc,liSyntax,liFunc

syn region liQuoted matchgroup=Delimiter start="['`](" matchgroup=Delimiter end=")" contains=ALLBUT,liStruc,liSyntax,liFunc
syn region liQuoted matchgroup=Delimiter start="['`]%(" matchgroup=Delimiter end=")" contains=ALLBUT,liStruc,liSyntax,liFunc

syn region liStrucRestricted matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALLBUT,liStruc,liSyntax,liFunc
syn region liStrucRestricted matchgroup=Delimiter start="%(" matchgroup=Delimiter end=")" contains=ALLBUT,liStruc,liSyntax,liFunc

" Popular scheme extension:
" using [] as well as ()
syn region liStrucRestricted matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALLBUT,liStruc,liSyntax,liFunc
syn region liStrucRestricted matchgroup=Delimiter start="%\[" matchgroup=Delimiter end="\]" contains=ALLBUT,liStruc,liSyntax,liFunc

syn region liUnquote matchgroup=Delimiter start="," end=![ \t\[\]()";]!me=e-1 contains=ALLBUT,liStruc,liSyntax,liFunc
syn region liUnquote matchgroup=Delimiter start=",@" end=![ \t\[\]()";]!me=e-1 contains=ALLBUT,liStruc,liSyntax,liFunc

syn region liUnquote matchgroup=Delimiter start=",(" end=")" contains=ALL
syn region liUnquote matchgroup=Delimiter start=",@(" end=")" contains=ALL

syn region liUnquote matchgroup=Delimiter start=",%(" end=")" contains=ALLBUT,liStruc,liSyntax,liFunc
syn region liUnquote matchgroup=Delimiter start=",@%(" end=")" contains=ALLBUT,liStruc,liSyntax,liFunc

syn region liUnquote matchgroup=Delimiter start=",\[" end="\]" contains=ALL
syn region liUnquote matchgroup=Delimiter start=",@\[" end="\]" contains=ALL

syn region liUnquote matchgroup=Delimiter start=",%\[" end="\]" contains=ALLBUT,liStruc,liSyntax,liFunc
syn region liUnquote matchgroup=Delimiter start=",@%\[" end="\]" contains=ALLBUT,liStruc,liSyntax,liFunc

" li Functions and Syntax:

if version < 600
  set iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
else
  setlocal iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
endif

" scheme stuff
set lispwords+=syntax-rules
syn keyword liSyntax lambda and or if cond case def define let let* letrec
syn keyword liSyntax begin do delay set! else =>
syn keyword liSyntax quote quasiquote unquote unquote-splicing
syn keyword liSyntax assert defmacro import named-lambda
syn keyword liSyntax define-syntax syntax-rules

syn keyword liFunc make-list list-set! string->vector vector->string
syn keyword liFunc not boolean? eq? eqv? equal? pair? cons car cdr set-car!
syn keyword liFunc set-cdr! caar cadr cdar cddr caaar caadr cadar caddr
syn keyword liFunc cdaar cdadr cddar cdddr caaaar caaadr caadar caaddr
syn keyword liFunc cadaar cadadr caddar cadddr cdaaar cdaadr cdadar cdaddr
syn keyword liFunc cddaar cddadr cdddar cddddr null? list? list length
syn keyword liFunc append reverse list-ref memq memv member assq assv assoc
syn keyword liFunc symbol? symbol->string string->symbol number? complex?
syn keyword liFunc real? rational? integer? exact? inexact? = < > <= >=
syn keyword liFunc zero? positive? negative? odd? even? max min + * - / abs
syn keyword liFunc quotient remainder modulo gcd lcm numerator denominator
syn keyword liFunc floor ceiling truncate round rationalize exp log sin cos
syn keyword liFunc tan asin acos atan sqrt expt make-rectangular make-polar
syn keyword liFunc real-part imag-part magnitude angle exact->inexact
syn keyword liFunc inexact->exact number->string string->number char=?
syn keyword liFunc char-ci=? char<? char-ci<? char>? char-ci>? char<=?
syn keyword liFunc char-ci<=? char>=? char-ci>=? char-alphabetic? char?
syn keyword liFunc char-numeric? char-whitespace? char-upper-case?
syn keyword liFunc char-lower-case?
syn keyword liFunc char->integer integer->char char-upcase char-downcase
syn keyword liFunc string? make-string string string-length string-ref
syn keyword liFunc string-set! string=? string-ci=? string<? string-ci<?
syn keyword liFunc string>? string-ci>? string<=? string-ci<=? string>=?
syn keyword liFunc string-ci>=? substring string-append vector? make-vector
syn keyword liFunc vector vector-length vector-ref vector-set! procedure?
syn keyword liFunc apply map for-each call-with-current-continuation
syn keyword liFunc call-with-input-file call-with-output-file input-port?
syn keyword liFunc output-port? current-input-port current-output-port
syn keyword liFunc open-input-file open-output-file close-input-port
syn keyword liFunc close-output-port eof-object? read read-char peek-char
syn keyword liFunc write display newline write-char call/cc
syn keyword liFunc list-tail string->list list->string string-copy
syn keyword liFunc string-fill! vector->list list->vector vector-fill!
syn keyword liFunc force with-input-from-file with-output-to-file
syn keyword liFunc char-ready? load transcript-on transcript-off eval
syn keyword liFunc dynamic-wind port? values call-with-values
syn keyword liFunc li-report-environment null-environment
syn keyword liFunc interaction-environment
" R6RS
syn keyword liFunc make-eq-hashtable make-eqv-hashtable make-hashtable
syn keyword liFunc hashtable? hashtable-size hashtable-ref hashtable-set!
syn keyword liFunc hashtable-delete! hashtable-contains? hashtable-update!
syn keyword liFunc hashtable-copy hashtable-clear! hashtable-keys
syn keyword liFunc hashtable-entries hashtable-equivalence-function hashtable-hash-function
syn keyword liFunc hashtable-mutable? equal-hash string-hash string-ci-hash symbol-hash 
syn keyword liFunc find for-all exists filter partition fold-left fold-right
syn keyword liFunc remp remove remv remq memp assp cons*
" li
syn keyword liFunc clock error exit getenv rand remove renamed print system
syn keyword liFunc time

" ... so that a single + or -, inside a quoted context, would not be
" interpreted as a number (outside such contexts, it's a liFunc)

syn match	liDelimiter	!\.[ \t\[\]()";]!me=e-1
syn match	liDelimiter	!\.$!
" ... and a single dot is not a number but a delimiter

" This keeps all other stuff unhighlighted, except *stuff* and <stuff>:

syn match	liOther		,[A-Za-z!$%&*/:<=>?^_~+@#%-][-A-Za-z!$%&*/:<=>?^_~0-9+.@#%]*,
syn match	liError		,[A-Za-z!$%&*/:<=>?^_~+@#%-][-A-Za-z!$%&*/:<=>?^_~0-9+.@#%]*[^-A-Za-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syn match	liOther		"\.\.\."
syn match	liError		!\.\.\.[^ \t\[\]()";]\+!
" ... a special identifier

syn keyword	liConstant	true false null
syn match	liConstant	,\*[-A-Za-z!$%&*/:<=>?^_~0-9+.@]\+\*[ \t\[\]()";],me=e-1
syn match	liConstant	,\*[-A-Za-z!$%&*/:<=>?^_~0-9+.@]\+\*$,
syn match	liError		,\*[-A-Za-z!$%&*/:<=>?^_~0-9+.@]*\*[^-A-Za-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syn match	liConstant	,<[-A-Za-z!$%&*/:<=>?^_~0-9+.@]*>[ \t\[\]()";],me=e-1
syn match	liConstant	,<[-A-Za-z!$%&*/:<=>?^_~0-9+.@]*>$,
syn match	liError		,<[-A-Za-z!$%&*/:<=>?^_~0-9+.@]*>[^-A-Za-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

" Non-quoted lists, and strings:

syn region liStruc matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALL
syn region liStruc matchgroup=Delimiter start="%(" matchgroup=Delimiter end=")" contains=ALL

syn region liStruc matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALL
syn region liStruc matchgroup=Delimiter start="%\[" matchgroup=Delimiter end="\]" contains=ALL

" Simple literals:
syn region liString start=+\%(\\\)\@<!"+ skip=+\\[\\"]+ end=+"+

" Comments:

syn match	liComment	"[;#].*$"


" Writing out the complete description of numerals without
" using variables is a day's work for a trained secretary...

syn match	liOther		![+-][ \t\[\]()";]!me=e-1
syn match	liOther		![+-]$!
"
" This is a useful lax approximation:

syn match	liNumber	"[-+.]\=[0-9][-+/0-9]*"

"syn match	liError		![-+0-9.][-#+/0-9a-f@i.boxesfdl]*[^-#+/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*!

syn match	liBoolean	"\(true\|false\)"

syn match	liCharacter	"%\\"
syn match	liCharacter	"%\\."
syn match	liCharacter	"%\\space"
syn match	liCharacter	"%\\newline"

" R6RS
syn match liCharacter "%\\x[0-9a-fA-F]\+"

" Synchronization and the wrapping up...

syn sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_li_syntax_inits")
  if version < 508
    let did_li_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink liSyntax		Statement
  HiLink liFunc			Function

  HiLink liString		String
  HiLink liCharacter		Character
  HiLink liNumber		Number
  HiLink liBoolean		Boolean

  HiLink liDelimiter		Delimiter
  HiLink liConstant		Constant

  HiLink liComment		Comment
  HiLink liError		Error

  HiLink liExtSyntax		Type
  HiLink liExtFunc		PreProc
  delcommand HiLink
endif

let b:current_syntax = "li"
