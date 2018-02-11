package main

import (
    "bufio"
    "fmt"
    "os"
)

func main() {
    counts := make(map[string]int)
    sources := make(map[string]map[string]bool)
    files := os.Args[1:]
    if len(files) == 0 {
        countLines(os.Stdin, counts, sources, "Stdin")
    } else {
        for _, arg := range files {
            f, err := os.Open(arg)
            if err != nil {
                fmt.Fprintf(os.Stderr, "dup2: %v\n", err)
                continue
            }
            countLines(f, counts, sources, arg)
            f.Close()
        }
    }
    for line, n := range counts {
        if n > 1 {
            in, sep := "", ""
            for src, _ := range sources[line] {
                in += sep + src
                sep = " "
            }
            fmt.Printf("%d\t%s\n", n, line)
            fmt.Printf("\t%s\n", in)
        }
    }
}

func countLines(f *os.File, counts map[string]int, sources map[string]map[string]bool, file string) {
    input := bufio.NewScanner(f)
    for input.Scan() {
        counts[input.Text()]++

        if sources[input.Text()] == nil {
            sources[input.Text()] = make(map[string]bool)
        }
        sources[input.Text()][file] = true
    }
}
