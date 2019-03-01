/* Copyright 2019 <chaishushan{AT}gmail.com>. All rights reserved. */
/* Use of this source code is governed by a Apache */
/* license that can be found in the LICENSE file. */

/* simplest version of calculator */

%{
package main

import (
	"fmt"
)
%}

%union {
	value int
}

%type  <value> exp factor term

%token <value> NUMBER
%token ADD SUB MUL DIV ABS
%token LPAREN RPAREN
%token EOL

%%
calclist
	: // nothing
	| calclist exp EOL { fmt.Printf("= %v\n", $2) }

exp
	: factor         { $$ = $1 }
	| exp ADD factor { $$ = $1 + $3 }
	| exp SUB factor { $$ = $1 - $3 }

factor
	: term            { $$ = $1 }
	| factor MUL term { $$ = $1 * $3 }
	| factor DIV term { $$ = $1 / $3 }

term
	: NUMBER            { $$ = $1 }
	| ABS term          { if $2 >= 0 { $$ = $2 } else { $$ = -$2 } }
	| LPAREN exp RPAREN { $$ = $2 }

%%
