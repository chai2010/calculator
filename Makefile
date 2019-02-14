# Copyright 2019 <chaishushan{AT}gmail.com>. All rights reserved.
# Use of this source code is governed by a Apache
# license that can be found in the LICENSE file.

run: lex.yy.c
	make flex
	make bison
	@go fmt
	@go vet
	go run .

flex:
	flex --prefix=yy --header-file=lex.yy.h calc.l

bison:
	bison -d calc.y

lex.yy.c: calc.l
	flex calc.l

clean:
	-rm lex.yy.c
