# Shell Scripting: Functions & Intermediate Concepts

## Overview
Today I focused on modularizing my scripts using **Functions**. I also learned about variable scope (`local` vs global) and how to write production-grade scripts using **Strict Mode** (`set -euo pipefail`).

---

## Task 1: Basic Functions
I created a script to demonstrate how to pass arguments to functions.

**Script:** `functions.sh`
```bash
#!/bin/bash

greet() {
    echo "Hello $1 !"
}

Sum() {
    # Using double parenthesis for arithmetic expansion
    sum=$(($1 + $2))
    echo "sum is : $sum"
}

greet raghav
Sum 3 8
```

**Output:**
```text
Hello raghav !
sum is : 11
```

---

## Task 2: Functions with Return Values
I wrote a script to check system resources. Instead of "returning" values like in other languages, I learned to capture the output of commands within the function.

**Script:** `disk_check.sh`
```bash
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
```

**Output:**
```text
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb4        59G   12G   45G  20% /
               total        used        free      shared  buff/cache   available
Mem:            14Gi       1.2Gi        11Gi        21Mi       2.7Gi        13Gi
Swap:          4.0Gi          0B       4.0Gi
```

---

## Task 3: Strict Mode (`set -euo pipefail`)
I learned how to make scripts fail "safely" rather than continuing with bad data.

**Script:** `strict_demo.sh`
```bash
#!/bin/bash

# Enable strict mode
set -eou pipefail

b=2

echo "($b + $b)"
```

### Understanding the Flags:
1.  **`set -e` (errexit):** The script stops immediately if any command returns a non-zero exit status (failure).
2.  **`set -u` (nounset):** The script crashes if I try to use a variable that hasn't been defined yet (prevents "unbound variable" errors).
3.  **`set -o pipefail`:** Normally, if you pipe commands (e.g., `cmd1 | cmd2`), Bash only looks at the success of the *last* command (`cmd2`). This flag ensures the script fails if *any* part of the pipe (`cmd1`) fails.

---

## Task 4: Local Variables
I experimented with the `local` keyword to understand variable scope.

**Script:** `local_demo.sh`
```bash
#!/bin/bash

func_local() {
    local a=2   # This variable exists ONLY inside this function
    b=3         # This variable is global
    echo "sum inside local : $a + $b"
}

func_local
echo "outside func : $a"  # This will be empty because 'a' was local
```

**Output:**
```text
sum inside local : 2 + 3
outside func : 
```
*Observation: The variable `$a` was not accessible outside the function, which helps prevent bugs in larger scripts.*

---

## Task 5: System Info Reporter
I combined everything into a modular system report script using strict mode and functions.

**Script:** `system_info.sh`
```bash
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

# Main Execution
host
uptime
disk_usg
check_mem
check_cpu
```

**Output:**
```text
Host details
 Static hostname: nitro
...
Operating System: Ubuntu 24.04.3 LTS              
...
 23:08:49 up 2 days,  5:26,  2 users,  load average: 0.01, 0.03, 0.03
disk usg
tmpfs           7.3G     0  7.3G   0% /dev/shm
...
mem usg
               total        used        free      shared  buff/cache   available
Mem:            14Gi       1.2Gi        11Gi        21Mi       2.7Gi        13Gi
top cpu usg
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
gr         25661  100  0.0  11016  4652 pts/3    R+   23:08   0:00 ps aux --sort=-%cpu
root       25655 46.6  0.0  17284  7844 ?        Ss   23:08   0:00 /usr/lib/systemd/systemd-hostnamed
...
```
