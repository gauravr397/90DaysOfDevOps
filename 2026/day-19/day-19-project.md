# Shell Scripting Project: Log Rotation, Backup & Crontab

## Overview
Today I applied my shell scripting knowledge to create a real-world automation tool. I built a script that automates log backups, compresses them into archives, and logs the maintenance activity. Finally, I scheduled this script using `crontab`.

---

## Task 1 & 2: Automated Backup & Log Rotation Script

I created a script named `log_rotate.sh` that performs the following actions:
1.  Defines source and destination directories.
2.  Creates a timestamped entry in a maintenance log file.
3.  Identifies log files older than a specific time (used `-mmin +1` for testing purposes).
4.  Compresses these files into a `.tar.gz` archive with a timestamp.
5.  Logs the success and lists the backup files.

### The Script: `log_rotate.sh`

```bash
#!/bin/bash

set -e

# Define directories using absolute paths (crucial for Cron)
src_dir="/home/gr/Projects/TWS/90DaysOfDevOps/2026/day-19/logs"
dest_dir="/home/gr/Projects/TWS/90DaysOfDevOps/2026/day-19/backups"
main_log="$dest_dir/maintainace.logs"

curent_date=$(date +"%Y%m%d_%H:%M:%S")

backup_sh() {
    echo "[$curent_date] starting log bkp" >> "$main_log"
    
    # Log the count of files before processing
    echo "[$curent_date] Total num of file will be compress : $(ls -lrth "$src_dir" | wc -l )" >> "$main_log"
    echo "[$curent_date] Files : $(ls -lrth "$src_dir")" >> "$main_log"

    # Find files modified more than 1 minute ago (for testing) and compress them
    find "$src_dir" -name "*.log" -type f -mmin +1 -exec tar -cvzf "$dest_dir/backup_${curent_date}_logs.tar.gz" {} +

    echo "[$curent_date] completed ..." >> "$main_log"
    
    # List new backups in the log
    echo "[$curent_date] $(ls -lrth "$dest_dir")" >> "$main_log"
}

# Execute the function
backup_sh
```

---

## Execution & Output

### 1. Setup
I created a `logs` directory and populated it with dummy log files (`sample.log` to `sample6.log`) to test the rotation.

### 2. Running the Script
I ran the script manually to verify it works.

**Terminal Output:**
```bash
$ ./log_rotate.sh
tar: Removing leading `/' from member names
/home/gr/Projects/TWS/90DaysOfDevOps/2026/day-19/logs/sample2.log
/home/gr/Projects/TWS/90DaysOfDevOps/2026/day-19/logs/sample.log
...
completed ...
```

### 3. Verification
I checked the `backups` directory to ensure archives were created.

```bash
$ ls -lrth backups
total 124K
-rw-rw-r-- 1 gr gr 276 Mar  4 14:03 backup__logs.tar.gz
-rw-rw-r-- 1 gr gr 276 Mar  4 14:36 backup_20260304_logs.tar.gz
...
-rw-rw-r-- 1 gr gr 276 Mar  4 16:19 backup_20260304_16:19:01_logs.tar.gz
-rw-rw-r-- 1 gr gr 27K Mar  4 16:19 maintainace.logs
```

### 4. Maintenance Log Check
I verified that the script correctly logged its activities to `maintainace.logs`.

```text
[20260304_15:58:45] starting log bkp
[20260304_15:58:45] Total num of file will be compress : 6
[20260304_15:58:45] Files : total 24K
...
[20260304_15:58:45] completed ...
```

---

## Task 3: Crontab Scheduling

I configured the script to run automatically using `crontab`.

### 1. View Current Cron Jobs
```bash
crontab -l
```

### 2. My Cron Entry
I scheduled the script to run at **1:00 AM every day**.

```cron
0 1 * * * /home/gr/Projects/TWS/90DaysOfDevOps/2026/day-19/log_rotate.sh
```

### 3. Understanding Cron Syntax
Per the challenge requirements, here is how other schedules would look:

*   **Run log_rotate.sh every day at 2 AM:**
    `0 2 * * * /path/to/script.sh`
*   **Run backup.sh every Sunday at 3 AM:**
    `0 3 * * 0 /path/to/script.sh` (0 = Sunday)
*   **Run a health check every 5 minutes:**
    `*/5 * * * * /path/to/script.sh`

---
