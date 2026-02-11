# Networking Fundamentals & Hands-on Checks

## Quick Concepts
*   **OSI vs TCP/IP:** The OSI model is a 7-layer theoretical framework used for education, while the TCP/IP stack is a 4-layer practical model actually used in the real world.
*   **Mapping:** In TCP/IP, the top three OSI layers (Application, Presentation, Session) are merged into one **Application** layer. The bottom two OSI layers (Data Link, Physical) are merged into the **Network Access (Link)** layer.
*   **Stack Placement:**
    *   **Application Layer:** HTTP, HTTPS, DNS, SSH, FTP.
    *   **Transport Layer:** TCP, UDP.
    *   **Internet Layer:** IP (IPv4/IPv6), ICMP.
*   **Real Example:** `curl https://google.com` starts at the **Application** layer (HTTPS), gets encapsulated into **TCP** segments (Transport), which are wrapped in **IP** packets (Internet) to reach the destination.

---

## Hands-on Checklist

| Command | Output / Observation |
| :--- | :--- |
| **Identity:** `hostname -i` | My local IP is `127.0.1.1` (loopback). From `netstat`, my interface IP is `192.168.1.42`. |
| **Reachability:** `ping google.com` | Target resolved to `172.217.26.110`. Avg latency: **4.06 ms**. 0% packet loss. |
| **Path:** `traceroute google.com` | Hop 1: `192.168.1.1` (Home Router). Total 6 hops to reach Google's edge. |
| **Ports:** `ss -tulnp` | **Nginx** is listening on port **80**; **SSH** is listening on port **22**. |
| **Name Resolution:** `nslookup google.com` | Server: `127.0.0.53` (systemd-resolved). Resolved IP: `142.250.182.14`. |
| **HTTP Check:** `curl -i google.com` | Status: `HTTP/1.1 301 Moved Permanently`. Redirects to `www.google.com`. |
| **Connections:** `netstat -ano \| head` | Found multiple **LISTEN** states and an **ESTABLISHED** SSH connection. |

---

## Mini Task: Port Probe & Interpret
1.  **Listening Port:** Port `80` (tcp) is listening for Nginx.
2.  **Test:** `curl -i localhost:80`
3.  **Observation:** The service is **Reachable**. It returned a `200 OK` status with the "Welcome to nginx!" HTML body.
4.  **Next Check:** If it were unreachable, I would check the service status (`systemctl status nginx`) and then the firewall rules (`sudo ufw status`).

---

## Reflection
*   **Fastest Signal:** `ping` is the fastest way to see if the host is alive, but `nc -zv` (Netcat) is the fastest to see if the specific application port is open.
*   **DNS Failure:** I would inspect the **Application Layer** configuration (check `/etc/resolv.conf`) and then the **Internet Layer** (can I ping the DNS server's IP directly?).
*   **HTTP 500:** I would ignore the network and go straight to the **Application Layer** (Server-side logs) because a 500 error means the network connection is fine, but the app code crashed.
*   **Real Incident Checks:** 
    1.  Check if the process is actually running (`ps -ef | grep <service>`).
    2.  Check for local firewall blocks (`iptables -L`).

---
