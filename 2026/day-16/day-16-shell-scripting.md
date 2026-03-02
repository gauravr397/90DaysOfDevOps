# Shell Scripting Basics

## Task 1: Your First Script
I created a simple script to print a message to the console.

**Script:** `hello.sh`
```bash
echo "Hello, DevOps!"
```

**Observation:**
Even without the `#!/bin/bash` (Shebang) line, the script ran successfully because my current shell (Zsh/Bash) interpreted the commands. However, including the shebang is best practice to ensure the script always runs with the intended interpreter (Bash), regardless of the user's current shell environment.

---

## Task 2 & 3: Variables and User Input
I combined variables and the `read` command to create an interactive script. I learned that `read -p` allows us to prompt the user for input on the same line.

**Script:** `variables.sh`
```bash
#!/bin/bash

read -p "enter name" NAME
read -p "enter role" ROLE

TOOL="Actions"

echo "Hello name is $NAME & role is $ROLE & favourite tools is $TOOL"
```

---

## Task 4: If-Else Conditions
I created a script to check file existence and compare numbers. This helped me understand the syntax difference between checking file attributes and comparing integers.

**Script:** `ifchecks.sh`
```bash
#!/bin/bash

a=10
b=20

# Check if a specific file exists
if [ -f "/etc/passwd" ]; then
    echo "File exist"
else
    echo "Does not exist"
fi

# Compare numbers
if [ $a -gt $b ]; then
    echo "$a is greater"
else
    echo "$b is greater"
fi
```

---

## Task 5: Real-world Automation (Server Check)
I wrote a script to check the status of a specific service (like Nginx) based on user input.

**Script:** `server_check.sh`
```bash
#!/bin/bash

read -p "enter the service to check" SERVICE
read -p "enter the Y to check" YES

if [ "$YES" == "Y" ]; then
    sudo systemctl status $SERVICE
else
    echo "Skipped"
fi
```

### Execution & Output
I encountered an error initially (`[: Y: integer expression expected`) because I wasn't handling the string comparison correctly. After ensuring the variable was quoted (`"$YES"`), the script worked perfectly.

**Output:**
```text
enter the service to check: nginx
enter the Y to check: Y
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
     Active: active (running) since Sun 2026-03-01 17:42:22 IST; 1 day 4h ago
...
