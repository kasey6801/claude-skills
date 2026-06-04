# Claude Skills

A collection of reusable skills and slash commands for [Claude](https://claude.ai/) and [Claude Code](https://claude.ai/code).

---

## Skills

| Skill | Description |
|---|---|
| [`/capture-prompt`](#capture-prompt) | Save, version, and publish LLM prompts to GitHub |
| [`pdu-claim-info`](#pdu-claim-info) | Evaluate any learning content against PMI Talent Triangle categories and produce PDU claim options with CCRS guidance |
| [`/book-club`](#book-club) | Personal book club assistant — recommendations, discussions, reading log |
| [`career-positioning-studio`](#career-positioning-studio) | Generate a four-part career package — LinkedIn update plan, ATS-safe CV, professional development plan, and 10 target-role recommendations |
| [`/new-project`](#new-project) | Set up a new software project, manage a prioritised backlog, or run a QC audit |

---

## `/capture-prompt`

Save, version, and publish your favorite LLM prompts as structured Markdown files. The skill guides you through collecting metadata interactively, then writes a formatted file and pushes it to your GitHub repository automatically.

### Installation

Copy the skill file into the `.claude/commands/` directory of any Claude Code project:

```bash
mkdir -p .claude/commands
curl -o .claude/commands/capture-prompt.md \
  https://raw.githubusercontent.com/kasey6801/claude-skills/main/commands/capture-prompt.md
```

Or clone this repo and copy manually:

```bash
cp commands/capture-prompt.md /path/to/your-project/.claude/commands/
```

> **Requirement:** Your project must be a git repository with a remote configured (e.g., GitHub). The skill commits and pushes automatically after saving.

### Usage

In Claude Code, type:

```
/capture-prompt
```

Claude will collect the following fields one at a time:

| Field | Description |
|---|---|
| Title | Short descriptive name for the prompt |
| Version | Semantic version (e.g., `1.0`, `1.1`, `2.0`) |
| Intended Use | One sentence describing what the prompt accomplishes |
| Original Prompt | The raw user input before any refinement |
| Tool Used | Model or tool used to generate/refine the prompt |
| Modified Prompt | The final polished version |
| Tags | One or more descriptive tags (see rules below) |

### Prompt File Format

Files are saved as `YYYY-MM-DD_short-slug_v<version>.md` with this structure:

```markdown
---
title: "Prompt Title"
version: "1.0"
date: YYYY-MM-DD
tags: [tag1, tag2]
---

## Intended Use
What this prompt is designed to accomplish.

## Original Prompt
The raw, unmodified prompt the user started with.

## Tool Used
The tool or model used to generate/refine the modified prompt.

## Modified Prompt
The final, refined version of the prompt.
```

### Tag Rules

- Single words or hyphenated compounds only — **no spaces** (e.g., `prompt-engineering`, not `prompt engineering`)
- Letters, numbers, and hyphens only — no special characters (`!`, `#`, `@`, `/`, etc.)
- Maximum 30 characters per tag
- Lowercase (auto-corrected silently)

### Original Prompt Readability

The skill automatically applies these readability fixes to the Original Prompt field before saving:

- Capitalizes the first word of every sentence and all acronyms
- Adds end punctuation where missing
- Breaks run-on text into logical paragraphs
- Formats URL lists as markdown bullets
- Fixes compound-modifier hyphenation (peer-reviewed, fact-based, AI-generated)

---

## `/book-club`

A conversational literary companion that suggests books, leads discussions calibrated to how far you've read, and remembers your reading history across sessions.

### Installation

```bash
mkdir -p .claude/commands
curl -o .claude/commands/book-club.md \
  https://raw.githubusercontent.com/kasey6801/claude-skills/main/commands/book-club.md
```

### Usage

In Claude Code, type:

```
/book-club
```

Or trigger it naturally with phrases like "what should I read", "I just finished [book]", "book deep dive [title]", or "add to my reading log".

### Features

| Mode | Trigger | Description |
|---|---|---|
| Recommend | "what should I read?" | 2–3 picks personalized to your reading history |
| Discuss | "I'm reading [title]" | Spoiler-safe insights and reading questions |
| Deep Dive | "book deep dive [title]" | Themes → craft → context → legacy with live scholarly sources |
| Blow My Mind | "book blow my mind [title]" | The least obvious theory or hidden reading most people miss |
| Reading Log | "add to my log" | Freeform input, URL support, bulk import |
| Theme Explore | "explore a theme" | Books across literary fiction, non-fiction, and a wildcard |

### Controls

| Command | Effect |
|---|---|
| `book compact` | Shorter responses, fewer lookups |
| `book full` | Restore full mode |
| `book no sources` | Skip live web lookups |
| `book sources on` | Re-enable live lookups |
| `book no translate` | Suppress translation offers |
| `book translate on` | Re-enable translation offers |

### Language Support

Sources and responses available in English, French, Spanish, and others on request. Language preference is stored in memory and applied automatically across sessions.

---

## `career-positioning-studio`

Turn a LinkedIn profile (plus optional website / GitHub / existing CV) into a four-part career package: a LinkedIn update plan, an ATS-safe master CV, a 6–12 month professional development plan, and 10 target-role recommendations with ready-to-paste search queries. Includes a follow-up workflow for iterative refinement.

Unlike the slash-commands above, this is a **bundled skill** — `SKILL.md` plus reference files (`output-templates.md`, `job-sources.md`) — installed as a Claude skill rather than a single-file command.

### Installation

**Option A — Install the packaged `.skill` file** (Cowork, or Claude Code with the skill installer):

```bash
curl -L -o career-positioning-studio.skill \
  https://github.com/kasey6801/claude-skills/raw/main/skills/dist/career-positioning-studio.skill
```

Open the `.skill` file in your Claude client to install.

**Option B — Copy the source folder into a project's `.claude/skills/` directory:**

```bash
mkdir -p .claude/skills
git clone --depth 1 https://github.com/kasey6801/claude-skills.git /tmp/cs \
  && cp -r /tmp/cs/skills/career-positioning-studio .claude/skills/ \
  && rm -rf /tmp/cs
```

### Usage

The skill triggers automatically on natural-language openings like:

- "Help me update my LinkedIn"
- "Write me a new CV / resume"
- "Build me a professional development plan"
- "What jobs should I be applying for"
- "Career package"
- Pasting a LinkedIn URL or uploading a LinkedIn / résumé PDF in a job-search context

### Inputs

| Input | Required? | Notes |
|---|---|---|
| LinkedIn profile content | yes | Pasted text, PDF (read natively), or URL |
| Personal website / portfolio URL | no | Improves brand context |
| GitHub URL | no | Engineering signal |
| Existing CV / résumé | no | Text or PDF |
| Career-goal Q1 | recommended | Target titles |
| Career-goal Q2 | recommended | Target industries or employer types |
| Career-goal Q3 | recommended | Geography, timeline, constraints |

### Outputs

Four standalone Markdown files saved to your workspace folder:

| File | Contents |
|---|---|
| `LinkedIn_Update_Plan.md` | New headline (2 options), About section, experience rewrites, top-10 skills, profile-hygiene checklist |
| `Master_CV.md` | ATS-safe reverse-chronological CV with `[FILL: …]` placeholders for missing data |
| `Professional_Development_Plan.md` | Tiered certification roadmap, hands-on projects, networking milestones, curated learning resources |
| `10_Target_Roles.md` | Ten realistic role targets with employer types, fit scores, gap items, and LinkedIn / Indeed search queries |

### Refinement

After delivery, ask follow-up questions or request changes — the skill rewrites only the affected file(s). Examples:

- *"Make the CV more concise"*
- *"Add a project focused on AI security"*
- *"Swap target role 3 for something contract-friendly"*
- *"Why did you recommend that cert?"*

Clarification questions are answered in chat without modifying any files. Change requests rewrite the relevant file(s) and re-save.

### Anti-hallucination guards

- Never invents certifications, employers, dates, or metrics not in the source.
- Flags missing items with `[FILL: …]` placeholders the candidate must complete before sending.
- Calibrates claims honestly (e.g., "20+ years cybersecurity" rather than "24 years" if the first four years weren't security-titled).
- Asks one clarifying question rather than guessing on ambiguous requests.

### Companion artifact

A standalone Cowork HTML artifact version of the same workflow — interactive form, in-browser PDF text extraction, three export formats (`.md` / `.pdf` / `.docx`), and a chat-style refinement panel — runs the same prompts outside this repo. The skill version is leaner because Claude's native tools handle PDF reading, file I/O, and conversation directly.

---


---

## `/new-project`

Guide Claude through setting up a new software project from scratch, adding items to a structured backlog, or running a QC audit of an existing project.

### Installation

**Global install** (available in every Claude Code project on this machine):

```bash
mkdir -p ~/.claude/commands
curl -o ~/.claude/commands/new-project.md \
  https://raw.githubusercontent.com/kasey6801/claude-skills/main/commands/new-project.md
```

**Project-level install** (available only in the current project):

```bash
mkdir -p .claude/commands
curl -o .claude/commands/new-project.md \
  https://raw.githubusercontent.com/kasey6801/claude-skills/main/commands/new-project.md
```

### Usage

In Claude Code, type:

```
/new-project
```

Claude will ask which mode you need:

```
A -- Set up a new project
B -- Add an item to the backlog
C -- Run a QC check
```

### Modes

| Mode | What it does |
|---|---|
| **A -- New project** | Creates the project root, `_archive/` and `RELEASE/` folders, `CLAUDE.md`, archive documents (`CHANGE_LOG.md`, `BUILD_OVERVIEW.md`, backlog file, `QC.md`), `.env`, and exclusions file. Optionally initialises git and creates a GitHub repository. |
| **B -- Add to backlog** | Collects the request and priority (P0 critical / P1 high / P2 medium / P3 low), then appends a formatted `BL-N` entry to the project backlog file. |
| **C -- QC check** | Checks for consistency issues, dead code, stale references, or security problems, and logs findings to `_archive/QC.md` with `QC-N` numbering. |

### Standing rules

These apply throughout every session regardless of mode:

- Before any change: ask implement-now or add-to-backlog
- After every task: update `CHANGE_LOG.md` and confirm the entry number
- Credentials: never paste tokens into chat -- store in `.env` and reference as `$VARIABLE_NAME`
- Archive before deleting: copy to `_archive/` first, then remove, then log
- Timestamps: update the `**Last updated:**` header on every file touched

## License

MIT

---

## `pdu-claim-info`

Evaluate any professional learning content against the three PMI Talent Triangle categories (Ways of Working, Power Skills, Business Acumen) and receive a PDU claim analysis with executive summary, category strength ratings, and exactly three claiming options using the standard 0.25 / 0.5 / 0.75 / 1.0 PDU scale.

On first run the skill fetches the live PMI CCR handbook and saves it to memory. It prompts you to refresh once per calendar year, and uses a four-attempt URL resilience sequence if the primary link is unavailable.

### Installation

**Option A — Install the packaged `.skill` file** (Cowork, or Claude Code with the skill installer):

```bash
curl -L -o pdu-claim-info.skill \
  https://github.com/kasey6801/claude-skills/raw/main/skills/dist/pdu-claim-info.skill
```

Open the `.skill` file in your Claude client to install.

**Option B — Copy the source folder into a project's `.claude/skills/` directory:**

```bash
mkdir -p .claude/skills
git clone --depth 1 https://github.com/kasey6801/claude-skills.git /tmp/cs \
  && cp -r /tmp/cs/skills/pdu-claim-info .claude/skills/ \
  && rm -rf /tmp/cs
```

### Usage

The skill triggers automatically when you submit any learning content, or when you ask:

- "Where does this fit for PDUs?"
- "Can I claim PDUs for this?"
- "What qualifies as Business Acumen / Ways of Working / Power Skills?"
- Paste a video transcript, article, podcast summary, course description, or conference session notes

No explicit PDU question needed — submitting content is the trigger.

### Supported Content Types

| Format | Example |
|---|---|
| Video transcript | Paste the full or summarized transcript |
| Article or blog post | Paste the text or provide the URL |
| Course description | Module outline, syllabus, or course page |
| Podcast summary | Episode notes or summary text |
| Conference session | Session abstract or notes |
| Book chapter | Chapter summary or pasted excerpt |

### Output Structure

Every analysis produces:

| Section | Contents |
|---|---|
| Executive Summary | 2-3 sentences: content overview and primary PDU verdict |
| Ways of Working | Strength rating (Strong / Moderate / Weak / None) with justification |
| Power Skills | Strength rating with justification |
| Business Acumen | Strength rating with justification |
| Practical Claiming Guidance | 3 options with PDU value (0.25 / 0.5 / 0.75 / 1.0), category split, and CCRS path |
| Resources to Learn More | PMI CCR Handbook, CCRS portal, and content-specific links |
| Citations | APA-formatted references for the content and PMI sources |

### PDU Reference

| Certification | Cycle | Total PDUs | Min Each Category |
|---|---|---|---|
| PMP | 3 years | 60 | 8 |
| PMI-ACP | 3 years | 30 | 4 |

Power Skills and Business Acumen PDUs apply to both PMP and PMI-ACP simultaneously.

### Live Handbook Sync

On first run the skill fetches the PMI CCR handbook from two official sources and saves the extracted requirements to memory. It uses a four-attempt resilience sequence if the primary URL is unavailable:

1. Direct PDF URL (primary)
2. Maintain Your Certification page
3. Targeted web search on pmi.org
4. Broader web search across recognized PM sources

If all four attempts fail, the skill proceeds with stored or built-in defaults and tells you the date of the last successful fetch.

