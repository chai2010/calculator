// Copyright 2019 <chaishushan{AT}gmail.com>. All rights reserved.
// Use of this source code is governed by a Apache
// license that can be found in the LICENSE file.

package main

//#include "calc.tab.h"
//#include "lex.yy.h"
//
//extern int yyparse();
import "C"

import (
	"fmt"
)

type yyToken int

const (
	yyToken_NUMBER = yyToken(C.NUMBER)
	yyToken_ADD    = yyToken(C.ADD)
	yyToken_SUB    = yyToken(C.SUB)
	yyToken_MUL    = yyToken(C.MUL)
	yyToken_DIV    = yyToken(C.DIV)
	yyToken_ABS    = yyToken(C.ABS)
	yyToken_EOL    = yyToken(C.EOL)
)

var yyToken_names = map[yyToken]string{
	yyToken_NUMBER: "NUMBER",
	yyToken_ADD:    "ADD",
	yyToken_SUB:    "SUB",
	yyToken_MUL:    "MUL",
	yyToken_DIV:    "DIV",
	yyToken_ABS:    "ABS",
	yyToken_EOL:    "EOL",
}

func (tok yyToken) String() string {
	if s, ok := yyToken_names[tok]; ok {
		return s
	}
	return fmt.Sprintf("yyToken %d", int(tok))
}

func yyScanBytes(data []byte) {
	C.yy_scan_bytes(
		(*C.char)(C.CBytes(data)),
		C.yy_size_t(len(data)),
	)
}

func yyLex() (tok yyToken, val interface{}) {
	tok = yyToken(C.yylex())
	val = int(C.yylval)
	return
}

func yyParse() int {
	return int(C.yyparse())
}
