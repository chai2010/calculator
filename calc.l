/* Copyright 2019 <chaishushan{AT}gmail.com>. All rights reserved. */
/* Use of this source code is governed by a Apache */
/* license that can be found in the LICENSE file. */

%option noyywrap

%{
#include "tok.h"
%}

%%

[0-9]+ { return NUMBER; }

"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"|"    { return ABS; }
"("    { return LPAREN; }
")"    { return RPAREN; }

\n     { return EOL; }
[ \t]  { /* ignore whitespace */ }
.      { return ILLEGAL; }

%%

