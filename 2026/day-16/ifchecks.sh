#!/bin/bash

a=10
b=20

if [ -f "/etc/passwd" ]; then
    echo "File exist"
else
    echo "Does not exist"
fi

if [ $a -gt $b ]; then
    echo "$a is greater"
else
    echo "$b is greater"
fi