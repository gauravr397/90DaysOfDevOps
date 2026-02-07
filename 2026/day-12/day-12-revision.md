# Breather & Revision (Days 01–11)

## 1. Mindset & Goals Review (Day 01)
*   **Role:** Moving from Release/Deployment Engineer to a hands-on DevOps role.
*   **Core Goals:**
    *   Master Advanced CI/CD (Blue-Green/Canary).
    *   Kubernetes Proficiency (EKS/GKE).
    *   GitOps Workflow (ArgoCD/Flux).
*   **Routine:** 2 hours/weekday, 4 hours/weekend. *Consistency is the key.*

## 2. Linux Architecture & Process Management (Days 02–04)
*   **The Big Picture:**
    *   **Kernel:** Hardware bridge.
    *   **User Space:** Where apps run.
    *   **Systemd (PID 1):** The mother of all processes; manages boot and services.
*   **Process States:** Running (R), Sleeping (S), Zombie (Z).
*   **Key Commands:**
    *   `ps -ef`: The standard process list.
    *   `top` / `htop`: Real-time resource monitoring.
    *   `kill <PID>`: Stop a process.
    *   `pgrep -i <name>`: Quick way to find a PID.

## 3. Service Management & Logging (Days 05 & 08)
*   **Managing Services (`systemctl`):**
    *   `start`, `stop`, `restart`, `status`.
    *   `enable` (ensure start on boot).
*   **The Troubleshooting Flow:**
    1.  Check Status: `systemctl status <service>`
    2.  Check Logs: `journalctl -u <service> -f` (Follow mode)
    3.  Check Ports: `ss -tulnp | grep <port>`
*   **Background Jobs:**
    *   `nohup <command> &`: Run a command that survives terminal closure.
    *   `> /tmp/log 2>&1`: Redirect both Output (1) and Errors (2) to a file.

## 4. File Systems & I/O (Days 06–07)
*   **Hierarchy:**
    *   `/etc`: Config files.
    *   `/var/log`: Logs.
    *   `/tmp`: Temporary (deleted on reboot).
    *   `/bin`: Essential commands.
*   **Redirection:**
    *   `>`: Overwrite.
    *   `>>`: Append (safest for logs).
    *   `| tee -a`: Append to file *and* see output on screen.

## 5. Users, Groups, & Permissions (Days 09–11)
*   **Users:** `useradd -m -s /bin/bash <user>` (Always define shell & home).
*   **Groups:** `usermod -aG <group> <user>` (Add user to group without removing old ones).
*   **Permissions (`chmod`):**
    *   `chmod +x script.sh`: Make executable.
    *   `755` (Owner: All, Group/Other: Read+Execute).
    *   `640` (Owner: RW, Group: R, Other: None).
*   **Ownership (`chown`):**
    *   `chown user:group file`: Change owner and group.
    *   `chown -R`: Recursive change (critical for directories like `/var/www`).

---

## 6. Mini Self-Check Answers

**1) Which 3 commands save you the most time right now, and why?**
*   `grep`: Instantly finding specific errors in massive log files or configs.
*   `ps -ef`: The quickest way to check if a process is actually running or stuck.
*   `ls -lrth`: Sorting by time helps immediately see what files were just changed or created.

**2) How do you check if a service is healthy? List the exact 2–3 commands you’d run first.**
1.  `systemctl status <service_name>` (Checks if active/running).
2.  `journalctl -u <service_name> -n 50` (Checks for recent errors).
3.  `systemctl is-enabled <service_name>` (Checks if it survives a reboot).

**3) How do you safely change ownership and permissions without breaking access? Give one example command.**
*   **Command:** `chown -R user:group /path/to/folder` and `chmod -R 775 /path/to/folder`.
*   *Note:* Always check current permissions with `ls -l` before changing, and avoid `777`.

**4) What will you focus on improving in the next 3 days?**
*   **Networking Skills:** Deepening knowledge of ports, IP addressing, SSH tunneling, and firewall rules to troubleshoot connectivity issues effectively.

---

## 7. Hands-On Re-Run (Day 12 Checkpoint)

```bash
# Proof of work: Checking Nginx health
$ systemctl status nginx | grep Active
   Active: active (running) since Fri 2026-02-07 ...

# Proof of work: File permissions check
$ ls -l test_script.sh
-rwxr-xr-x 1 gr dev 0 Feb 7 12:00 test_script.sh
```
