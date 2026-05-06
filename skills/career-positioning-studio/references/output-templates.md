# Output Templates

Reference document loaded by SKILL.md when generating the four career-package files. Each section below is the exact Markdown structure for one output file. Do not paraphrase the structure — it is what makes the files reusable across candidates and parseable by ATS / downstream tools.

The universal anti-hallucination rules and ATS rules in `SKILL.md` apply to every output. This file only specifies the *structure*.

---

## Table of contents

1. `LinkedIn_Update_Plan.md` template
2. `Master_CV.md` template
3. `Professional_Development_Plan.md` template
4. `10_Target_Roles.md` template
5. Optional: `Career_Package.md` (concatenation header)

---

## 1. `LinkedIn_Update_Plan.md`

```markdown
# LinkedIn Update Plan

## New Headline (2 options)
- **Option A:** <60–90 character headline tuned to target title #1 from Q1>
- **Option B:** <60–90 character alternative emphasizing differentiator>

## New About Section
*(≤ 1800 characters total — LinkedIn's hard limit. Four paragraphs.)*

<Paragraph 1: open with the strongest single fact. E.g., "20+ years inside a Fortune-500 oilfield services major" or "Built three security teams from zero across two industries.">

<Paragraph 2: the arc — what they've done, ordered to make the differentiator land.>

<Paragraph 3: the now — what they're focused on, expressed in the vocabulary of their target track from Q1/Q2.>

<Paragraph 4: the call to action — "Open to <target titles>. Reach me at <email>.">

## Experience Section — Rewrite Prompts
For each of the user's 3 most recent roles, provide a 3-bullet rewrite using strong verbs and quantification.
Mark `[FILL: ...]` for any number, tool, or result not in the source.

### <Role 1 — title, employer, dates>
- <bullet 1>
- <bullet 2>
- <bullet 3>

### <Role 2 — title, employer, dates>
- ...

### <Role 3 — title, employer, dates>
- ...

## Skills Section — Top 10 to Pin
*(Ranked. Pin order matters — LinkedIn's recruiter search weights pinned skills heaviest.)*
1. <Skill 1 — most ATS-relevant for target track>
2. ...
10. ...

## Featured / Highlighted Content Suggestions
- <Idea 1: a post / project / publication to add to the Featured section>
- <Idea 2>
- <Idea 3>

## Profile Hygiene Checklist
- [ ] Custom URL set to `linkedin.com/in/<firstname-lastname>`
- [ ] Profile photo recent and professional
- [ ] Banner image set (industry-relevant, not a stock photo)
- [ ] "Open to work" toggle set with target titles, geo, work-auth status
- [ ] Recruiter visibility toggle ON
- [ ] Contact info includes email and (if comfortable) phone
- [ ] Skills endorsements requested from 5 prior colleagues
- [ ] Recommendations requested from 2–3 former managers
- [ ] All experience entries have a description (LinkedIn ranks profiles with descriptions higher)
```

---

## 2. `Master_CV.md`

