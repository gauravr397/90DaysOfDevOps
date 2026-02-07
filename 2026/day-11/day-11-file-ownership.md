# File Ownership Challenge (chown & chgrp)
---

## 1. Files & Directories Created

During this challenge, I built a structured environment to simulate a team project:

| Name | Type | Initial Owner:Group |
| :--- | :--- | :--- |
| `devops-file.txt` | File | `gr:gr` |
| `team-notes.txt` | File | `gr:gr` |
| `project-config.yaml` | File | `gr:gr` |
| `app-logs/` | Directory | `gr:gr` |
| `heist-prj/` | Tree | `gr:gr` |
| `bank-heist/` | Tree | `gr:gr` |

---

## 2. Ownership Changes

I performed the following transitions to simulate moving files between different team members:

| Resource | Change Action | Final Ownership |
| :--- | :--- | :--- |
| `devops-file.txt` | `gr` → `tokyo` → `berlin` | `berlin:gr` |
| `team-notes.txt` | Group `gr` → `heist-team` | `gr:heist-team` |
| `project-config.yaml` | Combined change | `tokyo:heist-team` |
| `app-logs/` | Directory ownership | `berlin:heist-team` |
| `heist-prj/` | **Recursive** change | `berlin:planners` |

### Final Challenge: Bank Heist Setup
Inside the `bank-heist/` directory, I assigned specific roles to files:
- `access-code.txt`: **tokyo : vault-team**
- `blueprints.txt`: **berlin : tech-team**
- `escape-plan.txt`: **nairobi : vault-team**

---

## 3. Commands Used

### Basic Ownership
```bash
# Changing user (requires sudo)
sudo chown tokyo devops-file.txt
sudo chown berlin devops-file.txt

# Changing group
sudo groupadd heist-team
sudo chgrp heist-team team-notes.txt

# Combined User and Group change
sudo chown tokyo:heist-team project-config.yaml
```

### Recursive Directory Management
```bash
# Creating the structure
mkdir -p heist-prj/vault
mkdir -p heist-prj/plan
touch heist-prj/vault/gold.txt

# Applying ownership to the folder and everything inside it
sudo chown -R berlin:planners heist-prj/
```

---

## 4. Troubleshooting & Observations

1.  **Operation Not Permitted:** I confirmed that even as a "Power User," I cannot change the owner of a file to someone else without using `sudo`. This is a core security feature of Linux to prevent users from "dumping" files onto others.
2.  **Recursive Power:** Using the `-R` flag is extremely efficient. I verified with `ls -lrth heist-prj` that both the sub-directories (`vault/`, `plan/`) and the files inside them updated automatically.
3.  **Typos happen:** I accidentally typed `chowm` instead of `chown`. Zsh caught the error, reminding me that even in automated environments, command precision is key.

---

## 5. What I Learned
1.  **Identity Matters:** The difference between an **Owner** (the person who created or is responsible for the file) and a **Group** (a set of users who need shared access) is the foundation of Linux collaboration.
2.  **The Sudo Requirement:** Ownership changes are administrative tasks. Without root privileges, you can't reassign files, which ensures accountability.
3.  **Recursive Implementation:** In DevOps, we often deal with thousands of files in a deployment. Learning to use `-R` safely is critical for managing application logs and web root directories.

