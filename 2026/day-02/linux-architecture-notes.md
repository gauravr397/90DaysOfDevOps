# Day 02: Linux Architecture, Processes, and systemd

## 1. Core Components of Linux

*   **Kernel:** The heart of the operating system. The kernel acts as the central bridge between the system's hardware (CPU, RAM, disks) and the software (applications, shell). Its primary jobs are to manage resources, schedule processes, and handle all hardware interactions.

*   **User Space:** This is everything that runs outside the kernel. It includes all user applications (like a web browser or a database), programming libraries, and the shell (e.g., bash) that you interact with. When you run a command like `ls` or `grep`, it executes in user space.

*   **init (systemd):** The very first process that the kernel starts at boot, which is always assigned Process ID (PID) 1. In modern Linux distributions, `systemd` is the standard init system. Its main responsibility is to bring the system to a usable state by starting and managing all the other background services (daemons), such as the SSH service, networking, and Docker.

## 2. How Processes Are Created and Managed

In Linux, a new process is typically created when an existing process "forks," creating an almost identical copy of itself. This new "child" process gets its own unique PID. While `systemd` is the ultimate parent of system services, every command you run (like `grep` or `ps`) also creates its own short-lived process. The `systemctl` command is used to manage the long-running services that `systemd` supervises.

## 3. The Role of `systemd`

As the system and service manager (PID 1), `systemd` is responsible for:
*   **Booting the System:** It efficiently starts services in parallel to speed up the boot process.
*   **Managing Services:** It can start, stop, restart, and check the status of daemons (e.g., `systemctl restart nginx`).
*   **Dependency Management:** It understands that certain services depend on others (e.g., a database must start before the web application) and starts them in the correct order.
*   **Logging:** It centralizes system logs through `journald`, which can be accessed with the `journalctl` command.

It matters because it provides a reliable and standardized way to manage a server's components, which is critical for troubleshooting and automation in DevOps.

## 4. Common Process States

*   **Running (R):** The process is actively executing on a CPU core.
*   **Sleeping (S):** The process is waiting for an event to happen, like a network request or disk read/write. This is a normal and common state.
*   **Zombie (Z):** A "dead" or terminated process. Its entry remains in the process table because its parent process hasn't yet acknowledged its death. Zombies don't consume resources but can indicate an issue with the parent application if they pile up.

## 5. Five Essential Daily Commands

1.  `ps -ef`: Lists all currently running processes on the system, showing their PID, parent PID, and the command that started them. Essential for a quick overview of what's active.
2.  `ls -lrth`: Lists files in a directory in a detailed, human-readable format, sorted by the most recent modification time. Perfect for seeing what has changed recently.
3.  `grep -i "error" /var/log/syslog`: Searches for a specific text pattern (like "error") within a file, ignoring case. Invaluable for analyzing log files.
4.  `top`: Provides a real-time, interactive view of system processes, showing CPU and memory usage. The first tool to use when a server is slow.
5.  `systemctl status nginx`: Checks the current status, recent logs, and PID of a service managed by `systemd`. A core command for managing applications.