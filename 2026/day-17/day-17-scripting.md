# Shell Scripting: Loops, Arguments & Error Handling
---

## Task 1: For Loops
I created a script to iterate through an array of items.

**Script:** `for_loop.sh`
```bash
#!/bin/bash

list=("apple" "banana" "orange" "chiku" "kiwi")

# Iterating through the array elements
for i in ${list[@]}; do
    echo "$i"
done
```

**Observation:**
Initially, I used `${#list[@]}` which returned the *count* of the array (5). I corrected it to `${list[@]}` to expand and print the actual *items*.

**Output:**
```text
apple
banana
orange
chiku
kiwi
```

---

## Task 2: While Loops
I wrote a countdown timer that takes user input and loops until the condition is met.

**Script:** `countdown.sh`
```bash
#!/bin/bash

read -p "enter countdown num" num

while [ $num -ge 0 ]; do
    echo $num
    ((num--)) # Decrement the number
done

echo "Done!"
```

**Output:**
```text
enter countdown num: 6
6
5
4
3
2
1
0
Done!
```

---

## Task 3: Command-Line Arguments
I explored how to pass input directly when running a script using special variables like `$1`, `$@`, and `$#`.

**Script:** `greet.sh` (Handling specific arguments)
```bash
#!/bin/bash
echo "Hello, $1"
```

**Script:** `args_demo.sh` (Analyzing all arguments)
```bash
#!/bin/bash
echo "Total num of args: $#"
echo "All args: $@"
echo "Script name args: $0"
```

**Output:**
```bash
$ ./args_demo.sh ags1 arg2 agr3
Total num of args:  3
All args:  ags1 arg2 agr3
Script name args:  ./args_demo.sh
```

---

## Task 4: Installing Packages (Automation)
I wrote a script to check if packages are installed and install them if they are missing.

**Script:** `install_packages.sh`
```bash
#!/bin/bash

packages=("nginx" "wget" "php")

for i in ${packages[@]}; do
    # Check if package is installed (redirect output to null)
    if dpkg -s $i > /dev/null 2>&1; then
        echo "$i : Already installed"
    else
        echo "Installing $i..."
        sudo apt install $i -y
    fi
done

echo "Completed installation of pkgs"
```

**Observation & Fix:**
In my initial run, the output showed `: Already installed` because I accidentally used `$1` (script argument) instead of `$i` (loop variable) inside the `echo` statement. The logic worked, but the print message needed that fix.

---

## Task 5: Error Handling
I learned how to make scripts safer using `set -e` and logical operators `||`.

**Script:** `safe_script.sh`
```bash
#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "running ..."

# Try to make a dir. If it fails (||), run the echo command.
mkdir /tmp/devops-test || echo "Dir already there"
```

**Output:**
```text
running ...
mkdir: cannot create directory ‘/tmp/devops-test’: File exists
Dir already there
```

**Key Learning here:**
Even though `set -e` is on, the `||` operator "catches" the error from `mkdir`, preventing the script from crashing entirely and allowing the custom error message to print.

---
