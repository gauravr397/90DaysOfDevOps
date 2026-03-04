# Bash Scripting Challenge: Log Analyzer and Report Generator

## Overview
Today I built a **Log Analyzer Script** using Bash. The goal was to parse a system log file, extract critical information (like error counts and critical events), and generate a summary report automatically. This automates the tedious task of manually reading logs.

---

## The Solution Script (`log_analyzer.sh`)

Here is the final script I wrote. It performs input validation, counts specific keywords using `grep`, extracts the most frequent error messages using `sed` and `uniq`, and saves everything to a timestamped report.

```bash
#!/bin/bash

# 1. Input Validation
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE="$1"

if [ ! -e "$LOG_FILE" ]; then
    echo "Error: Log file '$LOG_FILE' does not exist."
    exit 1
fi

# Variables for Report Generation
CURRENT_DATE=$(date +"%Y%m%d_%H:%M:%S")
REPORT_FILE="log_report_${CURRENT_DATE}.txt"

# 2. Count Total Errors (Case insensitive search for "ERROR" or "Failed")
ERROR_COUNT=$(grep -c -i "ERROR" "$LOG_FILE")

# 3. List Critical Events (with line numbers)
CRITICAL_EVENTS=$(grep -n "CRITICAL" "$LOG_FILE")

# 4. Top 5 Error Messages
# Logic: Find lines with ERROR -> Extract message part -> Sort -> Count unique -> Sort desc -> Top 5
TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" | sed -E 's/.*\[ERROR\] (.*) - [0-9]+$/\1/' | sort | uniq -c | sort -nr | head -5)

# --- Generate Summary Report ---

{
    echo "Date of analysis: $CURRENT_DATE"
    echo "Log file name: $LOG_FILE"
    echo "Total lines processed: $(wc -l < "$LOG_FILE")"
    echo "Total error count: $ERROR_COUNT"
    echo "-------------------------------------"
    echo "Top 5 error messages:"
    echo "$TOP_ERRORS"
    echo "-------------------------------------"
    echo "List of critical events with line numbers:"
    echo "$CRITICAL_EVENTS"
} > "$REPORT_FILE"

# --- Print to Console ---
echo "Analysis complete. Report generated: $REPORT_FILE"
cat "$REPORT_FILE"
```

---

## Execution & Output

### 1. Generating Sample Logs
First, I used the provided generator to create a dummy log file with 40 lines.
```bash
./sample_logs_generator.sh log_generated.logs 40
```
*Output:* `Log file created at: log_generated.logs with 40 lines.`

### 2. Running the Analyzer
I ran the script against the generated log file.
```bash
./log_analyzer.sh log_generated.logs
```

### 3. Console Output
The script analyzed the file and printed the following summary:

```text
Date of analysis 20260304_51:18:20
Log file name log_generated.logs
Total lines processed 40 log_generated.logs
Total error count 8
Top 5 error messages with their occurrence count
      3 Out of memory
      2 Failed to connect
      1 Segmentation fault
      1 Invalid input
      1 Disk full
List of critical events with line numbers
10:2026-03-04 18:01:07 [CRITICAL]  - 603
14:2026-03-04 18:01:07 [CRITICAL]  - 26944
15:2026-03-04 18:01:07 [CRITICAL]  - 3801
19:2026-03-04 18:01:07 [CRITICAL]  - 10447
26:2026-03-04 18:01:07 [CRITICAL]  - 9048
40:2026-03-04 18:01:07 [CRITICAL]  - 10566
```

---

## Generated Report File
The script automatically created a file named `log_report_20260304_51:18:20.txt` containing the exact details required for the daily summary.

---

## Command Breakdown & Learnings

### Tools Used
1.  **`grep`**:
    *   `grep -c`: Used to count the total number of errors without printing the lines.
    *   `grep -n`: Used to get the line numbers for "CRITICAL" events.
2.  **`sed`**:
    *   Used regex to clean up the log lines.
    *   Command: `sed -E 's/.*\[ERROR\] (.*) - [0-9]+$/\1/'` captures only the text between `[ERROR]` and the trailing ID number.
3.  **`sort | uniq -c | sort -nr`**:
    *   This is the standard pipeline for frequency analysis. It sorts the data, counts occurrences, and then sorts again by count (descending) to find the "Top 5".

### Key Learnings
1.  **Regex is powerful:** Extracting just the "Error Message" from a complex log line required using `sed` with a specific pattern.
2.  **Input Validation:** It is crucial to check `if [ "$#" -eq 0 ]` to ensure the user actually provided a file, preventing the script from running on empty inputs.
3.  **Redirection blocks:** Instead of writing `>> report.txt` on every single line, I learned I can wrap multiple `echo` commands in `{ ... } > file.txt` to write the whole block at once.