#!/usr/bin/env bash
#
# package-skills.sh — package each skill folder into a single-file .skill bundle.
#
# A .skill bundle is just a zip of the skill's folder (paths rooted at
# <name>/SKILL.md) so an individual can download one file and unzip it into
# their .claude/skills/ directory. Folders are the source of truth; run this
# whenever a skill changes so the bundles stay in sync.
#
# Usage:  scripts/package-skills.sh        # from the repo root

set -euo pipefail

# Resolve repo root from this script's location so it works from anywhere.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"
DIST_DIR="$SKILLS_DIR/dist"

# Rebuild dist/ from scratch so removed skills don't leave stale bundles behind.
rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"

count=0
for dir in "$SKILLS_DIR"/*/; do
  name="$(basename "$dir")"
  [ "$name" = "dist" ] && continue
  [ -f "$dir/SKILL.md" ] || { echo "skip: $name (no SKILL.md)"; continue; }

  # Zip from inside skills/ so archive paths are <name>/SKILL.md, ... and
  # exclude macOS cruft for reproducible, clean bundles.
  ( cd "$SKILLS_DIR" && zip -rq "dist/$name.skill" "$name" -x '*.DS_Store' -x '__MACOSX/*' )
  echo "packaged: dist/$name.skill"
  count=$((count + 1))
done

echo "done — $count skill(s) packaged into $DIST_DIR"
