// Copyright 2019 <chaishushan{AT}gmail.com>. All rights reserved.
// Use of this source code is governed by a Apache
// license that can be found in the LICENSE file.

package main

import (
	"bufio"
	"io"
	"log"
	"os"
)

func main() {
	br := bufio.NewReader(os.Stdin)
	for {
		line, err := br.ReadString('\n')
		if err != nil {
			// ^D: Input end of file on Unix/Linux
			// ^Z: Input end of file on Windows
			if err == io.EOF {
				return
			}
			log.Fatal(err)
		}

		// quit
		if s := string(line); s == "q" || s == "quit" || s == "exit" {
			return
		}

		yyScanBytes([]byte(line))
		yyParse()
	}
}
