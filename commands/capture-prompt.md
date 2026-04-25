Capture a prompt into a personal LLM prompt collection.

Follow these steps exactly:

1. Check the project root directory for any existing prompt files with a similar title or slug to determine the current version. If none found, the current version is "none" and suggest starting at `1.0`.

2. Ask the user for the following fields, one at a time, waiting for each answer before asking the next:
   - **Title**: A short descriptive title for this prompt
   - **Version**: Tell the user the current version (e.g., "Current version: 1.0 — what version should this be saved as?"). Suggest the next logical increment (e.g., 1.0 → 1.1 for minor changes, 1.0 → 2.0 for major rewrites). If no prior version, suggest `1.0`.
   - **Intended Use**: What is this prompt designed to accomplish? (one sentence)
   - **Original Prompt**: The raw, unmodified prompt the user started with. Apply these readability fixes before saving:
     - Capitalize the first word of every sentence and all acronyms (LLM, AI, APA, etc.)
     - Add end punctuation to every sentence that lacks it
     - Break run-on text into paragraphs grouped by logical theme
     - Format lists of URLs or items as markdown bulleted lists
     - Fix hyphenation for compound modifiers (peer-reviewed, fact-based, AI-generated, etc.)
     - Separate distinct instructions into clearly delineated paragraphs
   - **Tool Used**: What tool or model was used to generate or refine the modified prompt? (e.g., Claude Sonnet 4.6, ChatGPT-4o, manual, etc.)
   - **Modified Prompt**: The final, refined version of the prompt to save
   - **Tags**: Descriptive tags (comma-separated). **Validation rules — flag and ask the user to fix before proceeding:**
     - Each tag must be a single word or hyphenated compound (e.g., `prompt-engineering`) — no spaces allowed
     - Each tag must contain only letters, numbers, and hyphens (no special characters: `!`, `#`, `@`, `/`, etc.)
     - Each tag must be 30 characters or fewer
     - Tags should be lowercase (auto-correct silently)

3. Present a preview of the file content and ask the user to confirm before saving.

4. Once confirmed, write the file to the root of the project directory using this format:
   - Filename: `YYYY-MM-DD_short-slug_v<version>.md` (use today's date, derive slug from title)
   - Content:
     ```
     ---
     title: "<title>"
     version: "<version>"
     date: YYYY-MM-DD
     tags: [tag1, tag2]
     ---

     ## Intended Use
     <intended use>

     ## Original Prompt
     <original prompt>

     ## Tool Used
     <tool used>

     ## Modified Prompt
     <modified prompt>
     ```

5. After writing the file, commit and push it to your configured git remote:
   ```bash
   git add <filename> && git commit -m "Add: <title> v<version>" && git push
   ```

6. Confirm to the user that the prompt was saved and pushed to GitHub.
