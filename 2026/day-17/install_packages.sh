#!/bin/bash

packages=("nginx" "wget" "php")

for i in ${packages[@]}; do
    if dpkg -s $i > /dev/null 2>&1; then
        echo "$1 : Already installed"
    else
        sudo apt install $i
    fi
done

echo "Competed instalation of pkgs"
