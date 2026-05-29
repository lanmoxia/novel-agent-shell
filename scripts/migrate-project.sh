#!/usr/bin/env bash
# Backfill a project with current shell scaffolding without modifying story text.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS_DIR="$ROOT_DIR/projects"
TEMPLATE_DIR="$PROJECTS_DIR/_template"

usage() {
  echo "Usage: bash scripts/migrate-project.sh <project-name>"
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ] || [ $# -ne 1 ]; then
  usage
  [ $# -eq 1 ] && exit 0 || exit 1
fi

project="$1"
project_dir="$PROJECTS_DIR/$project"

case "$project" in
  _template|test-*|*-smoke-test|"")
    echo "[migrate-project] Refusing reserved/sample project: $project" >&2
    exit 1
    ;;
esac

if [ ! -d "$project_dir" ]; then
  echo "[migrate-project] Project not found: projects/$project" >&2
  exit 1
fi

mkdir -p \
  "$project_dir/planning" \
  "$project_dir/materials" \
  "$project_dir/drafts/rewrite-candidates" \
  "$project_dir/revisions/snapshots"

copy_if_missing() {
  local rel="$1"
  if [ ! -e "$project_dir/$rel" ] && [ -e "$TEMPLATE_DIR/$rel" ]; then
    mkdir -p "$(dirname "$project_dir/$rel")"
    cp "$TEMPLATE_DIR/$rel" "$project_dir/$rel"
    echo "[migrate-project] Added $rel"
  fi
}

copy_if_missing "PROJECT-MEMORY.md"
copy_if_missing "PROJECT-STATE.json"
copy_if_missing "RUN-LOG.md"
copy_if_missing "planning/ENDING-LOCK.md"
copy_if_missing "planning/REVERSE-OUTLINE.md"
copy_if_missing "planning/FORESHADOW-LEDGER.md"
copy_if_missing "planning/REVEAL-SCHEDULE.md"
copy_if_missing "materials/README.md"
copy_if_missing "drafts/README.md"
copy_if_missing "drafts/rewrite-candidates/README.md"
copy_if_missing "revisions/snapshots/README.md"

snapshot_readme="$project_dir/revisions/snapshots/README.md"
if [ -f "$project_dir/revisions/revision-log.md" ] && [ -f "$snapshot_readme" ] && ! grep -q "historical-no-snapshot: true" "$snapshot_readme"; then
  {
    echo ""
    echo "historical-no-snapshot: true"
  } >> "$snapshot_readme"
  echo "[migrate-project] Marked historical no-snapshot."
fi

echo "[migrate-project] Completed projects/$project."
