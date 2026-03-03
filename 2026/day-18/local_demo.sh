#!/bin/bash

func_local() {
    local a=2
    b=3
    echo "sum inside local : $a + $b"
}
func_local
echo "outside func : $a"


