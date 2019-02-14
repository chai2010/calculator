/* Copyright 2019 <chaishushan{AT}gmail.com>. All rights reserved. */
/* Use of this source code is governed by a Apache */
/* license that can be found in the LICENSE file. */

/* simplest version of calculator */

%{
#include <stdio.h>

extern int yylex();
extern void yyerror(const char* msg);
%}

/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

%%
calclist
	: /* nothing */
	| calclist exp EOL { printf("= %d\n", $2); }
	;
exp
	: factor /* default $$ = $1 */
	| exp ADD factor {
		$$ = $1 + $3;
	}
	| exp SUB factor { $$ = $1 - $3; }
	;
factor
	: term /* default $$ = $1 */
	| factor MUL term { $$ = $1 * $3; }
	| factor DIV term { $$ = $1 / $3; }
	;
term
	: NUMBER {
		$$ = $1;
	}
	| ABS term { $$ = $2 >= 0? $2 : - $2; }
	;

%%

void yyerror(const char* msg) {
	fprintf(stderr, "yyerror: %s\n", msg);
}
