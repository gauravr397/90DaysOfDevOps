# Day 04: Hands-On Linux Practice Log
---

### 1. Process Checks

**Command 1: `ps -ef | grep -i ssh`**
```bash
gr@nitro:~$ ps -ef | grep -i ssh
root   1161   1  0 Jan30 ?    00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
gr    15539 15459  0 08:54 ?    00:00:00 sshd: gr@notty
gr    15837 15677  0 08:57 pts/0    00:00:00 grep --color=auto -i ssh
```
*Observation: I can see the main `sshd` daemon running as root (PID 1161) and a child process for my active user session (`gr@notty`).*

**Command 2: `pgrep -i ssh`**
```bash
gr@nitro:~$ pgrep -i ssh
1161
15459
15539
```
*Observation: This is a much faster way to find the specific PIDs if I needed to send a signal with the `kill` command.*

---

### 2. Service Inspection: `ssh.service`

**Command 3: `systemctl status ssh`**
```bash
gr@nitro:~$ systemctl status ssh
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/usr/lib/systemd/system/ssh.service; enabled; preset: enabled)
     Active: active (running) since Fri 2026-01-30 15:24:01 UTC; 2 days ago
   Main PID: 1161 (sshd)
...
Feb 02 08:54:28 nitro sshd: Accepted publickey for gr from 127.0.0.1 port 54266 ssh2
Feb 02 08:54:28 nitro sshd: pam_unix(sshd:session): session opened for user gr(uid=1000) by gr(uid=0)
```
*Observation: The output confirms the service is `active (running)` and `enabled` (meaning it starts on boot). It also shows the Main PID is `1161`, which matches my `ps` command output. I can even see recent successful login events directly in the status.*

**Command 4: `systemctl list-units --type=service`**
```bash
gr@nitro:~$ systemctl list-units --type=service
  UNIT                  LOAD   ACTIVE SUB     DESCRIPTION
  ...
  ssh.service           loaded active running OpenBSD Secure Shell server
  ...
```
*Observation: This gives a high-level view of everything running, confirming `ssh.service` is just one of many managed by `systemd`.*

---

### 3. Log Checks

**Command 5: `journalctl -u ssh`**
```bash
gr@nitro:~$ journalctl -u ssh
...
Jan 12 17:51:55 nitro sshd: Accepted password for gr from 192.168.1.35 port 63549 ssh2
Jan 12 17:51:55 nitro sshd: pam_unix(sshd:session): session opened for user gr(uid=1000) by gr(uid=0)
...
```
*Observation: This gives me a complete history of the service, including startup messages and every connection attempt, which is incredibly useful for security audits or debugging connection issues.*

**Command 6: `tail -n 10 /var/log/auth.log`** (Example on Debian/Ubuntu systems)
```bash
gr@nitro:~/Projects/TWS/90DaysOfDevOps$ tail -20 /var/log/auth.log
2026-02-02T09:05:01.683715+00:00 nitro CRON[15940]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)

### 4. Mini Troubleshooting Flow
Based on my practice, here is a simple troubleshooting flow if I couldn't connect via SSH:

1.  **Check Service Status:** Run `systemctl status ssh` to see if the service is `active (running)`.
2.  **Restart if Needed:** If it is `inactive` or `failed`, try restarting it with `sudo systemctl restart ssh`.
3.  **Check for Errors:** If it fails to start, immediately check the logs for error messages using `journalctl -u ssh -n 50`. The error message will usually point to the root cause (e.g., a typo in `/etc/ssh/sshd_config`).
4.  **Check Network:** Use `ss -tulnp | grep :22` to confirm the `sshd` process is listening on port 22.

