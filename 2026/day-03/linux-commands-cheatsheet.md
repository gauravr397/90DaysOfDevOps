# Day 03: My Linux Commands Cheat Sheet

---

### 1. Process Management

| Command | Description |
| :--- | :--- |
| `ps -ef` | List all running processes on the system in full format. |
| `ps -aux` | See all processes, including those without a terminal, with user and CPU/MEM usage. |
| `top` | Display a live, interactive view of system processes, CPU, and memory usage. |
| `htop` | An interactive, user-friendly version of `top` (often needs to be installed). |
| `kill <PID>` | Send a signal to a process to terminate it gracefully (e.g., `kill 1234`). |
| `kill -9 <PID>` | Forcibly stop a process that is not responding (use as a last resort). |
| `systemctl status <service>` | Check the status of a `systemd` service (e.g., `systemctl status nginx`). |
| `journalctl -u <service>` | View the logs for a specific `systemd` service. |

---

### 2. File System & Text Manipulation

| Command | Description |
| :--- | :--- |
| `pwd` | Print the full path of the current working directory. |
| `ls -lrth` | List files in detail, sorted by most recent modification time. |
| `cd <directory>` | Change the current directory. |
| `mkdir <name>` | Create a new directory. |
| `cp <source> <destination>` | Copy a file or directory. |
| `mv <source> <destination>` | Move or rename a file or directory. |
| `rm -rf <name>` | Remove a file or directory forcefully and recursively (use with caution!). |
| `find . -name "*.log"` | Search for files in the current directory with a specific name pattern. |
| `grep "error" <file>` | Search for a specific text pattern within a file. |
| `tail -f <file>` | Follow a file in real-time, showing new lines as they are added (great for logs). |
| `df -h` | Display disk space usage for all mounted filesystems in a human-readable format. |
| `du -sh <directory>` | Show the total disk space used by a specific directory. |
| `chmod 755 <file>` | Change the permissions of a file or directory. |
| `chown user:group <file>` | Change the ownership (user and group) of a file or directory. |

---

### 3. Networking Troubleshooting

| Command | Description |
| :--- | :--- |
| `ping <host>` | Check network connectivity to a specific host (e.g., `ping google.com`). |
| `ip addr show` | Display all network interfaces and their assigned IP addresses. |
| `netstat -tulnp` | List all listening ports and the processes using them (classic tool). |
| `ss -tulnp` | A modern replacement for `netstat` to show network sockets and connections. |
| `dig <domain>` | Perform a DNS lookup to find the IP address associated with a domain. |
| `curl -I <URL>` | Fetch the HTTP headers of a URL to check status codes and server info. |
| `telnet <host> <port>` | Test if a network port is open and listening on a remote host. |
| `nslookup <ip/dns>` | get ip or domain name of remote host. |