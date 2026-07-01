---
description: Append a summary of the current work session (prompts + changes) to Interaction-Log.html at your workspace root, grouped by folder and date.
argument-hint: [optional note to include with the entry]
---

# /interaction-log — append this session to the Interaction Log

Maintain a single self-contained **`Interaction-Log.html`** at the root of your workspace: a
browsable, offline record of your work sessions, grouped by folder and date. Run this command at the
end of a session to append a summary of the current session. Any text in **$ARGUMENTS** is an
optional note to fold into the change summary.

**Where the log lives.** Treat your **workspace root** as the top-level folder you run Claude Code
from, the directory that holds your projects. The log file is `Interaction-Log.html` at that root,
and every folder path is recorded relative to it. If you keep the log somewhere else, adjust the
paths accordingly.

## What to capture
1. **Date:** today's date as absolute `YYYY-MM-DD` (do not hardcode; check the current date).
2. **Primary working folder:** the folder holding the files created/modified this session, written
   as the **path relative to your workspace root** (for example `projects/my-app` or
   `notes/research`). If the session touched several folders, pick the **most-changed** one as
   primary and record the others inside the change summary. Produce **one combined entry** per
   logging run (do not split across folders).
3. **Prompts:** every user prompt submitted this session, in order, quoted verbatim (trim only
   obvious noise). Prompts are quoted data, so keep their wording as-is.
4. **Summary of changes:** a concise bullet list of what changed (files created/edited and what
   was done; note any commits/pushes and any other folders touched).

## Formatting rules
- **HTML-escape** all logged text: `&` → `&amp;`, `<` → `&lt;`, `>` → `&gt;`. Wrap file paths and
  identifiers in `<code>…</code>`.
- **No em dashes in your own prose**; use commas, colons, periods, or middots.
- Newest first: newest folder on top of `#log`, newest date on top within a folder.
- Do **not** add external/network resources. The page stays fully self-contained.
- Do **not** commit or push. The log is a local record, and version control is left to you.

## Update algorithm
1. If `Interaction-Log.html` does **not** exist, create it from the **Base template** below.
2. Find the `<details class="folder">` whose `<span class="path">` text equals the primary folder.
   - **If it exists:** move that entire `<details>` block so it is the **first** child of
     `<main id="log">`. Then look inside its `.folder-body` for
     `<section class="entry" data-date="TODAY">`:
     - present → **append** the new `<li>` prompt items to its `<ol class="prompts">` and the new
       `<li>` change items to its `<ul class="changes">`.
     - absent → **prepend** a new date `<section>` (see snippet) as the first child of
       `.folder-body`.
   - **If it does not exist:** build a new `<details class="folder" open>` (summary = the path)
     containing one date `<section>`, and insert it as the **first** child of `<main id="log">`.
3. Update the folder's `<span class="count">` to `"N date"` / `"N dates"` (count of `section.entry`).
4. Report one line: folder logged, date, and counts of prompts/changes. Offer to `open` the file.

## Snippets

New **folder** block (insert as first child of `#log`):
```html
  <details class="folder" open>
    <summary><span class="chev" aria-hidden="true">▸</span><span class="path">PRIMARY/FOLDER/PATH</span><span class="count">1 date</span></summary>
    <div class="folder-body">
      <!-- date section goes here -->
    </div>
  </details>
```

New **date** section (prepend inside `.folder-body`):
```html
      <section class="entry" data-date="YYYY-MM-DD">
        <h2 class="entry-date">YYYY-MM-DD</h2>
        <p class="lbl">Prompts</p>
        <ol class="prompts">
          <li>ESCAPED PROMPT TEXT</li>
        </ol>
        <p class="lbl">Summary of changes</p>
        <ul class="changes">
          <li>ESCAPED CHANGE ITEM</li>
        </ul>
      </section>
```

