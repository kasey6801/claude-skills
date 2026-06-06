# LLM Prompts I Like — Workflow Documentation

---

## Executive Overview

**LLM Prompts I Like** is a personal prompt library built inside Claude Code. It lets you save, version, and publish your favorite LLM prompts as structured Markdown files to a public GitHub repository. Two custom slash commands — `/capture-prompt` and `/create-prompt` — guide you through collecting metadata (intended use, original prompt, tool used, modified prompt, and version) before writing and auto-pushing each file to GitHub. The result is a searchable, version-controlled archive of prompts you can reuse across any AI tool.

---

## How This Workflow Was Built

### Step 1 — Create the Project Folder

**User prompt:**
> create a new folder named CC_LLM_Prompts_I_Like

**Claude actions:**
- Entered plan mode, wrote a plan to run `mkdir`
- Created `/Users/kcharles/ClaudeDev/CC_LLM_Prompts_I_Like`

---

### Step 2 — Initialize the Development Project

**User prompt:**
> start a development project in this folder. This project will create markdown (.md) files for prompts I submit. When I indicate that the following prompt is to be captured, confirm and then write the prompt to the new file. As an alternate, I can ask for a new prompt to be created to cover a specific focus area, and refine the prompt prior to writing it to a file. The files should be uploaded to a new Github repository named "LLM-Prompts-I-Like". Prepare the repository and set to public.

**Claude actions:**
- Spawned an Explore agent to check the environment: discovered GitHub CLI (`gh`) was not installed, confirmed git user config (`kasey6801`), and verified the folder was empty
- Asked the user how to handle the missing GitHub CLI (install via Homebrew vs. git + SSH/HTTPS)
- User selected: **Install gh CLI (Recommended)**
- Discovered Homebrew was also not installed; downloaded the `gh` v2.67.0 binary directly for macOS arm64 and installed it to `~/bin/`
- Initialized a git repository in the project folder
- Created `README.md` with project description and file naming conventions
- Created `CLAUDE.md` with instructions for Claude to follow in future sessions
- Prompted the user to authenticate with GitHub via `gh auth login`

---

### Step 3 — Authenticate and Push to GitHub

**User prompt:**
> Push to GitHub ghp_[token]

**Claude actions:**
- Used the provided personal access token to authenticate the `gh` CLI (`gh auth login --with-token`)
- Staged and committed `README.md` and `CLAUDE.md`
- Created the public GitHub repository `LLM-Prompts-I-Like` under account `kasey6801` using `gh repo create --public --source=. --remote=origin --push`
- Confirmed the repository was live at `https://github.com/kasey6801/LLM-Prompts-I-Like`

---

### Step 4 — Add Custom Slash Commands

**User prompt:**
> Can you create custom slash commands to capture prompts. Also, for each captured prompt, the following should be captured: Intended Use, The original user prompt, The tool used to generate the modified prompt, the modified prompt

**Claude actions:**
- Asked the user whether slash commands should be global or project-specific
- User confirmed: **project-specific**
- Created `.claude/commands/` directory inside the project folder
- Created `/capture-prompt` command: an interactive flow that collects all metadata fields one at a time, previews the file, writes it, commits, and pushes
- Created `/create-prompt [topic]` command: drafts a prompt from a topic, iterates with the user, then collects metadata and saves

---

### Step 5 — Add Version Numbering

**User prompt (during slash command creation):**
> The command should also ask the user to specify a version number. The current version number should be included in that prompt

**Claude actions:**
- Updated both slash command files to include a **Version** field
- The commands scan existing files for prior versions of the same prompt and suggest the next logical increment (e.g., 1.0 → 1.1 for edits, 1.0 → 2.0 for rewrites)
- Version is included in the filename: `YYYY-MM-DD_short-slug_v<version>.md`
- Version is included in the frontmatter and the git commit message

---

### Step 6 — Update CLAUDE.md and Push

**Claude actions:**
- Rewrote `CLAUDE.md` to document the new slash commands, the complete 4-field file format, version semantics, and the git workflow
- Committed and pushed all changes (`.claude/commands/capture-prompt.md`, `.claude/commands/create-prompt.md`, updated `CLAUDE.md`) to GitHub

---

## User Guide

This guide is for users new to Claude Code and VS Code.

---

### What You Need

- [Claude Code VS Code extension](https://marketplace.visualstudio.com/items?itemName=Anthropic.claude-code) installed
- A GitHub account
- This project folder open in VS Code

---

### Opening the Project

1. Open **VS Code**
2. Go to **File → Open Folder**
3. Navigate to and select `CC_LLM_Prompts_I_Like`
4. The Claude Code panel will appear in the sidebar (look for the Anthropic icon)

> The slash commands only appear when this folder is your open workspace. They won't show up in other projects.

---

### Using `/capture-prompt`

Use this when you already have a prompt you want to save.

1. Click into the Claude Code chat input
2. Type `/capture-prompt` — you'll see it appear in a dropdown menu as you type
3. Press **Enter**
4. Claude will ask you each of the following fields, one at a time:
   - **Title** — a short name for the prompt
   - **Version** — Claude will tell you the current version (or suggest `1.0` if new) and ask what version to save it as
   - **Intended Use** — one sentence describing what this prompt is for
   - **Original Prompt** — the raw prompt before any refinement
   - **Tool Used** — the model or tool that helped refine it (e.g., `Claude Sonnet 4.6`)
   - **Modified Prompt** — the final, polished version
   - **Tags** — 1–3 descriptive words, comma-separated
5. Claude will show you a preview of the file and ask you to confirm
6. Once you confirm, Claude writes the `.md` file and automatically commits and pushes it to GitHub

---

### Using `/create-prompt [topic]`

Use this when you want Claude to help you write a new prompt from scratch.

1. Type `/create-prompt` followed by your topic, e.g.:
   ```
   /create-prompt writing better code review comments
   ```
2. Press **Enter**
3. Claude drafts a prompt and presents it to you
4. Tell Claude what to change — you can go back and forth as many times as you like
5. When you're happy, say something like "looks good" or "save it"
6. Claude then asks for the metadata fields (same as above) and saves the file

---

### Where Files Are Saved

Each saved prompt becomes a `.md` file in the project folder:

```
CC_LLM_Prompts_I_Like/
  2026-04-16_code-review-comments_v1.0.md
  2026-04-20_summarize-meeting-notes_v1.0.md
  ...
```

Files are also automatically pushed to your GitHub repository:
**https://github.com/kasey6801/LLM-Prompts-I-Like**

---

### Updating an Existing Prompt

Run `/capture-prompt` again. When Claude asks for the version, it will detect any prior versions of the same prompt and suggest the next increment. Use:
- **Minor increment** (1.0 → 1.1) for small tweaks
- **Major increment** (1.0 → 2.0) for significant rewrites

Each version is saved as a separate file, so your history is preserved.

---

### Prompt File Format Reference

```markdown
---
title: "Your Prompt Title"
version: "1.0"
date: 2026-04-16
tags: [productivity, writing]
---

## Intended Use
One sentence explaining what this prompt accomplishes.

## Original Prompt
The raw prompt before any refinement.

## Tool Used
Claude Sonnet 4.6

## Modified Prompt
The final, refined version of the prompt ready to reuse.
```
