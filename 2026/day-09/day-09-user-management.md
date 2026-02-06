# Linux User & Group Management Challenge

## 1. Users & Groups Created

### Users
- **tokyo**: Created with Zsh shell and home directory.
- **berlin**: Created with Zsh shell and home directory.
- **professor**: Created for administrative oversight.
- **nairobi**: Created for the project-team workspace task.

### Groups
- **dev**: (My version of `developers`)
- **adm-dummy**: (My version of `admins`)
- **project-team**: Created for shared workspace.

---

## 2. Group Assignments
I used the `usermod` command to assign users to their respective supplemental groups.

| User | Primary Group | Supplemental Groups |
| :--- | :--- | :--- |
| **tokyo** | tokyo | `dev`, `project-team` |
| **berlin** | berlin | `dev`, `adm-dummy` |
| **professor** | professor | `adm-dummy` |
| **nairobi** | nairobi | `project-team` |

**Verification Command:**
```bash
cat /etc/group | grep -E "dev|adm-dummy|project-team"
```

---

## 3. Directories & Permissions
I created shared workspaces in `/opt` and configured ownership so that group members could collaborate.

### Directory: `/opt/dev-prj`
- **Group Owner:** `dev`
- **Permissions:** `775` (rwxrwxr-x)
- **Status:** Verified. User `berlin` successfully created `testing.txt` in this directory even though `tokyo` is the owner.

### Directory: `/opt/team-workspace`
- **Group Owner:** `project-team`
- **Permissions:** `775`
- **Status:** Setup for `nairobi` and `tokyo` collaboration.

---

## 4. Commands Used

### Task 1 & 2: Creation
```bash
sudo useradd -m -s /usr/bin/zsh tokyo
sudo useradd -m -s /usr/bin/zsh berlin
sudo useradd -m -s /usr/bin/zsh professor
sudo useradd -m -s /usr/bin/zsh nairobi

sudo passwd tokyo
sudo passwd berlin

sudo groupadd dev
sudo groupadd adm-dummy
sudo groupadd project-team
```

### Task 3: Group Membership
```bash
sudo usermod -aG dev tokyo
sudo usermod -aG dev,adm-dummy berlin
sudo usermod -aG adm-dummy professor
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo
```

### Task 4 & 5: Permissions & Ownership
```bash
sudo mkdir /opt/dev-prj
sudo chgrp -R dev /opt/dev-prj
sudo chmod -R 775 /opt/dev-prj

sudo su - berlin
cd /opt/dev-prj
touch testing.txt
```

---

## 5. What I Learned
1.  **Shell Defaults:** Using `useradd -s /usr/bin/zsh` ensures that new users don't start with the limited `sh` shell, providing them a better experience (Powerlevel10k support).
2.  **Redirection & Locking:** Encountering `cannot lock /etc/passwd` taught me that simultaneous administrative tasks can lock system files, and using `sudo` is mandatory for these modifications.
3.  **Group Collaboration:** I learned that setting the **Group ID** and **775 permissions** allows users in the same group to work on the same project files without needing to be the "root" user.
4.  **Verification:** Checking `/etc/passwd` and `/etc/group` is the most reliable way to verify system changes.

---

## 6. Screenshots
- `![alt text](image-1.png)`
***
