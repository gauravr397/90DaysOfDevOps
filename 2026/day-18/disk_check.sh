#!/bin/bash

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