```markdown
<!--
  ATS RULES (do not delete these comments — they help future-you tailor the doc):
    - Single-column reverse-chron, no tables for layout, no images.
    - Standard section headings only.
    - Dates as "Mon YYYY – Mon YYYY".
    - Bullets prefixed with "-".
    - All [FILL: ...] markers MUST be replaced before submitting.
  PDF EXPORT:
    - VS Code: install "Markdown PDF" extension → right-click → Export (pdf).
    - Pandoc:  pandoc Master_CV.md -o CV.pdf --pdf-engine=xelatex -V geometry:margin=0.6in -V mainfont="Calibri"
-->

# <Candidate Name>
**<Tagline aligned to target titles from Q1>**

<City, Region, Country> · <email> · [FILL: phone]
LinkedIn: <url> · <Web: url if any> · <Other: url if any>
[FILL: Authorized to work in <country> — confirm exact wording]

---

## Professional Summary

<4–5 sentences. Lead with the strongest differentiator. Mirror target titles from Q1. Mirror target industries from Q2. End with a "core competencies" sentence that names 4–6 keyword phrases.>

**Core competencies:** <8–14 ATS keywords, pipe-separated or middle-dot-separated>

---

## Technical Skills

> Replace `[FILL: …]` with the candidate's actual stack. Listing tools they have not used is the fastest way to fail an interview — only keep what they can defend.

- **Frameworks & Standards:** <NIST CSF, ISO 27001, MITRE ATT&CK, etc. — only what's in the source>
- **<Domain category 2>:** <items>
- **<Domain category 3>:** <items>
- **Cloud & DevSecOps:** [FILL: confirm Azure / AWS / GCP fluency]
- **Automation & Tooling:** [FILL: Python / PowerShell / Terraform / Ansible — confirm]

---

## Professional Experience

### <Most Recent Title>
**<Employer>** — <Location> — <Mon YYYY – Mon YYYY>
<One-sentence context: scope, scale, business unit if relevant.>

- <Bullet 1: strongest impact statement, quantified where possible.>
- <Bullet 2: scope / scale / responsibility.>
- <Bullet 3: a specific deliverable.>
- <Bullet 4: a specific tool / framework outcome.>
- [FILL: 1–2 more bullets if Tim/candidate can name specific deliverables.]

*(Repeat the role block above for every prior role. 4–6 bullets max per role. Older roles get fewer bullets.)*

---

## Certifications

> List ONLY certifications actually held, with issue / expiry years. If the source doesn't show any, leave the placeholder below.

- [FILL: <Cert Name> — <Issuer> — Issued YYYY (Expires YYYY if applicable)]
- [FILL: ...]

**In progress / planned:** [FILL: e.g., CCSP target Q3 2026]

---

## Education

**<Institution>** — <Degree, Field>, <Year> *(only if completion is confirmed in source)*

OR

**<Institution>** — Coursework in <field>, <Year range> *(use this phrasing if the source doesn't confirm a completed degree — never imply one that wasn't earned)*

**Continuous learning:** [FILL: SANS courses, vendor training, conferences attended]

---

## Languages

- English — Native / Professional
- [FILL: other languages with proficiency level]

---

## Selected Achievements & Recognition *(optional section)*

- [FILL: 4–6 career-defining bullets pulled from the experience section, quantified.]
```

---

## 3. `Professional_Development_Plan.md`

```markdown
# Professional Development Plan — 6–12 Months
**Candidate:** <name>
**Horizon:** <Month YYYY> – <Month +12 YYYY>

## Plan Logic

<Three sentences. Sentence 1 names the priority order and why. Sentence 2 ties it to gaps identified in the source profile. Sentence 3 names the single biggest unlock.>

---

## Certification Roadmap

| Tier | Cert | Issuer | Why | Approx Cost | Prep Hours |
| --- | --- | --- | --- | --- | --- |
| Tier 1 (0–6 mo) | <cert> | <issuer> | <one-sentence why> | <$> | <hrs> |
| Tier 1 (0–6 mo) | <cert> | <issuer> | <why> | <$> | <hrs> |
| Tier 2 (6–9 mo) | <cert> | <issuer> | <why> | <$> | <hrs> |
| Tier 3 (9–12 mo) | <cert> | <issuer> | <why> | <$> | <hrs> |

> Skip any cert the source confirms the candidate already holds. Pick currency for cost (CAD or USD) and label.

---

## Hands-on Projects (3–4)

### Project 1 — <name>
- **Goal:** <one sentence>
- **Deliverable:** <something demonstrable in an interview — repo, blog post, lab walkthrough>
- **Time estimate:** <weeks>

### Project 2 — <name>
*(repeat structure)*

### Project 3 — <name>
*(repeat structure)*

---

## Networking & Portfolio Milestones

| Month | Milestone | Notes |
| --- | --- | --- |
| 1 | LinkedIn rewrite live | Use the LinkedIn_Update_Plan.md output |
| 1 | <2nd milestone> | <notes> |
| 2 | <milestone> | <notes> |
| 3 | <milestone> | <notes> |
| 6 | <milestone> | <notes> |
| 9 | <milestone> | <notes> |
| 12 | <milestone> | <notes> |

---

## Curated Learning Resources

> Group by topic. For each topic give: official documentation link, one short tutorial, one YouTube channel/playlist. Prefer official sources first. Do NOT invent URLs — give a search query instead if uncertain.

### <Topic 1, e.g., CISSP>
- **Official:** <publisher / cert body URL>
- **Practice:** <textbook / question bank — name + ISBN if a book>
- **Video:** <YouTube channel / playlist name>

### <Topic 2>
*(repeat)*

### Calgary / Canadian / regional market intelligence
- <if relevant to candidate's geography>

---

## Open Items Requiring Candidate Input

These need answers from the candidate before the plan can be locked. Flagged so the candidate doesn't waste study time on certs they already hold or topics they already master.

1. <Open item 1>
2. <Open item 2>
3. <Open item 3>
4. <Open item 4>
5. <Open item 5>
```

