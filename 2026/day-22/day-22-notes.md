### Step 1: Create the Directory

```bash
mkdir -p 2026/day-22
cd 2026/day-22
```

### Step 2: Create `day-22-notes.md`

```bash
<<EOF > 

## 1. What is the difference between \`git add\` and \`git commit\`?
*   **\`git add\`**: Moves changes from the **Working Directory** to the **Staging Area**. It tells Git, "I want to include these specific changes in the next snapshot."
*   **\`git commit\`**: Takes everything currently in the **Staging Area** and saves it permanently to the **Local Repository** (history) with a descriptive message.

## 2. What does the staging area do? Why doesn't Git just commit directly?
The **Staging Area** (or Index) acts as a buffer or a "rough draft" zone. It allows you to pick and choose specific changes to commit rather than committing every modified file at once. This ensures that commits are clean, atomic, and focused on a single logical change.

## 3. What information does \`git log\` show you?
It displays the history of the repository, including:
*   **Commit Hash** (SHA-1 checksum): Unique ID for the commit.
*   **Author**: Name and email of the person who made the change.
*   **Date**: Timestamp of the commit.
*   **Commit Message**: Description of what was changed.

## 4. What is the \`.git/\` folder and what happens if you delete it?
The \`.git/\` folder is the brain of the repository. It contains all the metadata, object database, configuration settings, and the entire commit history.
*   **If deleted:** The project loses all version history and becomes a standard folder. You cannot run git commands, view logs, or revert changes anymore.

## 5. Difference between Working Directory, Staging Area, and Repository?
1.  **Working Directory**: The actual files on your disk that you are currently editing. (Untracked/Modified).
2.  **Staging Area**: A preview zone where files are prepared for the next commit. (Staged).
3.  **Repository (.git directory)**: The permanent database where Git stores the snapshots (commits) and history. (Committed).
EOF
```

### Step 3: Create `git-commands.md`

```bash
<<EOF > 

A living document of Git commands used during the 90DaysOfDevOps challenge.

## 1. Setup & Configuration
| Command | Description | Example |
| :--- | :--- | :--- |
| \`git config --global user.name "Name"\` | Sets the name attached to your commits | \`git config --global user.name "John Doe"\` |
| \`git config --global user.email "email"\` | Sets the email attached to your commits | \`git config --global user.email "jd@example.com"\` |
| \`git init\` | Initializes a new Git repository in the current folder | \`git init\` |
| \`git clone <url>\` | Downloads an existing repository from a remote source | \`git clone https://github.com/user/repo.git\` |

## 2. Basic Workflow
| Command | Description | Example |
| :--- | :--- | :--- |
| \`git status\` | Shows the state of working directory and staging area | \`git status\` |
| \`git add <file>\` | Moves a file to the staging area | \`git add script.sh\` |
| \`git add .\` | Stages all changes in the current directory | \`git add .\` |
| \`git commit -m "msg"\` | Saves staged changes to history | \`git commit -m "Fixed login bug"\` |

## 3. Viewing Changes & History
| Command | Description | Example |
| :--- | :--- | :--- |
| \`git log\` | Shows the commit history | \`git log\` |
| \`git log --oneline\` | Shows a condensed history (Hash + Message) | \`git log --oneline\` |
| \`git diff\` | Shows differences between working dir and staging | \`git diff\` |
| \`git show <hash>\` | Shows changes made in a specific commit | \`git show a1b2c3d\` |

## 4. Branching (Upcoming)
| Command | Description | Example |
| :--- | :--- | :--- |
| \`git branch\` | Lists all local branches | \`git branch\` |
EOF
```

### Step 4: Simulate the "Multiple Commits" (Optional)

```bash
# 1. Add files initially
git add .
git commit -m "Day 22: Initial commit of notes and cheat sheet"

# 2. Modify the cheat sheet (Simulating Task 5)
echo -e "\n| \`git help <cmd>\` | Shows manual for a command | \`git help commit\` |" >> git-commands.md
git add git-commands.md
git commit -m "Day 22: Added help command to cheat sheet"

# 3. Modify it again
echo -e "\n| \`git remote -v\` | Lists remote connections | \`git remote -v\` |" >> git-commands.md
git add git-commands.md
git commit -m "Day 22: Added remote command to cheat sheet"
```

### Step 5: Verify Output
To get the screenshot requested in the submission:

```bash
git log --oneline | head -n 5
```

Finally, push your work:
```bash
git push origin master
```