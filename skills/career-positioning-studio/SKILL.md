---
name: career-positioning-studio
description: >-
  Generates a four-part career package — LinkedIn update plan, ATS-optimized
  master CV, 6–12 month professional development plan, and 10 target-role
  recommendations with ready-to-paste search queries — from a LinkedIn profile
  and optional supporting evidence (website, GitHub, existing CV). Use this
  skill whenever the user wants career repositioning help, even if they don't
  say "career package" explicitly. Triggers include "career package", "career
  plan", "update my LinkedIn", "rewrite my LinkedIn", "new CV", "new resume",
  "ATS resume", "tailor my resume", "master resume", "professional development
  plan", "what certifications should I get", "target roles", "what jobs should
  I apply for", "job search strategy", "I'm looking for a new role", "I'm
  between jobs" — and also fires when the user pastes a LinkedIn URL or
  uploads a LinkedIn or résumé PDF in a career-search context. Anti-
  hallucination guards: never invents certifications, employers, or
  metrics; flags missing items with bracketed FILL placeholders.
---

# Career Positioning Studio

A career-coaching skill that turns a candidate's LinkedIn profile (plus any optional evidence they provide) into four cohesive Markdown deliverables. The four outputs are produced together because they reinforce each other — the same career-goal answers shape all four.

## When to use this skill

Use this any time someone is repositioning for the job market. Don't wait for the user to say "career package" — the same need shows up as "help me update my LinkedIn", "I need to refresh my resume", "what should I be learning next", "what jobs should I be looking at", "I just got laid off, where do I start", or simply by them uploading a LinkedIn PDF and asking for help. If you're reading a résumé and the user wants advice on what to do next, this skill applies.

## What the skill produces

Four separate Markdown files, saved to the user's workspace folder:

1. **`LinkedIn_Update_Plan.md`** — new headline, About section, experience-rewrite prompts, top-10 skills, profile-hygiene checklist.
2. **`Master_CV.md`** — ATS-safe, reverse-chronological master CV with `[FILL: …]` placeholders for anything that can't be verified from sources.
3. **`Professional_Development_Plan.md`** — tiered certification roadmap, hands-on project ideas, networking milestones, curated learning resources keyed to the gaps identified.
4. **`10_Target_Roles.md`** — ten realistic target-role recommendations with employer types, fit scores, gap items, and ready-to-paste LinkedIn / Indeed search queries.

Optionally offer the user a fifth deliverable, `Career_Package.md`, that concatenates all four for single-file export.

## Workflow

### Step 1 — Gather the candidate evidence

The LinkedIn profile is required. Accept it in any of these forms:

- **Pasted text.** The user paste-bombs their headline, About, Experience, Education, Skills, Certifications.
- **PDF.** Read it natively with the Read tool. LinkedIn's "Save to PDF" output works fine — Read handles the OCR / text-layer extraction.
- **LinkedIn URL.** If you have browser tools (e.g., Claude in Chrome MCP, WebFetch, or similar), use them to pull rendered page text. Otherwise ask the user to paste.

Optional supporting evidence — accept whatever's offered:

- Personal website / portfolio URL
- GitHub URL
- Existing CV / résumé (paste, .md, .pdf, .docx, .txt)

If the user uploads a PDF, read it with the Read tool. Don't write your own PDF parser.

### Step 2 — Run the three-question career-goals interview

These three questions decide the shape of all four outputs. If the user has already answered them earlier in the conversation, do not re-ask — just summarise back what you understood and proceed. Otherwise, ask them with **one** AskUserQuestion call (if available) so the user answers all three together. If AskUserQuestion isn't available, ask in a single message.

1. **Which job titles or role types are you targeting?** *(e.g., "Senior Security Architect, OT/ICS Lead, Director of SecOps")*
2. **Which industries, employer types, or company sizes interest you?** *(e.g., "Energy / utilities / critical infrastructure; mid-to-large enterprise")*
3. **Geographic preference, timeline, and any constraints?** *(e.g., "Calgary AB or remote-Canada; 6-month horizon; no relocation; need work-auth sponsorship")*

