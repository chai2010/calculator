// Copyright 2019 <chaishushan{AT}gmail.com>. All rights reserved.
// Use of this source code is governed by a Apache
// license that can be found in the LICENSE file.

package main

//#include "tok.h"
//#include "lex.yy.h"
import "C"

import (
	"log"
	"strconv"
)

type calcLex struct {
	data []byte
}

func newCalcLexer(data []byte) *calcLex {
	C.yy_scan_bytes(
		(*C.char)(C.CBytes(data)),
		C.yy_size_t(len(data)),
	)

	return &calcLex{
		data: data,
	}
}

// The parser calls this method to get each new token. This
// implementation returns operators and NUM.
func (x *calcLex) Lex(yylval *calcSymType) int {
	switch C.yylex() {
	case C.NUMBER:
		yylval.value, _ = strconv.Atoi(C.GoString(C.yytext))
		return NUMBER
	case C.ADD:
		return ADD
	case C.SUB:
		return SUB
	case C.MUL:
		return MUL
	case C.DIV:
		return DIV
	case C.ABS:
		return ABS
	case C.EOL:
		return EOL
	}

	return 0 // eof
}

// The parser calls this method on a parse error.
func (x *calcLex) Error(s string) {
	log.Printf("parse error: %s", s)
}
