#!/bin/bash

set -e

src_dir="/home/gr/Projects/TWS/90DaysOfDevOps/2026/day-19/logs"
dest_dir="/home/gr/Projects/TWS/90DaysOfDevOps/2026/day-19/backups"
main_log="$dest_dir/maintainace.logs"


curent_date=$(date +"%Y%m%d_%H:%M:%S")

backup_sh() {
    echo "[$curent_date] starting log bkp" >> "$main_log"
    #find "$src_dir" -name "*.log" -type f -mtime +0 -exec tar -cvzf "$dest_dir/backup_${current_date}_logs.tar.gz" {} +
    echo "[$curent_date] Total num of file will be compress : $(ls -lrth | wc -l )" >> "$main_log"
    echo "[$curent_date] Files : $(ls -lrth $src_dir)" >> "$main_log"

    find "$src_dir" -name "*.log" -type f -mmin +1 -exec tar -cvzf "$dest_dir/backup_${curent_date}_logs.tar.gz" {} +

    echo "[$curent_date] completed ..." >> "$main_log"

    echo "[$curent_date] $(ls -lrth $dest_dir)" >> "$main_log"
}

backup_sh