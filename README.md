# Claude Skills

A collection of reusable slash commands for [Claude Code](https://claude.ai/code).

---

## Skills

| Skill | Description |
|---|---|
| [`/capture-prompt`](#capture-prompt) | Save, version, and publish LLM prompts to GitHub |
| [`/book-club`](#book-club) | Personal book club assistant — recommendations, discussions, reading log |

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

## License

MIT
