#!/bin/bash

set -euo pipefail
host() {
    echo "Host details"
    hostnamectl 
}

chk_uptime() {
    uptime
}

disk_usg() {
    echo "disk usg"
    df -h | sort -hr | head -5
}

check_mem() {
    echo "mem usg"
    free -h
}

check_cpu() {
    echo "top cpu usg"
    ps aux --sort=-%cpu | head -5
}


host
uptime
disk_usg
check_mem
check_cpu