---
***
### Submission Log
```bash
❯ cd 2026/day-11
❯
❯
❯
❯ ls -lrth
total 8.0K
-rw-rw-r-- 1 gr gr 4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr gr    0 Feb  7 15:55 day-11-file-ownership.md
❯
❯
❯
❯ touch devops-file.txt
❯
❯ ls -lrth
total 8.0K
-rw-rw-r-- 1 gr gr 4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr gr    0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 gr gr    0 Feb  7 15:56 devops-file.txt
❯
❯
❯
❯ chown gr devops-file.txt
❯
❯
❯
❯ ls -lrth
total 8.0K
-rw-rw-r-- 1 gr gr 4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr gr    0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 gr gr    0 Feb  7 15:56 devops-file.txt
❯
❯
❯
❯
❯
❯ chown tokyo devops-file.txt
chown: changing ownership of 'devops-file.txt': Operation not permitted
❯
❯ sudo chown tokyo devops-file.txt
[sudo] password for gr:
sudo: a password is required
❯
❯
❯ chown tokyo devops-file.txt
chown: changing ownership of 'devops-file.txt': Operation not permitted
❯ sudo chown tokyo devops-file.txt
[sudo] password for gr:
❯
❯
❯
❯ ls -lrth
total 8.0K
-rw-rw-r-- 1 gr    gr 4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr    gr    0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 tokyo gr    0 Feb  7 15:56 devops-file.txt
❯
❯
❯
❯ sudo chown berlin devops-file.txt
❯
❯
❯ ls -lrtg
total 8
-rw-rw-r-- 1 gr 4448 Feb  5 18:30 README.md
-rw-rw-r-- 1 gr    0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 gr    0 Feb  7 15:56 devops-file.txt
❯ ls -lrth
total 8.0K
-rw-rw-r-- 1 gr     gr 4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr     gr    0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 berlin gr    0 Feb  7 15:56 devops-file.txt
❯
❯
❯
❯
❯
❯ touch team-notes.txt
❯
❯
❯ ls -rlth team-notes.txt
-rw-rw-r-- 1 gr gr 0 Feb  7 15:59 team-notes.txt
❯
❯
❯
❯ sudo groupadd heist-team
❯
❯
❯
❯ chgrp heist-team team-notes.txt
chgrp: changing group of 'team-notes.txt': Operation not permitted
❯ sudo chgrp heist-team team-notes.txt
❯
❯
❯ ls -lrth
total 8.0K
-rw-rw-r-- 1 gr     gr         4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr     gr            0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 berlin gr            0 Feb  7 15:56 devops-file.txt
-rw-rw-r-- 1 gr     heist-team    0 Feb  7 15:59 team-notes.txt
❯
❯
❯
❯
❯ touch project-config.yaml
❯
❯
❯ chowm tokyo:heist-team project-config.yaml
zsh: command not found: chowm
❯ sudo chown tokyo:heist-team project-config.yaml
❯
❯
❯ ls -lrth
total 8.0K
-rw-rw-r-- 1 gr     gr         4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr     gr            0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 berlin gr            0 Feb  7 15:56 devops-file.txt
-rw-rw-r-- 1 gr     heist-team    0 Feb  7 15:59 team-notes.txt
-rw-rw-r-- 1 tokyo  heist-team    0 Feb  7 16:01 project-config.yaml
❯
❯ mkdir app-logs/
❯
❯
❯ sudo chown tokyo:heist-team app-logs
❯
❯
❯ ls -lrth
total 12K
-rw-rw-r-- 1 gr     gr         4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr     gr            0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 berlin gr            0 Feb  7 15:56 devops-file.txt
-rw-rw-r-- 1 gr     heist-team    0 Feb  7 15:59 team-notes.txt
-rw-rw-r-- 1 tokyo  heist-team    0 Feb  7 16:01 project-config.yaml
drwxrwxr-x 2 tokyo  heist-team 4.0K Feb  7 16:02 app-logs
❯
❯
❯
❯ sudo chown berlin:heist-team app-logs
❯
❯
❯ ls -lrth
total 12K
-rw-rw-r-- 1 gr     gr         4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr     gr            0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 berlin gr            0 Feb  7 15:56 devops-file.txt
-rw-rw-r-- 1 gr     heist-team    0 Feb  7 15:59 team-notes.txt
-rw-rw-r-- 1 tokyo  heist-team    0 Feb  7 16:01 project-config.yaml
drwxrwxr-x 2 berlin heist-team 4.0K Feb  7 16:02 app-logs
❯
❯
❯
❯ mkdir -p heist-prj/vault
❯ mkdir -p heist-prj/plan
❯ touch heist-prj/vault/gold.txt
❯ touch heist-prj/vault/strategy.conf
❯
❯
❯ ls -lrth
total 16K
-rw-rw-r-- 1 gr     gr         4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr     gr            0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 berlin gr            0 Feb  7 15:56 devops-file.txt
-rw-rw-r-- 1 gr     heist-team    0 Feb  7 15:59 team-notes.txt
-rw-rw-r-- 1 tokyo  heist-team    0 Feb  7 16:01 project-config.yaml
drwxrwxr-x 2 berlin heist-team 4.0K Feb  7 16:02 app-logs
drwxrwxr-x 4 gr     gr         4.0K Feb  7 16:04 heist-prj
❯
❯
❯
❯ sudo groupadd planners
❯
❯
❯ chown -R berlin heist-prj
chown: changing ownership of 'heist-prj/vault/strategy.conf': Operation not permitted
chown: changing ownership of 'heist-prj/vault/gold.txt': Operation not permitted
chown: changing ownership of 'heist-prj/vault': Operation not permitted
chown: changing ownership of 'heist-prj/plan': Operation not permitted
chown: changing ownership of 'heist-prj': Operation not permitted
❯ sudo chown -R berlin heist-prj
❯
❯
❯ ls -lrth
total 16K
-rw-rw-r-- 1 gr     gr         4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr     gr            0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 berlin gr            0 Feb  7 15:56 devops-file.txt
-rw-rw-r-- 1 gr     heist-team    0 Feb  7 15:59 team-notes.txt
-rw-rw-r-- 1 tokyo  heist-team    0 Feb  7 16:01 project-config.yaml
drwxrwxr-x 2 berlin heist-team 4.0K Feb  7 16:02 app-logs
drwxrwxr-x 4 berlin gr         4.0K Feb  7 16:04 heist-prj
❯
❯
❯
❯ sudo chown -R berlin:heist-team heist-prj
❯
❯
❯ ls -lrth
total 16K
-rw-rw-r-- 1 gr     gr         4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr     gr            0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 berlin gr            0 Feb  7 15:56 devops-file.txt
-rw-rw-r-- 1 gr     heist-team    0 Feb  7 15:59 team-notes.txt
-rw-rw-r-- 1 tokyo  heist-team    0 Feb  7 16:01 project-config.yaml
drwxrwxr-x 2 berlin heist-team 4.0K Feb  7 16:02 app-logs
drwxrwxr-x 4 berlin heist-team 4.0K Feb  7 16:04 heist-prj
❯
❯ ls -lrth heist-prj
total 8.0K
drwxrwxr-x 2 berlin heist-team 4.0K Feb  7 16:04 plan
drwxrwxr-x 2 berlin heist-team 4.0K Feb  7 16:04 vault

❯
❯ sudo groupadd planners
groupadd: group 'planners' already exists
❯ sudo chown -R berlin:planners heist-prj
❯
❯
❯
❯ ls -lrth
total 16K
-rw-rw-r-- 1 gr     gr         4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr     gr            0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 berlin gr            0 Feb  7 15:56 devops-file.txt
-rw-rw-r-- 1 gr     heist-team    0 Feb  7 15:59 team-notes.txt
-rw-rw-r-- 1 tokyo  heist-team    0 Feb  7 16:01 project-config.yaml
drwxrwxr-x 2 berlin heist-team 4.0K Feb  7 16:02 app-logs
drwxrwxr-x 4 berlin planners   4.0K Feb  7 16:04 heist-prj
❯
❯
❯
❯
❯
❯
❯
❯ sudo useradd -m -s /usr/bin/zsh nairobi
❯
❯
❯
❯ sudo groupadd vault-team
❯ sudo groupadd tech-team
❯
❯
❯ mkdir bank-heist/
❯
❯
❯ touch bank-heist/access-code.txt
❯ touch bank-heist/blueprints.txt
❯ touch bank-heist/escape-plan.txt
❯
❯
❯
❯ sudo chown tokyo:vault-team bank-heist/access-code.txt
❯ sudo chown berlin:tech-team bank-heist/blueprints.txt
❯ sudo chown nairobi:vault-team bank-heist/escape-plan.txt
❯
❯
❯
❯ ls -lrth
total 20K
-rw-rw-r-- 1 gr     gr         4.4K Feb  5 18:30 README.md
-rw-rw-r-- 1 gr     gr            0 Feb  7 15:55 day-11-file-ownership.md
-rw-rw-r-- 1 berlin gr            0 Feb  7 15:56 devops-file.txt
-rw-rw-r-- 1 gr     heist-team    0 Feb  7 15:59 team-notes.txt
-rw-rw-r-- 1 tokyo  heist-team    0 Feb  7 16:01 project-config.yaml
drwxrwxr-x 2 berlin heist-team 4.0K Feb  7 16:02 app-logs
drwxrwxr-x 4 berlin planners   4.0K Feb  7 16:04 heist-prj
drwxrwxr-x 2 gr     gr         4.0K Feb  7 16:10 bank-heist
❯
❯
❯
❯ cd bank-heist
❯
❯ ls -lrth
total 0
-rw-rw-r-- 1 tokyo   vault-team 0 Feb  7 16:10 access-code.txt
-rw-rw-r-- 1 berlin  tech-team  0 Feb  7 16:10 blueprints.txt
-rw-rw-r-- 1 nairobi vault-team 0 Feb  7 16:10 escape-plan.txt

```