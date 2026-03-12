# GitHub CLI: Manage GitHub from Your Terminal

## Observations from Hands-On Practice

Today I explored the **GitHub CLI (`gh`)**, which is a massive productivity booster. Being able to manage repositories, issues, PRs, and workflows entirely from the terminal prevents context-switching and opens up huge automation possibilities. Here are my notes and answers to the challenge tasks:

---

### Task 1: Install and Authenticate
**Observation:**
I installed the GitHub CLI (via package manager like `apt` or `brew`) and authenticated using `gh auth login`. I was able to verify my active account status using `gh auth status`.

**Answer:**
*   **What authentication methods does `gh` support?**
    `gh` supports two primary authentication methods:
    1.  **Web Browser:** It opens a browser window to authorize the GitHub CLI OAuth app (very user-friendly).
    2.  **Authentication Token:** You can paste a Personal Access Token (PAT) directly into the terminal, which is essential for headless servers, CI/CD environments, and automated scripts.

---

### Task 2: Working with Repositories
**Observation:**
I successfully ran the following commands to manage repositories without ever opening github.com:
*   `gh repo create terminal-test-repo --public --add-readme` (Created a new repo)
*   `gh repo clone terminal-test-repo` (Cloned it locally)
*   `gh repo view` (Viewed the README and repo details in the terminal)
*   `gh repo list` (Listed all my repositories)
*   `gh repo view --web` (Opened the repository directly in my default web browser)
*   `gh repo delete terminal-test-repo --yes` (Deleted the repo bypassing the confirmation prompt)

---

### Task 3: Issues
**Observation:**
Managing issues from the CLI is incredibly fast. I created an issue using `gh issue create --title "Bug: Login fails" --body "Steps to reproduce..." --label "bug"`. I listed open issues with `gh issue list`, viewed the specific one using `gh issue view <number>`, and closed it using `gh issue close <number>`.

**Answer:**
*   **How could you use `gh issue` in a script or automation?**
    You can use it in a CI/CD pipeline (like a bash script or GitHub Action) to automatically generate an issue if a nightly test or build fails. By combining it with the `--json` flag (e.g., `gh issue list --json title,url`), you can fetch machine-readable data to automatically generate reports, send Slack/Discord notifications, or audit open bugs.

---

### Task 4: Pull Requests
**Observation:**
I created a branch, made a commit, pushed it, and then created a PR effortlessly using `gh pr create --fill` (which intelligently uses the commit message for the PR title/body). I checked the PR status with `gh pr list` and `gh pr status`. 

**Answers:**
*   **What merge methods does `gh pr merge` support?**
    When you run `gh pr merge`, it supports three methods:
    1.  **Create a merge commit** (`--merge`)
    2.  **Squash and merge** (`--squash`)
    3.  **Rebase and merge** (`--rebase`)
*   **How would you review someone else's PR using `gh`?**
    1.  First, pull their PR branch locally using: `gh pr checkout <PR-number>`
    2.  Review the code changes directly in the terminal using: `gh pr diff <PR-number>`
    3.  Submit a review decision using: `gh pr review <PR-number> --approve` (or `--request-changes` / `--comment "Looks good!"`)

---

### Task 5: GitHub Actions & Workflows (Preview)
**Observation:**
Even without deep diving into GitHub Actions yet, the CLI provides powerful monitoring commands. I used `gh run list` to see recent workflow executions and `gh run view <run-id>` to see the exact steps and status of a specific pipeline.

**Answer:**
*   **How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?**
    They allow you to trigger workflows programmatically via scripts (`gh workflow run <workflow-name>`). You can also write a deployment script that triggers a build, then uses `gh run watch <run-id>` to block and wait for the workflow to finish, and finally downloads the build artifacts using `gh run download`—all fully automated without human intervention.

---

### Task 6: Useful `gh` Tricks

I explored these advanced commands and will be adding them to my Git cheat sheet:
1.  `gh api <endpoint>`: Makes authenticated raw REST API calls (e.g., `gh api user`).
2.  `gh gist create <file>`: Instantly shares a code snippet file as a GitHub Gist.
3.  `gh release create <tag>`: Automates the creation of a software release with attached binaries/assets.
4.  `gh alias set <alias> <command>`: Creates custom shortcuts (e.g., `gh alias set co "pr checkout"`).
5.  `gh search repos <query>`: Quickly searches GitHub for open-source repositories right from the CLI.

---

### Reminder: `git-commands.md` Updates
*(Note to self: Added the following GitHub CLI commands to `git-commands.md`)*
*   `gh auth login` / `gh auth status`
*   `gh repo create/clone/list/view/delete`
*   `gh issue create/list/view/close`
*   `gh pr create/list/checkout/diff/review/merge`
*   `gh run list/view/watch`
*   `gh workflow run`