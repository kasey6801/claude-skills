---
name: new-project
description: >
  Guides the user through setting up a new software project following the Project
  Process Guide (v1.2), or assists with ongoing project workflows including backlog
  management, QC checks, and design-first phases.
  TRIGGER when: user wants to start a new project, asks about project setup or
  structure, wants to add a backlog item with priority, wants to run a QC check,
  or wants to run a design-first phase before implementing a feature.
  DO NOT TRIGGER for: general coding questions, debugging, or feature implementation
  unrelated to project setup or process management.
---

# Project Process Skill (v1.2)

This skill implements the workflow from the Claude Code Project Process Guide v1.2.

When invoked, ask the user which mode they need:

> "Which workflow would you like?
> A — Set up a new project
> B — Add an item to the backlog
> C — Run a QC check
> D — Run a design-first phase (Step 0)"

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
See DESIGN_NOTES.md (Active Files section) for a full registry of active project files.

## Backlog Workflow
When the user requests a change, always ask:
"Would you like to implement this now or add it to the backlog?"
If adding to the backlog, ask: "What priority? P0 (critical), P1 (high), P2 (medium), or P3 (low)?"
If implementing a backlog item, confirm acceptance criteria are defined before starting.

## Timestamp Rule
Whenever any file is modified, update its Last updated header to today's date.

## Documentation Update Policy
After completing any task, always prompt:
"Would you like me to update the documentation for this change?"
- CHANGE_LOG.md -- required for every code change
- DESIGN_NOTES.md -- required if a file was added, removed, renamed, or its purpose changed; or a design decision was made; or a Step 0 phase was completed
End every response with: CHANGE_LOG.md updated -- last entry: [N]

## Design Reference
See DESIGN_NOTES.md for: active file registry, design decisions and alternatives considered,
and per-feature Step 0 design documents.

## Session Recovery
If resuming after an interruption, read CLAUDE.md, DESIGN_NOTES.md, and CHANGE_LOG.md first.
```

### Step 3: Create DESIGN_NOTES.md in the project root
Create `DESIGN_NOTES.md` at the project root (not inside `_archive/`) with this structure:

```markdown
# [Project Name] -- Design Notes

