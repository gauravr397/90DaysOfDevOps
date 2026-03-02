#!/bin/bash

read -p "enter the service to check" SERVICE
read -p "enter the Y to check" YES

if [ "$YES" == "Y" ]; then
    sudo systemctl status $SERVICE
else
    echo "Skipped"
fi

