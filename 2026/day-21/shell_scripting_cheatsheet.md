# Shell Scripting Cheat Sheet

A quick-reference guide for Bash scripting, covering basics, control flow, text processing, and error handling.

## ⚡ Quick Reference Table

| Topic | Key Syntax | Example |
| :--- | :--- | :--- |
| **Variable** | `VAR="value"` | `NAME="DevOps"` |
| **Argument** | `$1`, `$2`, `$@` | `./script.sh arg1 arg2` |
| **Input** | `read -p "Prompt" VAR` | `read -p "Enter name: " NAME` |
| **If Statement** | `if [ cond ]; then` | `if [ -f file.txt ]; then` |
| **For Loop** | `for i in list; do` | `for i in {1..5}; do` |
| **While Loop** | `while [ cond ]; do` | `while [ $count -gt 0 ]; do` |
| **Function** | `name() { ... }` | `greet() { echo "Hi $1"; }` |
| **Grep** | `grep "pattern" file` | `grep -i "error" app.log` |
| **Awk** | `awk '{print $N}'` | `awk -F: '{print $1}' /etc/passwd` |
| **Sed** | `sed 's/old/new/g'` | `sed -i 's/foo/bar/g' config.conf` |
| **Strict Mode** | `set -euo pipefail` | (Put at top of script) |

---

## 1. Basics

### Shebang
Tells the system which interpreter to use.
```bash
#!/bin/bash
```

### Running a Script
1.  **Make executable:** `chmod +x script.sh`
2.  **Run:** `./script.sh`

### Variables
*   **No spaces** around the `=` sign.
*   **Single Quotes (`''`):** Treat everything as a string (no variable expansion).
*   **Double Quotes (`""`):** Allow variable expansion.

```bash
NAME="Shubham"
echo "Hello $NAME"   # Output: Hello Shubham
echo 'Hello $NAME'   # Output: Hello $NAME
```

### Command-Line Arguments
Special variables for handling inputs passed to the script.

| Variable | Description |
| :--- | :--- |
| `$0` | The name of the script itself |
| `$1` - `$9` | The first 9 arguments |
| `$#` | Total number of arguments passed |
| `$@` | All arguments as a list |
| `$?` | Exit status of the last command (0 = success) |

---

## 2. Operators & Conditionals

### Comparisons (`[ ... ]`)

| Type | Flag | Meaning | Example |
| :--- | :--- | :--- | :--- |
| **String** | `=` / `!=` | Equal / Not Equal | `[ "$a" = "$b" ]` |
| | `-z` | String is empty | `[ -z "$VAR" ]` |
| | `-n` | String is NOT empty | `[ -n "$VAR" ]` |
| **Integer** | `-eq` | Equal | `[ $a -eq $b ]` |
| | `-ne` | Not Equal | `[ $a -ne $b ]` |
| | `-gt` / `-lt` | Greater / Less Than | `[ $a -gt 10 ]` |
| | `-ge` / `-le` | Greater/Less or Equal | `[ $a -le 5 ]` |
| **File** | `-f` | File exists | `[ -f "file.txt" ]` |
| | `-d` | Directory exists | `[ -d "/tmp" ]` |
| | `-e` | Exists (file or dir) | `[ -e "item" ]` |
| | `-x` | Is executable | `[ -x "script.sh" ]` |

### If-Else Syntax
```bash
if [ -f "config.txt" ]; then
    echo "File exists."
elif [ -d "config_dir" ]; then
    echo "Directory exists."
else
    echo "Nothing found."
fi
```

### Logic Operators
*   `&&` (AND)
*   `||` (OR)
*   `!` (NOT)

---

## 3. Loops

### For Loop (Iterate over list)
```bash
# Loop through a list of strings
for os in Ubuntu CentOS Fedora; do
    echo "System is $os"
done

# C-Style loop
for ((i=1; i<=5; i++)); do
    echo "Number: $i"
done
```

### While Loop (Run while true)
```bash
count=5
while [ $count -gt 0 ]; do
    echo $count
    ((count--))
done
```

### Loop Control
*   `break`: Exit the loop immediately.
*   `continue`: Skip to the next iteration.

### Reading Files Line-by-Line
```bash
while read line; do
    echo "Processing: $line"
done < input.txt
```

---

## 4. Functions

### Definition & Scope
Variables defined with `local` only exist inside the function (best practice).

```bash
my_function() {
    local name=$1
    echo "Hello, $name"
    return 0
}

# Calling the function
my_function "Alice"
```

*   **Note:** Functions in Bash don't return values like other languages. They return an **exit code** (0-255). To capture output, use `result=$(my_function)`.

---

## 5. Text Processing (The DevOps Toolkit)

| Command | Usage | Example |
| :--- | :--- | :--- |
| **grep** | Search text | `grep -r "error" /var/log/` (Recursive search) |
| | Count matches | `grep -c "Failed" auth.log` |
| | Invert match | `grep -v "debug" app.log` (Show everything except debug) |
| **awk** | Print columns | `awk '{print $1, $3}' file.txt` (Print col 1 & 3) |
| | Filter rows | `awk '$3 > 500 {print $0}' data.txt` |
| **sed** | Replace text | `sed 's/foo/bar/g' file.txt` (Replace all foo with bar) |
| | Delete lines | `sed '/error/d' file.txt` (Delete lines containing 'error') |
| **cut** | Extract text | `cut -d ":" -f 1 /etc/passwd` (Get users from passwd) |
| **sort** | Sort lines | `sort -n` (Numeric), `sort -r` (Reverse) |
| **uniq** | Deduplicate | `sort file.txt | uniq -c` (Count occurrences) |
| **head/tail** | View content | `tail -f /var/log/syslog` (Follow log in real-time) |

---

## 6. Useful One-Liners

**1. Find and delete logs older than 7 days:**
```bash
find /var/log -name "*.log" -mtime +7 -exec rm {} \;
```

**2. Check disk usage and sort by size:**
```bash
du -sh * | sort -hr | head -5
```

**3. Check if a service is active (useful for scripts):**
```bash
systemctl is-active --quiet nginx && echo "Running" || echo "Stopped"
```

**4. Count top 5 recurring IP addresses in access logs:**
```bash
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -5
```

**5. Quick backup with timestamp:**
```bash
tar -czf backup_$(date +%F).tar.gz /home/user/data
```

---

## 7. Error Handling & Debugging

### Exit on Error (`set -e`)
Add this to the top of your script to stop execution immediately if any command fails.
```bash
#!/bin/bash
set -e
```

### Strict Mode (Recommended)
Combines multiple safety checks.
```bash
set -euo pipefail
```
*   `-e`: Exit on error.
*   `-u`: Exit on unset variables.
*   `-o pipefail`: Exit if any command in a pipe `|` fails.

### Debugging
Trace every command executed.
```bash
set -x  # Enable debug
./script.sh
set +x  # Disable debug
```

### Traps (Cleanup)
Run a command when the script exits (even if it crashes).
```bash
cleanup() {
    echo "Cleaning up temp files..."
    rm -f /tmp/tempfile
}
trap cleanup EXIT
```