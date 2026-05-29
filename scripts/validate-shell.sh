#!/usr/bin/env bash
# Unified repository validation for the novel-agent shell.

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ERRORS=0
WARNINGS=0

require_file() {
  local path="$1"
  if [ ! -f "$ROOT_DIR/$path" ]; then
    echo "[validate-shell] [error] Missing file: $path" >&2
    ERRORS=$((ERRORS + 1))
  fi
}

require_dir() {
  local path="$1"
  if [ ! -d "$ROOT_DIR/$path" ]; then
    echo "[validate-shell] [error] Missing directory: $path" >&2
    ERRORS=$((ERRORS + 1))
  fi
}

warn_missing() {
  local path="$1"
  if [ ! -e "$ROOT_DIR/$path" ]; then
    echo "[validate-shell] [warn] Missing recommended path: $path"
    WARNINGS=$((WARNINGS + 1))
  fi
}

validate_shell_syntax() {
  local path="$1"
  if [ -f "$ROOT_DIR/$path" ]; then
    bash -n "$ROOT_DIR/$path" || ERRORS=$((ERRORS + 1))
  fi
}

echo "[validate-shell] Checking repository structure..."
require_dir "workflow"
require_dir "workflow/hooks"
require_dir "workflow/skills"
require_dir "workflow/agents"
require_dir "workflow/feedback"
require_dir "workflow/theory"
require_dir "workflow/execution"
require_dir "workflow/modes"
require_file "workflow/ORCHESTRATION.md"
require_dir "docs"
require_dir "docs/reports"
require_dir "genre-skills"
require_dir "projects/_template"

echo "[validate-shell] Checking configured hook scripts..."
for hook in check-evolution.sh detect-feedback-signal.sh stage-gate.sh stop-gate.sh; do
  require_file "workflow/hooks/$hook"
  validate_shell_syntax "workflow/hooks/$hook"
done
validate_shell_syntax "scripts/migrate-project.sh"
validate_shell_syntax "scripts/new-proposal.sh"
validate_shell_syntax "scripts/project-status.sh"
validate_shell_syntax "scripts/validate-edu-shortdrama-template.sh"
validate_shell_syntax "scripts/validate-edu-shortdrama-project.sh"
validate_shell_syntax "scripts/validate-project-state.sh"
validate_shell_syntax "scripts/update-skill-lock-manifest.sh"
if [ -d "$ROOT_DIR/.claude" ]; then
  echo "[validate-shell] [warn] .claude/ exists. Current workflow assets should live under workflow/."
  WARNINGS=$((WARNINGS + 1))
fi

echo "[validate-shell] Checking workflow assets..."
bash "$ROOT_DIR/scripts/validate-workflow-assets.sh" || ERRORS=$((ERRORS + 1))

echo "[validate-shell] Checking project template..."
for path in \
  "projects/_template/PROJECT.md" \
  "projects/_template/PROJECT-STATE.json" \
  "projects/_template/RUN-LOG.md" \
  "projects/_template/GENRE-SKILL-LOCK.md" \
  "projects/_template/PROJECT-MEMORY.md" \
  "projects/_template/specs/STORY-SPEC.md" \
  "projects/_template/outlines/OUTLINE.md" \
  "projects/_template/planning/ENDING-LOCK.md" \
  "projects/_template/planning/REVERSE-OUTLINE.md" \
  "projects/_template/planning/FORESHADOW-LEDGER.md" \
  "projects/_template/planning/REVEAL-SCHEDULE.md" \
  "projects/_template/scripts/SCRIPT-STATUS.md" \
  "projects/_template/planning" \
  "projects/_template/materials" \
  "projects/_template/drafts" \
  "projects/_template/drafts/rewrite-candidates" \
  "projects/_template/reviews" \
  "projects/_template/revisions" \
  "projects/_template/revisions/snapshots" \
  "projects/_template/locked" \
  "projects/_template/shotlists" \
  "projects/_template/short-drama-shotlists" \
  "projects/_template/seedance-prompts"; do
  if [[ "$path" == *.* ]]; then
    require_file "$path"
  else
    require_dir "$path"
  fi
done

warn_missing "projects/_template/revisions/revision-log.md"
warn_missing "projects/_template/locked/FINAL-SCRIPT.md"

echo "[validate-shell] Checking edu shortdrama project template..."
bash "$ROOT_DIR/scripts/validate-edu-shortdrama-template.sh" || ERRORS=$((ERRORS + 1))

echo "[validate-shell] Checking active projects..."
bash "$ROOT_DIR/scripts/validate-projects.sh" || ERRORS=$((ERRORS + 1))
bash "$ROOT_DIR/scripts/validate-project-state.sh" || ERRORS=$((ERRORS + 1))

echo "[validate-shell] Checking edu shortdrama project instances..."
bash "$ROOT_DIR/scripts/validate-edu-shortdrama-project.sh" || ERRORS=$((ERRORS + 1))

echo "[validate-shell] Checking documentation entry points..."
require_file "README.md"
require_file "docs/SHELL-SPEC.md"
require_file "docs/SHELL-BOUNDARY.md"
require_file "docs/KNOWLEDGE-LAYERING.md"
require_file "docs/GENRE-SKILL-CONTRACT.md"
require_file "docs/NEXT-PRODUCTION-STEPS.md"
warn_missing "docs/README.md"

echo "[validate-shell] Checking genre skills..."
bash "$ROOT_DIR/scripts/validate-genre-skills.sh" || ERRORS=$((ERRORS + 1))

echo "[validate-shell] Completed with $ERRORS error(s), $WARNINGS warning(s)."

if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi

exit 0
