#!/bin/bash

cur_date=$(date +%Y%m%d_%M:%H:%S)

#task 1
if [ "$#" -eq 0 ]; then
    echo "script usage is : $0 <log file to parse>"
    exit 1
fi

if [ ! -e "$1" ]; then
    echo "log file dosent exist"
    exit 1
fi

#task 2
echo "--- ERROR Events ---"
echo "Total line with error : $(grep -c "error" $1 )"
echo "Line with error : "
echo "$(grep -in "error" $1 )"

#task 3
echo "--- Critical Events ---"
echo "Total line with CRITICAL : $(grep -c "CRITICAL" $1)"
echo "Line with CRITICAL : "
echo "$(grep -in "CRITICAL" $1 )"

#task 4
echo "--- Top 5 Error Messages ---"
echo "$(grep -n "ERROR" "$1" | \
sed -E 's/.*\[ERROR\] (.*) - [0-9]+$/\1/' | \
sort | \
uniq -c | \
sort -nr | \
head -5)"

#task 5
echo "Date of analysis $cur_date" >> log_report_$cur_date.txt
echo "Log file name $1" >> log_report_$cur_date.txt
echo "Total lines processed $(wc -l $1)" >> log_report_$cur_date.txt
echo "Total error count $(grep -ic "error" $1 )" >> log_report_$cur_date.txt
echo "Top 5 error messages with their occurrence count $(grep -n "ERROR" "$1" | \
sed -E 's/.*\[ERROR\] (.*) - [0-9]+$/\1/' | \
sort | \
uniq -c | \
sort -nr | \
head -5)" >> log_report_$cur_date.txt
echo "List of critical events with line numbers $(grep -in "CRITICAL" $1 )" >> log_report_$cur_date.txt