## Base template (only used when the file is missing)
```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="referrer" content="no-referrer">
<title>Interaction Log</title>
<script>
(function(){try{var t=localStorage.getItem('theme');if(!t){t=window.matchMedia&&window.matchMedia('(prefers-color-scheme: dark)').matches?'dark':'light';}if(t==='dark'){document.documentElement.setAttribute('data-theme','dark');}}catch(e){}})();
</script>
<style>
:root{
  --sans:system-ui,-apple-system,"Segoe UI",Roboto,Helvetica,Arial,sans-serif;
  --mono:ui-monospace,"SF Mono",Menlo,Consolas,"Liberation Mono",monospace;
  --paper:#E9E1CF; --paper-2:#E1D8C2; --card:#F3EDDD;
  --ink:#1C1A15; --ink-soft:#4A463C; --line:#C5BAA0;
  --stamp-red:#B23A2E; --seal-green:#2E6149; --warp:#E8590C;
  --shadow:0 2px 0 rgba(28,26,21,.14);
}
[data-theme="dark"]{
  color-scheme:dark;
  --paper:#17150F; --paper-2:#1F1B14; --card:#221E17;
  --ink:#ECE3D0; --ink-soft:#B3AA96; --line:#403829;
  --stamp-red:#E08A7C; --seal-green:#69B294;
  --shadow:0 2px 0 rgba(0,0,0,.45);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth}
body{font-family:var(--sans);color:var(--ink);line-height:1.6;
  background:radial-gradient(1100px 620px at 12% -8%, rgba(255,255,255,.55), transparent 60%),radial-gradient(1000px 680px at 108% 112%, rgba(28,26,21,.10), transparent 60%),var(--paper);
  min-height:100vh;padding:2.4rem 0 4rem;}
[data-theme="dark"] body{background:radial-gradient(1100px 620px at 12% -8%, rgba(255,255,255,.04), transparent 60%),radial-gradient(1000px 680px at 108% 112%, rgba(0,0,0,.35), transparent 60%),var(--paper);}
.wrap{max-width:912px;margin:0 auto;padding:0 22px}
#theme-toggle{position:fixed;top:14px;right:14px;z-index:50;font-family:var(--mono);font-size:.72rem;letter-spacing:.08em;text-transform:uppercase;background:var(--card);color:var(--ink);border:1.5px solid var(--ink);border-radius:6px;box-shadow:var(--shadow);padding:.42rem .6rem;cursor:pointer;}
#theme-toggle:hover{transform:translateY(-1px)}
:focus-visible{outline:2px solid var(--stamp-red);outline-offset:2px}
header.wrap{margin-bottom:1.4rem}
.eyebrow{font-family:var(--mono);font-size:.72rem;font-weight:600;letter-spacing:.16em;text-transform:uppercase;color:var(--stamp-red);margin-bottom:.5rem;}
h1{font-size:clamp(1.9rem,5vw,2.7rem);font-weight:900;letter-spacing:-.02em;line-height:1.05;color:var(--ink);}
.intro{color:var(--ink-soft);margin-top:.6rem;max-width:60ch}
.toolbar{display:flex;gap:.5rem;flex-wrap:wrap;align-items:center;margin:1.2rem 0 .9rem;}
.toolbar .t-label{font-family:var(--mono);font-size:.68rem;letter-spacing:.14em;text-transform:uppercase;color:var(--ink-soft);margin-right:.1rem;}
.tbtn{font-family:var(--mono);font-size:.7rem;letter-spacing:.06em;text-transform:uppercase;background:transparent;color:var(--ink-soft);border:1.5px solid var(--line);border-radius:6px;padding:.32rem .6rem;cursor:pointer;}
.tbtn:hover{border-color:var(--ink);color:var(--ink)}
#log{display:flex;flex-direction:column;gap:1rem}
details.folder{background:var(--card);border:1.5px solid var(--ink);border-radius:8px;box-shadow:var(--shadow);overflow:hidden;}
details.folder>summary{list-style:none;cursor:pointer;display:flex;align-items:center;gap:.6rem;padding:.85rem 1rem;font-family:var(--mono);font-size:.86rem;font-weight:600;letter-spacing:.02em;color:var(--ink);background:var(--paper-2);}
details.folder>summary::-webkit-details-marker{display:none}
details.folder>summary:hover{color:var(--stamp-red)}
.chev{display:inline-block;color:var(--stamp-red);font-size:.8rem;transition:transform .16s ease;flex:0 0 auto;}
details.folder[open]>summary .chev{transform:rotate(90deg)}
.path{word-break:break-all}
.count{margin-left:auto;font-size:.66rem;letter-spacing:.1em;color:var(--ink-soft);text-transform:uppercase;flex:0 0 auto;}
.folder-body{padding:.25rem 1rem 1rem}
section.entry{padding:1rem 0 .25rem;border-top:1px solid var(--line)}
section.entry:first-child{border-top:none}
.entry-date{font-family:var(--mono);font-size:.82rem;font-weight:700;letter-spacing:.08em;color:var(--ink);margin-bottom:.7rem;display:inline-block;border-bottom:2px solid var(--stamp-red);padding-bottom:.15rem;}
.lbl{font-family:var(--mono);font-size:.66rem;font-weight:600;letter-spacing:.14em;text-transform:uppercase;color:var(--ink-soft);margin:.9rem 0 .4rem;}
ol.prompts{list-style:none;counter-reset:p;display:flex;flex-direction:column;gap:.4rem}
ol.prompts li{counter-increment:p;position:relative;padding:.4rem .6rem .4rem 2.1rem;background:var(--paper);border:1px solid var(--line);border-radius:6px;border-left:3px solid var(--stamp-red);font-size:.92rem;color:var(--ink);}
ol.prompts li::before{content:counter(p);position:absolute;left:.55rem;top:.4rem;font-family:var(--mono);font-size:.72rem;font-weight:700;color:var(--stamp-red);}
ul.changes{list-style:none;display:flex;flex-direction:column;gap:.35rem}
ul.changes li{position:relative;padding-left:1.2rem;font-size:.92rem}
ul.changes li::before{content:"▸";position:absolute;left:0;top:0;color:var(--seal-green);font-size:.8rem;}
ul.changes code, ol.prompts code{font-family:var(--mono);font-size:.84em;background:var(--paper-2);border:1px solid var(--line);border-radius:3px;padding:0 .3em;}
a{color:var(--stamp-red)} a:hover{text-decoration:underline}
footer.wrap{margin-top:2.4rem;padding-top:1rem;border-top:1px solid var(--line);font-family:var(--mono);font-size:.7rem;letter-spacing:.06em;color:var(--ink-soft);text-align:center;}
</style>
</head>
<body>
<button id="theme-toggle" aria-label="Toggle dark mode">🌙 Dark</button>
<header class="wrap">
  <p class="eyebrow">Workspace · Activity Log</p>
  <h1>Interaction Log</h1>
  <p class="intro">A running record of work across your projects. Each folder collapses by name, and the newest activity sits on top. Updated on request with the <code>/interaction-log</code> command.</p>
  <div class="toolbar">
    <span class="t-label">Folders</span>
    <button class="tbtn" id="expand-all" type="button">Expand all</button>
    <button class="tbtn" id="collapse-all" type="button">Collapse all</button>
  </div>
</header>
<main class="wrap" id="log">
  <!-- folder <details> blocks are inserted here, newest first -->
</main>
<footer class="wrap">
  Local activity log · generated by the /interaction-log command · not a published page
</footer>
<script>
(function(){
  var root=document.documentElement, btn=document.getElementById('theme-toggle');
  function label(){btn.textContent=root.getAttribute('data-theme')==='dark'?'☀️ Light':'🌙 Dark';}
  label();
  btn.addEventListener('click',function(){
    if(root.getAttribute('data-theme')==='dark'){root.removeAttribute('data-theme');try{localStorage.setItem('theme','light');}catch(e){}}
    else{root.setAttribute('data-theme','dark');try{localStorage.setItem('theme','dark');}catch(e){}}
    label();
  });
  function setAll(open){document.querySelectorAll('#log details.folder').forEach(function(d){d.open=open;});}
  document.getElementById('expand-all').addEventListener('click',function(){setAll(true);});
  document.getElementById('collapse-all').addEventListener('click',function(){setAll(false);});
})();
</script>
</body>
</html>
```
