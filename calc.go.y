/* Copyright 2019 <chaishushan{AT}gmail.com>. All rights reserved. */
/* Use of this source code is governed by a Apache */
/* license that can be found in the LICENSE file. */

/* simplest version of calculator */

%{
package main

import (
	"fmt"
	"log"
)
%}

%union {
	value int
}

%type  <value> exp factor term

%token <value> NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

%%
calclist
	: /* nothing */
	| calclist exp EOL { fmt.Printf("= %v\n", $2); }

exp
	: factor         { $$ = $1; }
	| exp ADD factor { $$ = $1 + $3; }
	| exp SUB factor { $$ = $1 - $3; }

factor
	: term            { $$ = $1; }
	| factor MUL term { $$ = $1 * $3; }
	| factor DIV term { $$ = $1 / $3; }

term
	: NUMBER   { $$ = $1; }
	| ABS term {
		if $2 >= 0 {
			$$ = $2
		} else {
			$$ = -$2
		}
	}

%%

type calcLex struct {
	data []byte
}

func newCalcLexer(data []byte) *calcLex {
	yyScanBytes([]byte(data))
	return &calcLex{
		data: data,
	}
}

// The parser calls this method to get each new token. This
// implementation returns operators and NUM.
func (x *calcLex) Lex(yylval *calcSymType) int {
	tok, val := yyLex()
	if tok == 0 {
		return 0
	}

	switch tok {
	case yyToken_NUMBER:
		yylval.value = val.(int)
		return NUMBER
	case yyToken_ADD:
		return ADD
	case yyToken_SUB:
		return SUB
	case yyToken_MUL:
		return MUL
	case yyToken_DIV:
		return DIV
	case yyToken_ABS:
		return ABS
	case yyToken_EOL:
		return EOL
	}

	return 0
}

// The parser calls this method on a parse error.
func (x *calcLex) Error(s string) {
	log.Printf("parse error: %s", s)
}