#  Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Observations from Hands-On Practice

Throughout today's tasks, I executed various advanced Git operations to understand how branches are combined and how to context-switch efficiently. Here are my observations and answers to the challenge questions based on my terminal output:

---

### Task 1: Git Merge
**Observation:** 
When I merged the `feature-login` branch into `main`, Git performed a **Fast-forward** merge. The terminal explicitly showed `Fast-forward` and no separate merge commit was created.

**Answers:**
*   **What is a fast-forward merge?**
    A fast-forward merge happens when the target branch (`main`) hasn't had any new commits since the feature branch was created. Git simply moves (fast-forwards) the `main` pointer to point to the latest commit of the feature branch.
*   **When does Git create a merge commit instead?**
    Git creates a merge commit when the branches have *diverged*. This means new commits were added to `main` while you were simultaneously working on the feature branch. Git has to combine the two histories by creating a new unique commit.
*   **What is a merge conflict?**
    A merge conflict occurs when two divergent branches have modified the exact same line in the same file (which I experienced later on in the terminal when modifying `index.html`), or when one branch deletes a file while the other modifies it. Git pauses the merge/rebase because it cannot automatically figure out which version to keep. You must resolve it manually.

---

### Task 2: Git Rebase
**Observation:**
I performed a rebase of `feature-dashboard` onto `main`. I ran into a conflict with `index.html`, resolved it, and eventually got my branch successfully rebased. The `git log --graph` history showed a perfectly straight line rather than diverging branch paths.

**Answers:**
*   **What does rebase actually do to your commits?**
    Rebasing effectively rewrites history. It temporarily sets aside the commits you made on your feature branch, updates your branch base to the absolute latest commit of `main`, and then re-applies your feature commits one by one on top of the new base.
*   **How is the history different from a merge?**
    Unlike a merge, which preserves the timeline of when features diverged and came back together (creating a cluttered, web-like graph), a rebase creates a **linear history**. It looks as if you wrote your feature sequentially after `main` was updated.
*   **Why should you never rebase commits that have been pushed and shared with others?**
    Rebasing changes the underlying commit hashes. If you push a branch, someone else pulls it, and then you rebase and force-push, the other person's local repository will completely fall out of sync. This causes duplicate commits, messy merge conflicts, and lots of confusion. *Rule of thumb: Only rebase local, unshared branches.*
*   **When would you use rebase vs merge?**
    Use **rebase** to clean up local feature branches before integrating them, keeping the project's commit history linear and readable. Use **merge** when pulling a finished, shared feature into `main` so you preserve the exact context of how the code evolved.

---

### Task 3: Squash Commit vs Merge Commit
**Observation:**
I added four commits to `feature-profile` (Creating, Adding Bio, Fixing Typo, Formatting). Using `git merge --squash feature-profile`, Git staged all those changes without committing them. I then manually created one commit: `Complete profile feature (Squashed)`.

**Answers:**
*   **What does squash merging do?**
    Squash merging takes all the changes from all the commits on a feature branch and compresses ("squashes") them into a single new commit on the target branch.
*   **When would you use squash merge vs regular merge?**
    Squash merging is best when your feature branch has a lot of messy, incremental commits (like "wip", "typo fix", "oops fixed broken code") that don't add value to the main project history. A regular merge is better if each individual commit represents an important, logical milestone that you want to keep track of.
*   **What is the trade-off of squashing?**
    The main trade-off is losing granular commit history. If a bug is introduced in a massive squashed commit, it is much harder to isolate exactly which line of code or specific thought process caused it compared to having small, isolated commits.

---

### Task 4: Git Stash
**Observation:**
While on `feature-dashboard`, I added `Stash2 HTML` to `profile.html`. When I tried to `git switch main`, Git blocked me with an error: `Your local changes... would be overwritten by checkout`. I used `git stash` to safely store my WIP, switched successfully to `main`, returned to `feature-dashboard`, and brought my work back with `git stash pop`.

**Answers:**
*   **What is the difference between `git stash pop` and `git stash apply`?**
    `git stash pop` applies the most recent stashed changes to your working directory and immediately **deletes** the stash from your stash list. `git stash apply` applies the changes but **keeps** the stash in the list (useful if you want to apply the exact same stashed changes across multiple branches).
*   **When would you use stash in a real-world workflow?**
    Stashing is heavily used for context-switching. For example, if you are halfway through building a new feature and a high-priority bug is reported on production (`main`). You aren't ready to commit your broken feature code, so you `stash` it, switch to `main` to fix the bug, and then return to your feature branch and `pop` the stash to continue right where you left off.

---

### Task 5: Cherry Picking
**Observation:**
I created `feature-hotfix` with 3 commits (`Minor CSS fix`, `Critical payment bug fix`, `Update readme`). I then switched to `main` and ran `git cherry-pick f3a6546`, which pulled *only* the "Update readme" commit into `main`. The `git log` confirmed that the CSS and Payment bug fix commits were left behind.

**Answers:**
*   **What does cherry-pick do?**
    It allows you to select a specific commit from one branch by its hash and apply it directly onto your current branch, without merging the rest of the branch.
*   **When would you use cherry-pick in a real project?**
    If a developer fixes a critical bug on an uncompleted feature branch, you don't want to merge the whole unfinished feature just to get the fix. Instead, you can cherry-pick *just the commit containing the fix* over to `main` for deployment.
*   **What can go wrong with cherry-picking?**
    If the commit you are cherry-picking depends on code from an earlier commit in that branch (which you aren't bringing over), it will cause merge conflicts or broken code. Also, it creates duplicate commits (same changes but different hashes) which can cause confusion later if the original branch is finally merged.
```
