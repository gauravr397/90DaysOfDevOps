# Git Reset vs Revert & Branching Strategies

## Observations from Hands-On Practice

Today's tasks focused on safely undoing mistakes and understanding how professional engineering teams manage code at scale using branching strategies. Here are my notes and answers to the challenge tasks:

---

### Task 1: Git Reset
**Observation:**
I created three commits (A, B, C) and tested the three types of `git reset`. 
*   When using `--soft`, the commit history moved back, but the file changes stayed exactly as they were, fully staged (ready to be committed again).
*   When using `--mixed`, the commit history moved back, the changes stayed in my files, but they were *unstaged* (moved out of the staging area).
*   When using `--hard`, the commit history moved back, and my files reverted entirely to that previous state. All uncommitted changes were permanently deleted.

**Answers:**
*   **What is the difference between `--soft`, `--mixed`, and `--hard`?**
    *   `--soft`: Moves HEAD back but keeps changes in the Staging Area.
    *   `--mixed` (Default): Moves HEAD back, keeps changes in the Working Directory, but empties the Staging Area.
    *   `--hard`: Moves HEAD back and completely wipes out both the Staging Area and the Working Directory changes.
*   **Which one is destructive and why?**
    `--hard` is destructive because any uncommitted work in your working directory is permanently deleted. (Though `git reflog` can sometimes save you if the commit previously existed).
*   **When would you use each one?**
    *   `--soft`: When you want to combine multiple recent commits into one (squash) or simply rewrite the last commit message.
    *   `--mixed`: When you want to undo a commit and review the code again, perhaps to split the changes into multiple smaller commits.
    *   `--hard`: When you completely mess up an experiment and want to throw away all recent uncommitted work to start fresh from a previous known-good state.
*   **Should you ever use `git reset` on commits that are already pushed?**
    **No.** `git reset` rewrites history. If you reset pushed commits and force push, it will cause massive merge conflicts for anyone else who has already pulled that branch.

---

### Task 2: Git Revert
**Observation:**
I made three commits (X, Y, Z) and used `git revert <commit-hash-of-Y>`. Git opened my text editor to create a *new* commit message. 

**Answers:**
*   **How is `git revert` different from `git reset`?**
    `git reset` moves the branch pointer backward, effectively erasing commits from the history. `git revert` creates a brand new commit that performs the exact opposite changes of the target commit, keeping the project's history moving forward.
*   **Why is revert considered safer than reset for shared branches?**
    Because it doesn't rewrite history. It simply adds a new "undo" commit. Collaborators can pull the branch normally without their local repository getting confused or out of sync.
*   **When would you use revert vs reset?**
    Use **revert** to undo changes on public, shared branches (like `main` or `develop`). Use **reset** to clean up local, private feature branches before sharing them.

---

### Task 3: Reset vs Revert — Summary

| Feature | `git reset` | `git revert` |
| :--- | :--- | :--- |
| **What it does** | Moves HEAD and branch pointer back to a previous commit. | Creates a *new* commit that undoes the changes of a specific older commit. |
| **Removes commit from history?** | **Yes** | **No** (History moves forward) |
| **Safe for shared/pushed branches?**| **No** (Rewrites history) | **Yes** (Safe for collaboration) |
| **When to use** | Local, unpushed branches (cleaning up history, abandoning local work). | Shared, pushed branches (undoing a bad release or pushed bug). |

---

### Task 4: Branching Strategies

#### 1. GitFlow
*   **How it works:** A strict, structured model using multiple long-lived branches. `main` strictly holds production code. `develop` integrates features. Features are branched off `develop`. Release branches are used for QA before merging to `main`. Hotfix branches are used for emergency production bugs.
*   **Diagram:**
    ```text
    [main] <------- [hotfix]
      ^                 |
      |-- [release]     |
      |      ^          v
    [develop] <----- [feature]
    ```
*   **When/where it's used:** Best for large enterprise projects, strict compliance environments, or applications with scheduled release cycles (like mobile apps that need App Store approval).
*   **Pros and cons:** 
    *   *Pros:* Highly organized, great for distinct release versions.
    *   *Cons:* Overly complex, slows down delivery, high risk of "merge hell" due to long-lived branches.

#### 2. GitHub Flow
*   **How it works:** A lightweight, continuous delivery model. There is only one rule: `main` is always deployable. All new work happens in short-lived `feature` branches branched directly from `main`. Features are merged via Pull Requests and immediately deployed.
*   **Diagram:**
    ```text
    [main] --------------> (Deploy)
       \              /
        v            v[feature-branch] (PR / Review)
    ```
*   **When/where it's used:** Web applications, SaaS products, and continuous deployment (CI/CD) environments.
*   **Pros and cons:**
    *   *Pros:* Fast, simple, encourages continuous integration.
    *   *Cons:* Lacks a dedicated staging/QA branch phase, which might be risky without robust automated testing.

#### 3. Trunk-Based Development (TBD)
*   **How it works:** Developers commit directly to the `main` branch (the "trunk") multiple times a day. If branches are used, they only live for a few hours. Incomplete features are hidden from users using "Feature Flags" in the code.
*   **Diagram:**
    ```text
    [main (Trunk)] <--- Dev 1 (Small commit)
                   <--- Dev 2 (Small commit)
                   <--- Dev 3 (Small commit with Feature Flag)
    ```
*   **When/where it's used:** Mature DevOps teams (like Google, Netflix) aiming for elite CI/CD performance.
*   **Pros and cons:**
    *   *Pros:* Zero merge conflicts, extremely fast iteration, promotes constant collaboration.
    *   *Cons:* Requires massive discipline, excellent automated testing, and complex feature-flag management.

**Strategy Answers:**
*   **Which strategy would you use for a startup shipping fast?** 
    **GitHub Flow** or **Trunk-Based Development**. They minimize overhead and allow for rapid iterations and deployments.
*   **Which strategy would you use for a large team with scheduled releases?** 
    **GitFlow**. It provides the necessary structure to freeze code, run QA cycles, and prepare versioned releases safely.
*   **Which one does your favorite open-source project use?** 
    Many modern open-source projects, like **React**, use a variation of **GitHub Flow**. All development happens in Pull Requests merged into the `main` branch, keeping the workflow lean and collaborative.

---

### Task 5: Git Commands Reference Update
*(Note to self: Added the following to `git-commands.md` in the `devops-git-practice` repo)*

*   `git reset --soft <commit>`: Undo commit, keep changes staged.
*   `git reset --mixed <commit>`: Undo commit, keep changes unstaged.
*   `git reset --hard <commit>`: Undo commit, destroy all changes.
*   `git revert <commit>`: Create a new commit undoing the changes of a target commit.
*   `git reflog`: View a log of all branch updates/HEAD changes (useful for recovering lost commits after a hard reset).