
# Linux File System Hierarchy & Scenario-Based Practice
---
## Part 1: Linux File System Hierarchy

Below is a breakdown of the critical directories explored during the session, including observations from my local machine (`nitro`).

### Core Directories (Must Know)

| Directory | Purpose | Practical Observation / Command Used | I would use this when... |
| :--- | :--- | :--- | :--- |
| **`/` (Root)** | The starting point of the filesystem hierarchy. | All paths start here. | I need to navigate to the absolute base of the OS. |
| **`/home`** | Contains personal directories for users. | **Command:** `ls -la ~`<br>**Output:** Saw `.bashrc`, `.p10k.zsh`, `.ssh`, and `Projects` folder. | I need to edit user-specific configs or access my personal projects. |
| **`/root`** | The home directory for the superuser (root). | distinct from `/`. | I am logged in as the root user for administrative tasks. |
| **`/etc`** | Configuration files for the system and applications. | **Command:** `cat /etc/hostname`<br>**Output:** `nitro` | I need to edit system settings like DNS, hostname, or Nginx configs. |
| **`/var/log`** | Stores system and application log files. | **Command:** `du -sh /var/log/* 2>/dev/null \| sort -h \| tail -5`<br>**Output:** Largest folder was `/var/log/journal` (202M). | I need to debug why an application crashed or check security access logs. |
| **`/tmp`** | Temporary files that are deleted upon reboot. | Scratch space. | I need to download a script or unzip a file that I don't need permanently. |

### Additional Directories

*   **`/bin` & `/usr/bin`**: Contains essential binaries (commands) like `ls`, `cat`, `cp`.
*   **`/opt`**: Used for installing optional add-on software (often third-party apps not from the package manager).

---

## Part 2: Scenario-Based Practice

In this section, I simulated common DevOps incidents and used CLI tools to troubleshoot them.

### Scenario 1: Service Not Starting
**Situation:** A service (practiced using `ssh` and `nginx`) fails to start or needs to be checked after a reboot.

**Step 1: Check the status**
```bash
systemctl status ssh
```
*Why:* This tells me if the service is `active (running)`, `inactive`, or `failed`. In my terminal, SSH was active.

**Step 2: List all services to ensure the name is correct**
```bash
systemctl list-units --type=service | grep -i ssh
```
*Why:* If I typo the service name, `status` might fail. This confirms the exact service name.

**Step 3: Check if enabled on boot**
```bash
systemctl is-enabled ssh
```
*Why:* To ensure the service starts automatically if the server reboots. (My output: `enabled`).

---

### Scenario 2: High CPU Usage
**Situation:** The server is running slow, and I need to identify the process consuming resources.

**Step 1: specific snapshot of processes**
```bash
ps aux --sort=%cpu | head -10
```
*Why:* This lists all running processes. By sorting by CPU and piping to `head`, I instantly see the resource hogs.
*(Note: Use `--sort=-%cpu` for descending order to see the highest usage at the top).*

**Step 2: Interactive monitoring**
```bash
top
# or
htop
```
*Why:* These provide a real-time, updating view of system health.

---

### Scenario 3: Finding Service Logs
**Situation:** A developer needs to see why a service is behaving strangely.

**Step 1: View recent logs**
```bash
journalctl -u ssh -n 10
```
*Why:* The `-u` flag filters for a specific unit (service), and `-n 10` shows only the last 10 lines, keeping the screen clean.

**Step 2: Follow logs in real-time**
```bash
journalctl -u ssh -f
```
*Why:* The `-f` flag "follows" the log. I used this to watch successful login attempts (`Accepted publickey...`) happen live as they occurred.

---

### Scenario 4: File Permissions Issue
**Situation:** A script (`backup.sh`) gives a "Permission denied" error.

**Step 1: Check permissions**
```bash
ls -l backup.sh
```
*Look for:* Absence of `x` in the permission string (e.g., `-rw-r--r--`).

**Step 2: Grant execute permission**
```bash
chmod +x backup.sh
```
*Why:* This adds the executable bit to the file.

**Step 3: Verify and Run**
```bash
ls -l backup.sh
./backup.sh
```
*Result:* The permissions should now look like `-rwxr-xr-x`, allowing the script to run.
