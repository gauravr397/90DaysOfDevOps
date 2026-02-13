# Networking Concepts: DNS, IP, Subnets & Ports

## Task 1: DNS – How Names Become IPs

**1. What happens when you type `google.com` in a browser?**
The browser first checks its local cache. If not found, it asks the OS (which checks the `hosts` file/cache). If still not found, the query goes to the Resolver (ISP), which queries Root Servers, then TLD Servers (.com), and finally the Authoritative Name Server for `google.com` to get the IP address.

**2. Record Types:**
- **A:** Maps a hostname to an IPv4 address (e.g., `google.com` -> `142.250.182.142`).
- **AAAA:** Maps a hostname to an IPv6 address.
- **CNAME:** Maps an alias name to a true/canonical domain name (e.g., `www` -> `google.com`).
- **MX:** Specifies the mail servers responsible for accepting email.
- **NS:** Nameserver records that delegate a DNS zone to use specific authoritative name servers.

**3. Output Analysis (`dig google.com`):**
From my terminal output:
- **A Record:** `142.250.182.142`
- **TTL (Time To Live):** `40` (seconds before the cache expires)

```bash
;; ANSWER SECTION:
google.com.             40      IN      A       142.250.182.142
```

---

## Task 2: IP Addressing

**1. What is an IPv4 address?**
It is a 32-bit unique address used to identify devices on a network. It is structured as four decimal numbers (octets) separated by dots, ranging from 0 to 255 (e.g., `192.168.1.10`).

**2. Public vs Private IPs:**
- **Public IP:** Unique across the entire internet and routable globally (e.g., Google's `142.250.182.142`).
- **Private IP:** Used within a local network (LAN) and not accessible directly from the internet (e.g., my home WiFi IP `192.168.1.43`).

**3. Private IP Ranges:**
- Class A: `10.0.0.0` to `10.255.255.255`
- Class B: `172.16.0.0` to `172.31.255.255`
- Class C: `192.168.0.0` to `192.168.255.255`

**4. My Private IPs (`ip addr show`):**
- Interface `enp2s0f1` (Ethernet): `192.168.1.42/24`
- Interface `wlp3s0` (WiFi): `192.168.1.43/24`

---

## Task 3: CIDR & Subnetting

**1. What does `/24` mean in `192.168.1.0/24`?**
It represents the **Subnet Mask**. It means the first 24 bits of the address belong to the Network, and the remaining 8 bits are for Hosts. The mask is `255.255.255.0`.

**2. Usable Hosts:**
- `/24`: 254 hosts ($2^8 - 2$).
- `/16`: 65,534 hosts ($2^{16} - 2$).
- `/28`: 14 hosts ($2^4 - 2$).

**3. Why do we subnet?**
We subnet to break large networks into smaller, manageable pieces. This improves **security** (isolating departments), increases **performance** (reducing broadcast traffic), and allows for better organization of IP allocations.

**4. CIDR Table:**

| CIDR | Subnet Mask | Total IPs | Usable Hosts |
|------|-------------|-----------|--------------|
| /24  | 255.255.255.0 | 256       | 254          |
| /16  | 255.255.0.0   | 65,536    | 65,534       |
| /28  | 255.255.255.240 | 16      | 14           |

---

## Task 4: Ports – The Doors to Services

**1. What is a port?**
A port is a virtual endpoint (numbered 0-65535) that allows a computer to run multiple services simultaneously. It ensures data goes to the correct application (e.g., Web traffic to port 80, Email to port 25).

**2. Common Ports:**

| Port | Service |
|------|---------|
| 22   | SSH (Secure Shell) |
| 80   | HTTP (Web Traffic) |
| 443  | HTTPS (Secure Web Traffic) |
| 53   | DNS |
| 3306 | MySQL / MariaDB Database |
| 6379 | Redis |
| 27017| MongoDB |

**3. My Active Ports (`ss -tulpn`):**
- **Port 22:** SSH Daemon (`sshd`)
- **Port 80:** Nginx Web Server (Confirmed by `curl localhost:80` output showing "Welcome to nginx!")

---

## Task 5: Putting It Together

**1. You run `curl http://myapp.com:8080` — what concepts are involved?**
First, **DNS** resolves `myapp.com` to an IP. Then, a **TCP** connection is established to that IP on specific **Port** `8080` (a non-standard web port). Finally, an **HTTP** GET request is sent.

**2. Your app can't reach a database at `10.0.1.50:3306` — what would you check first?**
Since it is a private IP, I would first check **Firewalls/Security Groups** to ensure Port 3306 is open for inbound traffic from my app's IP. Then, I'd check if the database service is actually running on the target server.

---
