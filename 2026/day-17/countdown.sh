#!/bin/bash

read -p "enter countdown num" NUM

while [ $NUM -ge 0 ]; do
    echo "$NUM"
    ((NUM--))
done

echo "Done!"

