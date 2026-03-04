### Git Branching & GitHub Concepts

```bash
<<>> 
# Git Branching & GitHub Concepts

## 1. Understanding Branches

### What is a branch in Git?
A branch is essentially a lightweight movable pointer to a commit. It represents an independent line of development. You can think of it as a "parallel universe" for your code where you can make changes without affecting the main codebase.

### Why use branches instead of committing to \`main\`?
*   **Isolation:** You can work on new features or bug fixes without breaking the stable version of the project (\`main\`).
*   **Collaboration:** Multiple developers can work on different features simultaneously without stepping on each other's toes.
*   **Code Review:** Branches allow for Pull Requests, where code can be reviewed before it is merged into the main project.

### What is \`HEAD\`?
\`HEAD\` is a special pointer that indicates "You Are Here." It points to the current branch reference (and effectively the latest commit) you are currently viewing in your working directory. If you switch branches, \`HEAD\` moves to point to the new branch.

### What happens to files when you switch branches?
Git updates the files in your **Working Directory** to match the snapshot of the branch you switched to. Files that exist in the new branch but not the old one will appear; files that exist in the old branch but not the new one will disappear.

---

## 2. GitHub & Remote Concepts

### Difference between \`origin\` and \`upstream\`?
*   **origin:** The default name given to the remote repository you cloned from. Usually, this is **your fork** or your own repository on GitHub.
*   **upstream:** A standard name given to the **original repository** that you forked. You use this remote to fetch the latest updates from the original project to keep your fork in sync.

### Difference between \`git fetch\` and \`git pull\`?
*   **\`git fetch\`**: Downloads new data (commits, branches) from the remote repository but **does not** integrate them into your working files. It is safe and non-destructive.
*   **\`git pull\`**: Automatically does a \`git fetch\` followed immediately by a \`git merge\`. It updates your current branch with the changes from the remote.

### Clone vs. Fork
*   **Clone:** A Git command (\`git clone\`) that creates a local copy of a remote repository on your machine.
*   **Fork:** A GitHub (server-side) concept. It creates a copy of someone else's repository into **your** GitHub account.
*   **When to use which:**
    *   Use **Clone** when you simply want to download code to run or edit locally.
    *   Use **Fork** when you want to contribute to an open-source project where you don't have write access. You fork it to your account, make changes, and submit a Pull Request.

### How to sync a fork?
1.  Add the original repo as a remote: \`git remote add upstream <original-url>\`
2.  Fetch changes: \`git fetch upstream\`
3.  Merge changes into your local main: \`git merge upstream/main\`
<<>> 
```

---

```markdown
## 5. Branching & Switching
| Command | Description | Example |
| :--- | :--- | :--- |
| `git branch` | Lists all local branches | `git branch` |
| `git branch <name>` | Creates a new branch | `git branch feature-login` |
| `git checkout <name>` | Switches to a specific branch | `git checkout feature-login` |
| `git switch <name>` | Modern way to switch branches | `git switch main` |
| `git switch -c <name>` | Create and switch in one step | `git switch -c feature-new` |
| `git branch -d <name>` | Deletes a branch (safe delete) | `git branch -d feature-old` |

## 6. Remote Interaction (GitHub)
| Command | Description | Example |
| :--- | :--- | :--- |
| `git remote -v` | Lists connected remote repos | `git remote -v` |
| `git remote add <name> <url>` | Connects a local repo to a remote | `git remote add origin https://github...` |
| `git push -u <remote> <branch>` | Uploads local branch to remote | `git push -u origin main` |
| `git pull` | Downloads and merges changes from remote | `git pull origin main` |
| `git fetch` | Downloads info without merging | `git fetch origin` |
| `git clone <url>` | Downloads a repo to local machine | `git clone https://github.com/...` |
```

---

#### 1. Branching Practice (Task 2)
Navigate to your practice folder:
```bash
cd devops-git-practice
```
```bash
# 1. List branches (You should only see main/master)
git branch

# 2. Create a new branch
git branch feature-1

# 3. Switch to it
git switch feature-1

# 4. Create AND Switch to feature-2
git switch -c feature-2

# 5. Make a change specific to this branch
echo "This file only exists in feature-2" > feature-2.txt
git add feature-2.txt
git commit -m "Added feature-2 specific file"

# 6. Switch back to main (Notice feature-2.txt disappears from your folder!)
git switch main
ls  

# 7. Delete feature-1 (Since we didn't do anything in it)
git branch -d feature-1
```

*Note: You must first go to [GitHub.com](https://github.com) and click "New Repository". Name it `devops-git-practice`. Do **not** check "Add README".*

Once created, copy the HTTPS URL (e.g., `https://github.com/YOUR_USERNAME/devops-git-practice.git`) and run:

```bash
# 1. Link your local repo to GitHub
git remote add origin https://github.com/<YOUR_USERNAME>/devops-git-practice.git

# 2. Rename branch to main (if not already)
git branch -M main

# 3. Push main branch
git push -u origin main

# 4. Push your feature branch
git switch feature-2
git push -u origin feature-2
```

#### Pull from GitHub (Task 4)
1.  Go to your GitHub repo in the browser.
2.  Open `git-commands.md` and click the **Pencil icon** (Edit).
3.  Add a line at the bottom: `Updated via GitHub UI`.
4.  Click **Commit changes**.
5.  Back in your terminal (ensure you are on `main` or the branch you edited):
    ```bash
    git pull origin main
    # Check the file to see the new line
    cat git-commands.md
    ```

**To Clone (Copy to local):**
```bash
cd .. # Go back one folder
git clone https://github.com/TrainWithShubham/90DaysOfDevOps.git shubham-clone-practice
```

**To Fork (Copy to your account):**
1.  Go to `https://github.com/TrainWithShubham/90DaysOfDevOps`.
2.  Click the **Fork** button (top right).
3.  Once it's on *your* account, clone *your* version:
    ```bash
    git clone https://github.com/<YOUR_USERNAME>/90DaysOfDevOps.git my-fork-practice

    ```

**Clone vs Fork**

Cloning, I realize, involves making a local copy using `git clone` for local work or read-only use. Forking, in contrast, is a server-side action creating a repository copy under my account. The key difference hinges on local access vs. server-side ownership. I'm focusing on providing practical examples tied to the user's assumed DevOps challenge context.


**Synchronization Needs**

Fork synchronization, since the upstream repository changes. I've broken down keeping a fork up-to-date into defining the upstream remote, fetching upstream changes, merging them into my local branch, and pushing the merged changes to my forked repository. My focus now is on explaining that, and why this is a good workflow to keep the fork synchronized with the original repository.


