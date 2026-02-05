### **Refined `linux-troubleshooting-runbook.md` File**

```markdown
# Day 05: Linux Troubleshooting Runbook
**Target Service:** OpenSSH Server (`sshd`)

---

## 1. Environment & Filesystem Sanity
Before diving into the service, I verified the OS environment and ensured the filesystem is writable.

**Commands:** `uname -a` | `cat /etc/os-release` | `ls -lrth /tmp/runbook-demo`
```bash
PRETTY_NAME="Ubuntu 24.04.3 LTS"
Kernel: Linux 6.8.0-90-generic x86_64

gr@nitro:/tmp/runbook-demo$ ls -lrth
-rw-r--r-- 1 gr gr 220 Feb  2 10:42 host-copy
```
*   **Observation:** The system is running a modern Ubuntu 24.04 kernel. The `/tmp` directory is writable, confirming no "read-only" filesystem issues.

---

## 2. Snapshot: CPU & Memory
I identified the target process and checked overall system resources to ensure no bottlenecks.

**Commands:** `ps -aux | grep ssh` | `free -h`
```bash
root  28298  0.0  0.0  12024  8064 ?  Ss  Feb04  0:00 sshd: /usr/sbin/sshd -D

Mem: 14Gi total | 1.5Gi used | 10Gi free | 13Gi available
```
*   **Observation:** `sshd` (PID 28298) is consuming negligible CPU/Memory. The system has 10Gi of free RAM, ruling out OOM (Out of Memory) risks.

---

## 3. Snapshot: Disk & I/O
Checked for disk space exhaustion or I/O wait that could cause service hangs.

**Commands:** `df -h` | `iostat`
```bash
/dev/sdb4   59G  8.0G   48G  15% /

avg-cpu: %iowait 0.05 | %idle 99.80
```
*   **Observation:** The root partition has 48GB available (only 15% used). `%iowait` is near zero, indicating no disk congestion affecting service performance.

---

## 4. Snapshot: Network
Verified that the service is listening on the correct port and the system has external connectivity.

**Commands:** `ss -tulnp | grep :22` | `ping -c 3 google.com`
```bash
tcp  LISTEN  0  4096  0.0.0.0:22  0.0.0.0:*  # sshd listening

3 packets transmitted, 3 received, 0% packet loss, time 2.3ms
```
*   **Observation:** `sshd` is correctly listening on all interfaces on Port 22. Latency to Google is excellent (~2.3ms), confirming the network stack is healthy.

---

## 5. Logs Reviewed
Inspected the last 50 lines of service-specific and authentication logs.

**Commands:** `sudo journalctl -u ssh -n 50` | `tail -n 50 /var/log/auth.log`
```bash
Jan 12 20:08:22 nitro sshd[10265]: Server listening on 0.0.0.0 port 22.
Jan 14 09:23:13 nitro sshd[28034]: pam_unix(sshd:session): session closed for user gr

2026-02-05T17:10:52 nitro sshd[108034]: Accepted publickey for gr from 127.0.0.1
```
*   **Observation:** Logs show successful public key authentication and no "Connection Refused" or "Timeout" errors in the recent history.

---

## 6. Quick Findings
The `ssh` service is running optimally. There are no resource constraints (CPU/Mem/Disk) and the network is highly responsive. Recent logs confirm successful logins from the local user.

---

## 7. If This Worsens (Next Steps)
If users report connection issues despite these healthy signals, I would:
1.  **Collect `strace`:** Run `sudo strace -p 28298` to see real-time system calls and identify where the process hangs.
2.  **Increase Verbosity:** Modify `/etc/ssh/sshd_config` to set `LogLevel DEBUG3` and restart the service to capture more granular log data.
3.  **Check Firewall:** Run `sudo ufw status` or `sudo iptables -L` to ensure no new rules are dropping packets on Port 22.
```