If the user declines to answer one or more, infer plausible defaults from the LinkedIn profile and label them as inferred in the outputs.

### Step 3 — Generate all four files

Read **`references/output-templates.md`** for the exact structure of each file, plus the universal anti-hallucination rules. Read **`references/job-sources.md`** when generating section 4 (target roles) so the search-platform recommendations are accurate and current.

Save each file with the exact filenames listed above. If the user has a preferred output folder, use it; otherwise save to the active workspace folder.

After saving, present the files via clickable links and a one-paragraph summary of the strategic positioning call (e.g., "Primary track: OT/ICS energy; secondary: Senior Security Architect"). Do **not** write a long postamble — the files are the deliverable.

### Step 4 — Offer the natural follow-ups

After delivery, offer (don't immediately do) these:

- Export any section as PDF or Word.
- Run a job-posting analysis on a specific posting they've found (gap analysis + cover letter + interview prep).
- Refine the package — see Step 5.

### Step 5 — Handle follow-up questions and refinements

The candidate will almost always have follow-up questions or change requests after seeing the first draft. Treat the package as a living document, not a one-shot deliverable. Two distinct kinds of follow-up:

**Clarification questions** *("Why did you recommend GICSP?", "What does ATS-safe mean?", "Why is the summary only 4 sentences?")*: just answer in chat. Do not regenerate any files. Be specific and brief.

**Change requests** *("Make the CV more concise", "Add an OT/AI-security project to the dev plan", "Swap target role 3 for something contract-friendly", "Reframe me as a generalist not a specialist", "Drop the Calgary geography focus")*: rewrite only the affected file(s). Do not regenerate the whole package — that wastes the candidate's review effort on sections they already approved. After rewriting, save the updated file to the same path so the user has fresh versions, and tell them in one sentence what changed and why.

When a change touches multiple files (e.g., "Reframe my whole positioning toward GRC" touches all four), edit each affected file one at a time so the candidate can review each change before the next.

**Rules that persist across refinements** — the same anti-hallucination guards from §"Universal output rules" apply to every refinement. Do not invent during refinement either; flag with `[FILL: …]` if the candidate asks for content the source doesn't support.

**Ambiguous requests**: ask one clarifying question rather than guessing. *"Make the dev plan shorter"* could mean fewer certs, fewer projects, or just less prose — ask which.

## Universal output rules — applied to every section

These rules are non-negotiable. They prevent the most common failure mode (a confident-sounding output that contains fabricated facts):

1. **Never invent.** No fabricated employers, certifications, degrees, dates, metrics, or tools. If something would be useful but isn't in the source, write `[FILL: <description of what to add>]`. The placeholder is the candidate's prompt to fill in real data before sending the document anywhere.
2. **ATS-safe phrasing.** Spell out acronyms once, then reuse the acronym. Mirror common industry terminology rather than inventing new phrasing.
3. **Markdown only.** No HTML, no images. Tables are allowed where they're natural (certification roadmap, gap analysis), but never use tables for layout.
4. **Specific over generic.** Cut filler ("hard worker", "team player", "results-driven"). Every bullet must say something a reader couldn't already infer from the candidate's title.
5. **Lead with differentiators.** Single-employer tenure, regional rotations, specialty domains, unusual combinations of experience — surface these in the Professional Summary, the LinkedIn About, and the cover letter, not buried in role bullets.
6. **Explain recommendations.** Whenever you recommend a certification, project, role, or framework, briefly say *why* — one sentence is enough.
7. **Tier honesty.** When the candidate's evidence doesn't support a claim, say so. "20+ years of cybersecurity" is defensible if their security-titled roles span 20+ years; "24 years" might overshoot if the first three years were IT support. Calibrate carefully.

## ATS rules specific to the master CV

These exist on top of the universal rules, and only for `Master_CV.md`:

- **Single-column reverse-chronological layout.** No tables for layout. No text boxes. No images. No header/footer regions. No multi-column sections.
- **Standard section headings** (parsers map them to known fields): *Professional Summary*, *Core Competencies*, *Technical Skills*, *Professional Experience*, *Certifications*, *Education*, *Languages*.
- **Date format:** `Mon YYYY – Mon YYYY`. Avoid "Present" mid-document; use the explicit end month.
- **Bullets** prefixed with the dash character (`-`). It renders as a solid bullet on PDF export and is the most-parser-compatible glyph.
- **Keyword spine.** Every term ATS keyword filters look for must appear at least once in *Technical Skills* AND once inside an experience bullet — single occurrence is often filtered as "mention without depth."
- **Acronyms expanded once** (e.g., "Security Information and Event Management (SIEM)") then reused as the acronym, since some ATS configurations index only one form.
- **No graphics, icons, emoji, or special characters** in the CV body.

## Style notes for each output

- **LinkedIn Update Plan** — write the new About section as 4 paragraphs, ≤ 1800 characters total (LinkedIn's hard limit on the About field). The headline gets two options because the user will A/B them.
- **Master CV** — every role gets 4–6 bullets max. More than that gets skimmed past. The Professional Summary is 4–5 sentences; the lead sentence is the strongest single fact about them.
- **Development Plan** — the certification roadmap is a Markdown table with columns: Tier, Cert, Issuer, Why, Approx Cost (CAD or USD — pick one and label), Prep Hours. Hands-on projects get 3–4 entries with goal + deliverable + time estimate. The "open items" list at the end captures questions the candidate must answer to finalise the plan (which certs they actually hold, which cloud platform they're fluent in, etc.).
- **10 Target Roles** — each entry has *exactly* this shape: role title, likely employers (3–5 names or categories), why this fits (1–2 sentences referencing verified experience), fit score (N/10), required gaps to close (1–3 items pulled from the development plan), LinkedIn search query, Indeed search query. After the 10 entries, add 5 outreach-target people-types and a 3-bullet weekly application cadence.

## When information is missing

The most common case: the LinkedIn profile is sparse. It lists titles and dates but no certifications, no metrics, no tooling. Don't synthesise — flag every gap with `[FILL: …]` and produce a list of "Open items requiring candidate input" at the bottom of the development plan. The placeholders are the candidate's homework. A CV with 8 placeholders that get filled in is far more valuable than a CV with 0 placeholders and 8 invented facts.

## Worked example — calibration check

If a candidate's LinkedIn shows 24 years at one employer with progressive titles, all in cybersecurity since year ~5: the right summary lead is *"20+ years cybersecurity inside a Fortune-500 [industry] major"* — defensible, foregrounds the differentiator, doesn't overshoot. The wrong lead is *"24 years cybersecurity experience"* — overshoots if the first 4 years were IT support, and a hiring manager who finds the discrepancy will downgrade everything else you wrote.

## File outputs — naming and location

Save outputs as:

```
<workspace>/LinkedIn_Update_Plan.md
<workspace>/Master_CV.md
<workspace>/Professional_Development_Plan.md
<workspace>/10_Target_Roles.md
```

If the user has a connected workspace folder (e.g., `~/Documents/Claude_Cowork` in Cowork), save there; otherwise the current working directory. Don't stuff all four into one file unless the user specifically asks.

## What this skill is not

- **Not a job board scraper.** The 10-target-roles file produces *search queries*, not live postings. Live postings go stale; queries don't.
- **Not a one-and-done.** Treat the output as a draft. Most candidates iterate at least once after filling the `[FILL: …]` placeholders.
- **Not a replacement for a human career coach** in high-stakes transitions (executive search, regulated-industry switches, post-incident reputation rebuilds). Add that caveat if the candidate's situation looks unusual.