**Last updated:** [today's date]

---

## Active Files

*List every active file in the project here, with a one-line description of its purpose.
Update this section whenever a file is added, removed, renamed, or its purpose changes.*

---

## Design Decisions and Alternatives Considered

*Record significant architectural and design choices here, including the alternatives
that were considered and the reasons they were rejected. This section prevents future
sessions from re-proposing rejected approaches.*

---

## Feature Design Documents

*Append Step 0 design documents here as features are designed. Use the feature name
and date as a heading (e.g., ### Auth Module — 2026-05-22). For large documents,
summarise here and save the full text as a named file in the project root
(e.g., DESIGN_auth-module.md) with a link from this section.*
```

Remind the user: *"DESIGN_NOTES.md lives in the project root and is pushed to GitHub alongside the code. It is the single living design artifact for this project."*

### Step 4: Create archive documents
Create these files inside `_archive/`:

- `CHANGE_LOG.md` with header: `# [Project Name] -- Change Log` and `*Append new entries below this line.*`
- `[ProjectName] Backlog.md` with the standard priority sections: P0, P1, P2, P3, and Completed
- `QC.md` with header: `# [Project Name] -- QC Log`
- `EFFORT_INVESTMENT.md` with the following starter content:

```markdown
# [Project Name] -- Effort Investment Summary

**Prepared:** [today's date]
**Scope:** [Project description -- update as the project progresses]

---

## Executive Summary

| Measure | Value |
|---------|-------|
| AI-assisted session time | TBD |
| Equivalent human developer effort (no AI) | TBD |
| Logged changes | 0 |
| Calendar days | 0 |
| Files delivered | TBD |

---

## Effort Breakdown

| Work Category | Entries | Est. Hours | Description |
|---------------|---------|-----------|-------------|
| Initial setup | [001]--[00N] | [X] h | Project scaffold, CLAUDE.md, DESIGN_NOTES.md, archive docs, exclusions, version control |

---

## Learning Opportunities

*To be documented at project milestones or completion.*

---

## Output Delivered

*To be documented at project milestones or completion.*
```

- `CLAUDE_SECURITY_REVIEW.md` with the following starter content:

```markdown
# Security Review -- [Project Name]

**Reviewed:** [date of first review -- update on each review]
**Branch:** `main`
**Reviewer:** Claude (automated security analysis)

---

## No security review has been completed yet.

Run a review by typing: *"Run a security review of this project"* or use the `/security-review` slash command.

All findings at or above 8/10 confidence are reported and logged below. Findings below 8/10 are false positives and are dismissed with reasoning.

---

## Reviews

*Append each completed review here with date, branch, and findings.*
```

### Step 5: Create .env
Create `.env` at the project root with:
```
# [Project Name] -- local credentials
# Never commit this file. Never share its contents.

GITHUB_TOKEN=your_token_here
```

Remind the user: *"Replace 'your_token_here' with your GitHub Personal Access Token. Generate one at github.com > Settings > Developer settings > Personal access tokens. The token never goes in chat -- always reference it as $GITHUB_TOKEN."*

### Step 6: Create the exclusions file
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
Thumbs.db
desktop.ini
```

### Step 7: Initialise version control (if applicable)
Ask: *"Do you want to track source code changes with git? (Recommended for any project you will continue developing)"*

If yes:
- Run `git init`
- Run `git add .`
- Run `git commit -m "Initial commit"`

If no: skip this step and note that releases can still be published to GitHub via the API without git.

### Step 8: Create the GitHub repository (if applicable)
Ask: *"Do you want to create a GitHub repository for this project?"*

If yes:
- Ask: *"What should the repository be named?"*
- Ask: *"Public or private?"*
- Use `$GITHUB_TOKEN` from `.env` to call the GitHub API and create the repository
- Connect the local project to the remote
- Never ask the user to paste the token into chat

### Completion
After all steps, confirm:
*"Project [Name] is set up. Here is what was created: [list]. Next steps: add your build command to CLAUDE.md, replace the GITHUB_TOKEN placeholder in .env, and start building. When you are ready to implement your first feature, run Mode D to complete a design-first phase before writing any code."*

---

## Mode B: Add to Backlog

Ask: *"What is the requested change or feature?"*

Then ask: *"What priority? P0 (critical -- blocking usage or data loss), P1 (high -- significant problem or missing core feature), P2 (medium -- improvement), or P3 (low -- nice-to-have)?"*

Then ask: *"What are the acceptance criteria for this item? How will you know it is done and correct?"* (Can be filled in later -- if the user prefers to define criteria at implementation time, note that in the entry.)

Format the entry using the next available BL-N number (read the backlog file to find the current highest number and increment by 1):

```
### BL-[N] -- [Short title] (P[priority])
**Added:** [today's date]
**Request:** [the user's original request]

**Acceptance criteria:**
[What done looks like -- define before implementation starts. If not yet defined, note: "To be confirmed before implementation."]

**Implementation plan:**
[Describe the files to change, what to change, and how to verify -- ask the user for details if needed]
```

Append the entry under the correct priority section in `_archive/[ProjectName] Backlog.md`.

When a backlog item is about to be implemented, confirm: *"The acceptance criteria for BL-[N] are: [criteria]. Do these still apply, or do they need updating before we begin?"* Do not start implementation until criteria are confirmed.

When an item is implemented, move it from its priority section to a **Completed** section at the bottom of the backlog file, noting the CHANGE_LOG entry number.

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

## Mode D: Design-First Phase (Step 0)

Ask: *"What feature or change are you designing?"*

Walk the user through the five steps below in sequence. Each step uses a separate new Claude session where specified -- remind the user to open a new session before proceeding.

### Step 1: Design conversation (no-code rule)

Instruct the user to open a **new Claude session** and start with:

> *"We are going to design [feature]. No code will be written yet. I want a structured design conversation first. Ask me clarifying questions about what I am trying to accomplish, challenge my assumptions, and help me think through the edges of this problem."*

This phase should take 20--30 minutes. The goal is productive disagreement, not agreement. If Claude stops challenging ideas and starts agreeing with everything, prompt with:

> *"You are not being helpful. Your highest and best use right now is to challenge my thinking and force me to consider the edges of this problem."*

Do not proceed to Step 2 until the problem is stated precisely and the approach has survived challenge.

### Step 2: Write the design document

In the **same session** as the design conversation, ask Claude to write a four-section design document, one section at a time:

**Section 1 -- The Problem**
> *"Write Section 1: The Problem. Plain English, 3--5 sentences, no jargon."*

**Section 2 -- The Technical Plan**
> *"Write Section 2: The Technical Plan. Describe the components and how they connect. No code yet."*

**Section 3 -- Alternatives Considered**
> *"Write Section 3: Alternatives Considered. Document every approach we discussed that we are not using, and the reason we are not using it."*

**Section 4 -- Detailed Implementation**
> *"Write Section 4: Detailed Implementation. Enumerate every single file that will be created or changed, with a rationale for each. Be exhaustive."*

Save the completed document into `DESIGN_NOTES.md` under **Feature Design Documents**, using the feature name and date as a heading (e.g., `### Auth Module -- 2026-05-22`). For large documents, summarise in DESIGN_NOTES.md and save the full text as a named file in the project root (e.g., `DESIGN_auth-module.md`) with a link from DESIGN_NOTES.md.

### Step 3: Goldfish Comprehension Test

Open a **brand new Claude session** with no prior context. Provide only the design document and any files it references. Ask:

> *"Read this document and the files it references. Tell me what this project is trying to accomplish, how the system works, and what implementation would involve."*

**Pass:** Claude can accurately explain the system from the document alone.
**Fail:** Claude asks questions the document should answer, or gives an inaccurate explanation.

If it fails, add the missing information to the design document and repeat until it passes. Do not skip this step.

### Step 4: Adversarial design review

Open another **new Claude session** and run:

> *"Assume the role of an expert technical reviewer. Read this design document and tell me: all the things I missed, all the faulty assumptions, all the edge cases I have not considered, and everything I should have thought about but did not. Every flaw you find makes you more useful."*

Update the design document for every significant finding. Repeat until remaining suggestions are minor.

### Step 5: Confirm implementation readiness

Open one more **new Claude session** and ask:

> *"You are an experienced developer working with this codebase. Read this design document and the files it references. Does it have all the information you would need to implement this feature successfully on the first pass? What is missing or ambiguous?"*

Answer every question in the design document. Repeat until there are no important missing items or unresolved ambiguities.

### Proceed to implementation

Once the document passes all three tests, hand it to Claude in a new session:

> *"Read this design document and the files it references. Implement the feature as described. Follow the plan exactly."*

Log Step 0 completion in CHANGE_LOG.md and update DESIGN_NOTES.md with the completed design document.

---

## Standing Rules (active in all modes)

These rules apply throughout every session using this skill:

**Before making any change:** Ask *"Would you like to implement this now or add it to the backlog?"* If adding: ask for priority P0 through P3. Skip only if intent is unambiguous. If implementing a backlog item, confirm acceptance criteria are defined and still apply before starting.

**After every execution:** Update CHANGE_LOG.md with a numbered entry. Confirm at the end: *"CHANGE_LOG.md updated -- last entry: [N]"*

**Timestamps:** Update the `**Last updated:**` header on every file touched.

**Credentials:** Never ask the user to paste a token into chat. Reference `$VARIABLE_NAME` from `.env`. After pushing with a token-embedded git URL, immediately restore the clean HTTPS remote URL.

**Archiving before deleting:** Copy to `_archive/` first. Then delete. Then log in CHANGE_LOG.md. Never edit files inside `_archive/`.

**Files never pushed to GitHub:** `_archive/`, `RELEASE/`, `CLAUDE.md`, `.env`, `node_modules/`, `*.zip`, `.DS_Store`, `Thumbs.db`, `desktop.ini`.

**DESIGN_NOTES.md updates:** Update DESIGN_NOTES.md whenever a file is added, removed, renamed, or its purpose changes; whenever a significant design decision is made; and whenever a Step 0 phase is completed. DESIGN_NOTES.md lives in the project root and is pushed to GitHub.

**Before pushing to GitHub:**
1. Security review: Ask *"Would you like to run a security review before this push?"* If yes, run the `/security-review` slash command (or ask Claude to run one). Log all findings at or above 8/10 confidence in `_archive/CLAUDE_SECURITY_REVIEW.md`. Dismiss findings below 8/10 with brief reasoning.
2. Effort logging: Ask *"Would you like to update EFFORT_INVESTMENT.md before pushing?"* If yes, collect approximate session time, number of CHANGE_LOG entries made this session, and what was delivered. Update the Executive Summary totals and append a new row to the Effort Breakdown table.

**Documentation updates:** After every task, check which documents need updating and prompt the user. Never update silently.

**When to run a QC check:** Run Mode C proactively when a significant phase completes, naming or terminology changes occur, dead code is suspected, or a security concern arises -- not only when the user explicitly asks.

**Version numbers:** When a version number changes, update every file where it appears. Run `npm install` after updating `package.json`. Confirm all locations are in sync before pushing.
