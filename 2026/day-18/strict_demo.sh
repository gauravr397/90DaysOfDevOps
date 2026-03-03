#!/bin/bash

set -eou

b=2

echo "($b + $b)"
echo "fail"

check_disk() {
    disk_usg=$(df -h /)
    echo "$disk_usg"
}

check_mem() {
    mem_usg=$(free -h)
    echo "$mem_usg"
}

check_disk
check_mem
