# File Permissions & Operations Challenge
---
## Files Created

| File | Method | Initial Permissions | Purpose |
| :--- | :--- | :--- | :--- |
| `devops.txt` | `touch` | `-rw-rw-r--` | Empty placeholder for permission testing. |
| `notes.txt` | `echo` | `-rw-rw-r--` | File with text content. |
| `script.sh` | `vim` | `-rw-rw-r--` | A simple shell script to print "Hello Hello". |

---

## Permission Changes

| File/Folder | Command | New Permission | Resulting Access |
| :--- | :--- | :--- | :--- |
| **`script.sh`** | `chmod +x` | `-rwxrwxr-x` | Owner, Group, and Others can now execute the script. |
| **`devops.txt`** | `chmod -w` | `-r--r--r--` | File is now **Read-Only** for everyone. |
| **`notes.txt`** | `chmod 640` | `-rw-r-----` | Owner: Read/Write; Group: Read; Others: No access. |
| **`project/`** | `chmod 755` | `drwxr-xr-x` | Owner: Full; Others: Read and Enter directory. |

---

## Commands Used (Verbatim)

```bash
touch devops.txt
echo "hello hello" > notes.txt
vim script.sh

cat notes.txt             
head -5 /etc/passwd
tail -5 /etc/passwd

chmod +x script.sh
./script.sh               # Ran successfully after chmod +x

chmod -w devops.txt
chmod 640 notes.txt
mkdir project/
chmod -R 755 project
```

---

## Testing Permissions (The "Failed" Scenarios)

I intentionally tested the limits of the permissions I set to understand system errors.

**1. Executing without 'x' permission:**
*   **Command:** `./script.sh` (before chmod)
*   **Result:** `zsh: permission denied: ./script.sh`
*   **Lesson:** Linux ignores the content of the file if the execute bit is not set, even if it is a valid script.

**2. Writing to a read-only file:**
*   **Command:** `echo "hello hello" > devops.txt`
*   **Result:** `zsh: permission denied: devops.txt`
*   **Lesson:** Removing the `w` (write) permission effectively "locks" the file from accidental modification.

---

## What I Learned
1.  **Numeric vs Symbolic:** I learned how to use both `chmod +x` (symbolic) and `chmod 640` (numeric) to achieve specific security states.
2.  **Modern Tools:** Using `bat` (aliased to `cat`) makes reading files much easier with line numbers and syntax highlighting, which is vital for debugging scripts.
3.  **The Directory Execute Bit:** I learned that the `x` permission on a directory (`drwxr-xr-x`) is what allows a user to "enter" the directory using the `cd` command.
4.  **Redirection Safety:** Redirection (`>`) is a powerful way to create files, but permissions are the only thing that prevents it from overwriting important data.

---

***

### Submission Log
```bash
❯ ls -lrth
total 4.0K
-rw-rw-r-- 1 gr gr 2.3K Feb  2 12:22 README.md
❯
❯ touch devops.txt
❯
❯
❯ echo "hello hello" >notes.txt
❯
❯
❯ cat notes.txt
───────┬───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
       │ File: notes.txt
───────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1   │ hello hello
───────┴───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
❯
❯
❯
❯ vim script.sh
❯
❯
❯
❯ ./script.sh
zsh: permission denied: ./script.sh
❯ ls -lrth
total 12K
-rw-rw-r-- 1 gr gr 2.3K Feb  2 12:22 README.md
-rw-rw-r-- 1 gr gr    0 Feb  7 12:02 devops.txt
-rw-rw-r-- 1 gr gr   12 Feb  7 12:03 notes.txt
-rw-rw-r-- 1 gr gr   19 Feb  7 12:06 script.sh
❯
❯ chmod +x script.sh
❯
❯
❯ ls -lrth
total 12K
-rw-rw-r-- 1 gr gr 2.3K Feb  2 12:22 README.md
-rw-rw-r-- 1 gr gr    0 Feb  7 12:02 devops.txt
-rw-rw-r-- 1 gr gr   12 Feb  7 12:03 notes.txt
-rwxrwxr-x 1 gr gr   19 Feb  7 12:06 script.sh
❯ ./script.sh
Hello Hello
❯
❯
❯ head -5 /etc/passwd
root:x:0:0:root:/root:/usr/bin/zsh
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
❯
❯
❯ tail -5 /etc/passwd
usbmux:x:108:46:usbmux daemon,,,:/var/lib/usbmux:/usr/sbin/nologin
sshd:x:109:65534::/run/sshd:/usr/sbin/nologin
gr:x:1000:1000:gauravraghav:/home/gr:/usr/bin/zsh
tokyo:x:1001:1001::/home/tokyo:/usr/bin/zsh
berlin:x:1002:1002::/home/berlin:/usr/bin/zsh
❯
❯
❯ chmod -w devops.txt
❯ ls -lrth
total 12K
-rw-rw-r-- 1 gr gr 2.3K Feb  2 12:22 README.md
-r--r--r-- 1 gr gr    0 Feb  7 12:02 devops.txt
-rw-rw-r-- 1 gr gr   12 Feb  7 12:03 notes.txt
-rwxrwxr-x 1 gr gr   19 Feb  7 12:06 script.sh
❯ chmod 640 notes.txt
❯ ls -lrth
total 12K
-rw-rw-r-- 1 gr gr 2.3K Feb  2 12:22 README.md
-r--r--r-- 1 gr gr    0 Feb  7 12:02 devops.txt
-rw-r----- 1 gr gr   12 Feb  7 12:03 notes.txt
-rwxrwxr-x 1 gr gr   19 Feb  7 12:06 script.sh
❯ mkdir project/
❯ ls -lrth
total 16K
-rw-rw-r-- 1 gr gr 2.3K Feb  2 12:22 README.md
-r--r--r-- 1 gr gr    0 Feb  7 12:02 devops.txt
-rw-r----- 1 gr gr   12 Feb  7 12:03 notes.txt
-rwxrwxr-x 1 gr gr   19 Feb  7 12:06 script.sh
drwxrwxr-x 2 gr gr 4.0K Feb  7 12:10 project
❯ chmod -R 755 project
❯ ls -lrth
total 16K
-rw-rw-r-- 1 gr gr 2.3K Feb  2 12:22 README.md
-r--r--r-- 1 gr gr    0 Feb  7 12:02 devops.txt
-rw-r----- 1 gr gr   12 Feb  7 12:03 notes.txt
-rwxrwxr-x 1 gr gr   19 Feb  7 12:06 script.sh
drwxr-xr-x 2 gr gr 4.0K Feb  7 12:10 project
❯ echo "hello hello" >devops.txt
zsh: permission denied: devops.txt

╭─   ~/Projects/TWS/90DaysOfDevOps/2026/day-10   master ?3 
```