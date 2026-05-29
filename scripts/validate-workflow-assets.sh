#!/usr/bin/env bash
# Validate workflow skills, agents, hooks, and top-level orchestration assets.

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKFLOW_DIR="$ROOT_DIR/workflow"
ERRORS=0
WARNINGS=0

error() {
  echo "[validate-workflow-assets] [error] $*" >&2
  ERRORS=$((ERRORS + 1))
}

warn() {
  echo "[validate-workflow-assets] [warn] $*"
  WARNINGS=$((WARNINGS + 1))
}

check_frontmatter_field() {
  local file="$1"
  local field="$2"
  awk '
    NR == 1 && $0 == "---" { in_fm=1; next }
    in_fm && $0 == "---" { exit }
    in_fm { print }
  ' "$file" | grep -Eq "^${field}: *[^[:space:]].*"
}

require_frontmatter() {
  local file="$1"
  local label="$2"

  if [ ! -f "$file" ]; then
    error "$label missing: ${file#$ROOT_DIR/}"
    return
  fi

  first_line="$(head -n 1 "$file" 2>/dev/null || true)"
  if [ "$first_line" != "---" ]; then
    error "$label must start with YAML frontmatter: ${file#$ROOT_DIR/}"
    return
  fi

  check_frontmatter_field "$file" "name" || error "$label missing frontmatter field: name (${file#$ROOT_DIR/})"
  check_frontmatter_field "$file" "description" || error "$label missing frontmatter field: description (${file#$ROOT_DIR/})"
}

if [ ! -d "$WORKFLOW_DIR" ]; then
  error "Missing workflow/ directory."
  exit 1
fi

if [ ! -s "$WORKFLOW_DIR/ORCHESTRATION.md" ]; then
  error "workflow/ORCHESTRATION.md is missing or empty."
fi

if [ ! -s "$ROOT_DIR/docs/SHELL-BOUNDARY.md" ]; then
  error "docs/SHELL-BOUNDARY.md is missing or empty."
fi

for dir in theory execution modes; do
  if [ ! -d "$WORKFLOW_DIR/$dir" ]; then
    error "workflow directory missing: $dir"
  fi
done

for asset in \
  theory/reverse-design.md \
  theory/rewrite-not-edit.md \
  theory/foreshadowing.md \
  theory/continuity-memory.md \
  execution/rewrite-protocol.md \
  execution/memory-update-protocol.md \
  execution/review-rubric.md \
  modes/planning-mode.md \
  modes/diagnosis-mode.md \
  modes/drafting-mode.md \
  modes/rewrite-mode.md; do
  if [ ! -s "$WORKFLOW_DIR/$asset" ]; then
    error "workflow asset missing or empty: $asset"
  fi
done

for skill in \
  project-intake-builder \
  genre-loader \
  story-spec-builder \
  outline-builder \
  script-writer \
  script-review \
  revision-fixer \
  script-locker \
  post-production-builder; do
  require_frontmatter "$WORKFLOW_DIR/skills/$skill/SKILL.md" "workflow skill $skill"
done

for agent in \
  structure-reviewer \
  continuity-reviewer \
  dialogue-reviewer \
  genre-reviewer \
  feedback-observer \
  evolution-runner; do
  require_frontmatter "$WORKFLOW_DIR/agents/$agent.md" "workflow agent $agent"
done

for hook in check-evolution.sh detect-feedback-signal.sh stage-gate.sh stop-gate.sh; do
  if [ ! -f "$WORKFLOW_DIR/hooks/$hook" ]; then
    error "workflow hook missing: $hook"
  else
    bash -n "$WORKFLOW_DIR/hooks/$hook" || ERRORS=$((ERRORS + 1))
  fi
done

if [ ! -f "$WORKFLOW_DIR/feedback/feedback-index.md" ]; then
  warn "workflow/feedback/feedback-index.md missing; feedback evolution will start without an index."
fi
if [ ! -d "$WORKFLOW_DIR/feedback/proposals" ]; then
  error "workflow/feedback/proposals/ directory missing."
fi
if [ ! -s "$WORKFLOW_DIR/feedback/proposals/TEMPLATE.md" ]; then
  error "workflow/feedback/proposals/TEMPLATE.md is missing or empty."
fi

echo "[validate-workflow-assets] Completed with $ERRORS error(s), $WARNINGS warning(s)."

if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi

exit 0
