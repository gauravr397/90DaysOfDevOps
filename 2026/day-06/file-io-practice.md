# Day 06: Linux File I/O Practice

Today's goal was to practice basic file manipulation using redirection, appending, and viewing commands.

---

### 1. Creating and Writing to Files

I started by creating a file and practicing the difference between overwriting and appending.

**Commands:**
```bash
touch notes.txt

echo "Line 1" > notes.txt

echo "Line 2" >> notes.txt
```
*   **Observation:** The single `>` symbol overwrites the entire file. I learned that I must use `>>` to add content to the end of an existing file without deleting what is already there.

---

### 2. Using the `tee` Command

I used `tee` to append a third line while simultaneously seeing the output in my terminal.

**Command:**
```bash
echo "Line 3" | tee -a notes.txt
```
*   **Output:** `Line 3`
*   **Observation:** The `-a` flag is crucial here; it tells `tee` to append rather than overwrite. This is very useful in DevOps for writing to logs while still monitoring the output in real-time.

---

### 3. Reading File Contents

I practiced different ways to read the file based on how much data is needed.

**Commands:**
```bash
cat notes.txt

head -n 2 notes.txt

tail -n 2 notes.txt
```

**Actual File Content Output:**
```text
Line 1
Line 2
Line 3
```

---

### 4. Key Takeaways for DevOps

1.  **Redirection (`>` vs `>>`):** Inadvertently using `>` on a production config file can be disastrous as it wipes the existing configuration. Always double-check before hitting enter.
2.  **`tail` for Logs:** In real troubleshooting, `tail -f` is the most used command to watch application logs live.
3.  **`tee` for Permissions:** `tee` is often used with `sudo` to write to protected files when a standard `>` redirection would fail due to shell limitations.

```
