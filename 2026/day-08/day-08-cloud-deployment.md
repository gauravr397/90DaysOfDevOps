# Cloud Server Setup: Nginx & Log Management
---
## 1. Installation and Service Status
First, I installed the Nginx web server and verified it was running.

**Commands:**
```bash
sudo apt install nginx -y

systemctl status nginx

systemctl is-enabled nginx
```

**Observation:**
The service started automatically upon installation. I could see the `Active: active (running)` status.

---

## 2. Managing the Service
I practiced stopping and starting the server to verify process management.

**Commands:**
```bash
systemctl stop nginx

systemctl status nginx

systemctl start nginx
```

---

## 3. Advanced Log Management (The Challenge)
My goal was to capture live logs (`journalctl -f`) into a file, but keep the process running in the background so I could continue using the terminal.

### The Problem
Running `journalctl -u nginx -f` takes over the terminal. I needed to run it in the background (`&`) and ensure it keeps running even if I disconnect (`nohup`).

### The Solution
I used `nohup` combined with output redirection.

**Command Used:**
```bash
nohup journalctl -u nginx -f > /tmp/nginx-logs.txt 2>&1 &
```

**Breakdown of the command:**
*   `nohup`: Prevents the process from being killed when the shell exits.
*   `journalctl -u nginx -f`: Follows the logs for the Nginx unit.
*   `> /tmp/nginx-logs.txt`: Redirects standard output to a file.
*   `2>&1`: Redirects Standard Error (2) to Standard Output (1) so errors are also saved.
*   `&`: Puts the whole process in the background.

**Verifying the background process:**
```bash
ps -ef | grep journalctl
```
*Result:* I successfully found the process ID (PID 32902) running in the background.

**Verifying the log content:**
```bash
cat /tmp/nginx-logs.txt
```
*Result:* The file contained the systemd start/stop logs for Nginx.

---

## Challenges Faced

**1. Syntax for `nohup`**
I initially struggled with the syntax for `nohup`.
*   *Attempt 1:* `journalctl ... nohup` (Failed - syntax error)
*   *Attempt 2:* `nohup -f ...` (Failed - invalid flag)
*   *Attempt 3:* `nohup ... /tmp/file` (Failed - missing redirection `>`)

**Solution:** I checked the manual (`man nohup`) and realized I needed to use standard redirection `>` to send the output to a file, and add `&` at the end.

---

## What I Learned
1.  **Service Control:** usage of `systemctl` to start/stop/status is fundamental for managing web servers.
2.  **Log Follow:** `journalctl -u <service> -f` is the modern equivalent of `tail -f /var/log/...`.
3.  **Background Processes:** `nohup` is essential for long-running tasks. Understanding `2>&1` is critical to ensure you don't lose error messages.
4.  **Process IDs:** How to find a background process using `ps -ef` and the PID.

---

## Snapshots
- `![alt text](image.png)`
```