---

## 4. `10_Target_Roles.md`

```markdown
# 10 Target Roles to Pursue
**Candidate:** <name>
**Goal context:** <one-sentence summary of Q1/Q2/Q3>

## Search Strategy

<Three sentences. Sentence 1 names the primary platforms and which filters to apply. Sentence 2 names the secondary platforms (industry-specific or regional). Sentence 3 names the cadence — how many to apply to per week, how many to warm-message per week.>

---

## Target Roles

### 1. <Role Title>
- **Likely employers:** <3–5 named employers OR categories if names not appropriate>
- **Why this fits:** <1–2 sentences citing verified candidate experience>
- **Fit score:** N/10
- **Required gaps to close:** <1–3 items drawn from the development plan>
- **Search query (LinkedIn):** `<exact query string the user can paste into LinkedIn Jobs>`
- **Search query (Indeed):** `<exact query string for Indeed>`

### 2. <Role Title>
*(repeat structure)*

### 3 – 10
*(repeat structure)*

---

## Outreach Targets — 5 People-Types to Message

The 80/20 rule of senior job search: most placements come from warm intros, not cold applications. Each week, send a personalised LinkedIn message to one person from each of these categories.

1. **<Role / category 1>** — <why this person matters; what to ask>
2. **<Role / category 2>** — <why; what to ask>
3. **<Role / category 3>** — <why; what to ask>
4. **<Role / category 4>** — <why; what to ask>
5. **<Role / category 5>** — <why; what to ask>

---

## Weekly Application Cadence

- **<Day 1>:** <action — e.g., "review the search queries above; save 10 promising postings; apply to 3.">
- **<Day 2>:** <action — e.g., "send 5 warm-intro messages from the outreach list">
- **<Day 3>:** <action — e.g., "20-minute study block from the development plan">

---

## Job Search Sources

For curated, hyperlinked job boards by category (general, cybersecurity-focused, tech/startups, remote-first, Canada-focused, Ontario-focused, government/cleared, energy/OT, recruiters/communities), see the companion reference: **`references/job-sources.md`**.
```

---

## 5. Optional: `Career_Package.md`

If the user asks for a single-file export, concatenate the four files in this order with horizontal rules between them:

```markdown
# Career Package
**Candidate:** <name>
**Generated:** <date>

> This file is the concatenation of four standalone deliverables. Each is also saved separately in this folder for individual editing.

---

<contents of LinkedIn_Update_Plan.md>

---

<contents of Master_CV.md>

---

<contents of Professional_Development_Plan.md>

---

<contents of 10_Target_Roles.md>
```

---

## Calibration notes for the model

- **Length budget per file:** LinkedIn plan ~600 words; CV ~600–800 words; dev plan ~700 words; target roles ~800 words. Going much longer hurts usability.
- **The summary at the top of the CV** is the most-read piece of any of these documents. Spend disproportionate care there.
- **The 10 target-roles section** is what makes the package actionable — without specific search queries, the user has nothing to do tomorrow morning. Don't skimp on the queries.
- **The development plan's "open items" list** is the single biggest signal of intellectual honesty in the package. If you can't think of any open items, you've probably hallucinated.
