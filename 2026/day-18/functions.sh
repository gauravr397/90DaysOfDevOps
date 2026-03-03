#!/bin/bash

greet() {
    echo "Hello $1 !"
}

Sum() {
    sum=$(($1 + $2))
    echo "sum is : $sum"
}

greet raghav
Sum 3 8