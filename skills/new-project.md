---
description: >
  Guides the user through setting up a new software project following the Project
  Process Guide, or assists with ongoing project workflows including backlog management
  and QC checks.
  TRIGGER when: user wants to start a new project, asks about project setup or
  structure, wants to add a backlog item with priority, or wants to run a QC check.
  DO NOT TRIGGER for: general coding questions, debugging, or feature implementation
  unrelated to project setup or process management.
---

# Project Process Skill

This skill implements the Project Process Guide workflow for setting up and maintaining structured software projects.

When invoked, ask the user which mode they need:

> "Which workflow would you like?
> A — Set up a new project
> B — Add an item to the backlog
> C — Run a QC check"

Wait for the user's response before proceeding.

---

## Mode A: New Project Setup

Collect the project name. If `$ARGUMENTS` was provided, use it as the project name.
Otherwise ask: *"What is the project name?"*

Then ask: *"Is this a JavaScript/Node.js project, or a different type?"*

Execute each step below in sequence. Confirm completion of each step before moving
to the next. Show the user what was created.

### Step 1: Create folder structure
Create the project root folder with the given name. Inside it, create:
- `_archive/` subfolder
- `RELEASE/` subfolder

### Step 2: Create CLAUDE.md
Create `CLAUDE.md` at the project root with this structure:

```
# [Project Name] -- Claude Code Instructions

## Project Overview
[Ask the user for a one-sentence description and insert it here]

## Non-Negotiable Rules
- Never edit compiled output directly. All UI changes go in src/. Run the build command to recompile.
- Never edit anything inside _archive/. It is read-only reference material.
- Never include _archive/, RELEASE/, CLAUDE.md, .env, or node_modules/ in any git commit or push.
- Always archive before deleting. Copy any file to _archive/ before removing it.
- Always update _archive/CHANGE_LOG.md when making changes.

## Build
[Ask the user for the build command or leave as placeholder]

## Project Structure
[Leave as placeholder -- fill in as files are created]

## Backlog Workflow
When the user requests a change, always ask:
"Would you like to implement this now or add it to the backlog?"
If adding to the backlog, ask: "What priority? P0 (critical), P1 (high), P2 (medium), or P3 (low)?"

## Timestamp Rule
Whenever any file is modified, update its Last updated header to today's date.

## Documentation Update Policy
After completing any task, always prompt:
"Would you like me to update the archive documentation for this change?"
- CHANGE_LOG.md -- required for every code change
- BUILD_OVERVIEW.md -- required if a file was added, removed, or its purpose changed
End every response with: CHANGE_LOG.md updated -- last entry: [N]
```

### Step 3: Create archive documents
Create these empty files inside `_archive/`:
- `CHANGE_LOG.md` with header: `# [Project Name] -- Change Log` and `*Append new entries below this line.*`
- `BUILD_OVERVIEW.md` with header: `# [Project Name] -- Build Overview` and `**Last updated:** [today's date]`
- `[ProjectName] Backlog.md` with the standard priority sections: P0, P1, P2, P3, and Completed
- `QC.md` with header: `# [Project Name] -- QC Log`

### Step 4: Create .env
Create `.env` at the project root with:
```
# [Project Name] -- local credentials
# Never commit this file. Never share its contents.

GITHUB_TOKEN=your_token_here
```

Remind the user: *"Replace 'your_token_here' with your GitHub Personal Access Token. Generate one at github.com > Settings > Developer settings > Personal access tokens. The token never goes in chat -- always reference it as $GITHUB_TOKEN."*

### Step 5: Create the exclusions file
Ask the user: *"What is the exclusions file called for this project type?"* (for most projects: `.gitignore`)

Create the file at the project root with:
```
# This file -- local only
[filename]

_archive/
RELEASE/
CLAUDE.md
.env
node_modules/
*.zip
.DS_Store
```

### Step 6: Initialise version control (if applicable)
Ask: *"Do you want to track source code changes with git? (Recommended for any project you will continue developing)"*

If yes:
- Run `git init`
- Run `git add .`
- Run `git commit -m "Initial commit"`

If no: skip this step and note that releases can still be published to GitHub via the API without git.

### Step 7: Create the GitHub repository (if applicable)
Ask: *"Do you want to create a GitHub repository for this project?"*

If yes:
- Ask: *"What should the repository be named?"*
- Ask: *"Public or private?"*
- Use `$GITHUB_TOKEN` from `.env` to call the GitHub API and create the repository
- Connect the local project to the remote
- Never ask the user to paste the token into chat

### Completion
After all steps, confirm:
*"Project [Name] is set up. Here is what was created: [list]. Next steps: add your build command to CLAUDE.md, replace the GITHUB_TOKEN placeholder in .env, and start building."*

---

## Mode B: Add to Backlog

Ask: *"What is the requested change or feature?"*

Then ask: *"What priority? P0 (critical -- blocking usage), P1 (high -- significant problem), P2 (medium -- improvement), or P3 (low -- nice-to-have)?"*

Format the entry using the next available BL-N number (read the backlog file to find the current highest number and increment by 1):

```
### BL-[N] -- [Short title] (P[priority])
**Added:** [today's date]
**Request:** [the user's original request]

**Implementation plan:**
[Describe the files to change, what to change, and how to verify -- ask the user for details if needed]
```

Append the entry under the correct priority section in `_archive/[ProjectName] Backlog.md`.

Confirm: *"BL-[N] added to the backlog at P[priority]."*

---

## Mode C: QC Check

Ask: *"Which category would you like to check?"*
- Consistency (names, version numbers, terminology)
- Dead code (unused files, functions, or rules)
- Stale references (documents pointing to things that no longer exist)
- Security (credentials, external dependencies, unexpected permissions)
- All of the above

Run the selected check against the active project files. For each finding:
1. Note the file and line or section
2. Describe the issue
3. Note the decision (fix now or log as unaddressed)

Log all findings in `_archive/QC.md` using the next available QC-N number. Use the format:

```
### QC-[N] -- [Short description]
**Found:** [today's date]
**File:** [filename:line]
**Issue:** [description]
**Decision:** [fix now / unaddressed]
**Status:** Unaddressed
```

Add a round summary table at the end of the QC entry.

Confirm: *"QC check complete. [N] findings logged in QC.md."*

---

## Standing Rules (active in all modes)

These rules apply throughout every session using this skill:

**Before making any change:** Ask *"Would you like to implement this now or add it to the backlog?"* If adding: ask for priority P0 through P3.

**After every execution:** Update CHANGE_LOG.md with a numbered entry. Confirm at the end: *"CHANGE_LOG.md updated -- last entry: [N]"*

**Timestamps:** Update the `**Last updated:**` header on every file touched.

**Credentials:** Never ask the user to paste a token into chat. Reference `$VARIABLE_NAME` from `.env`. After pushing with a token-embedded git URL, immediately restore the clean HTTPS remote URL.

**Archiving before deleting:** Copy to `_archive/` first. Then delete. Then log in CHANGE_LOG.md. Never edit files inside `_archive/`.

**Files never pushed to GitHub:** `_archive/`, `RELEASE/`, `CLAUDE.md`, `.env`, `node_modules/`, `*.zip`, `.DS_Store`

**Documentation updates:** After every task, check which archive documents need updating and prompt the user. Never update silently.

**Version numbers:** When a version number changes, update every file where it appears. Run `npm install` after updating `package.json`. Confirm all locations are in sync before pushing.
