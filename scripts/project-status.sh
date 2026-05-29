#!/usr/bin/env bash
# Print a compact recovery/status view for one project.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VALIDATE=0

if [ "${1:-}" = "--validate" ]; then
  VALIDATE=1
  shift
fi

PROJECT_NAME="${1:-}"

usage() {
  echo "Usage: bash scripts/project-status.sh [--validate] <project-name>"
}

if [ "$PROJECT_NAME" = "-h" ] || [ "$PROJECT_NAME" = "--help" ] || [ -z "$PROJECT_NAME" ]; then
  usage
  if [ -z "$PROJECT_NAME" ]; then exit 1; else exit 0; fi
fi

case "$PROJECT_NAME" in
  */*|*\\*|.*)
    echo "[project-status] Invalid project name: $PROJECT_NAME" >&2
    exit 1
    ;;
esac

PROJECT_DIR="$ROOT_DIR/projects/$PROJECT_NAME"
STATE="$PROJECT_DIR/PROJECT-STATE.json"
RUN_LOG="$PROJECT_DIR/RUN-LOG.md"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "[project-status] Missing project: projects/$PROJECT_NAME" >&2
  exit 1
fi
if [ ! -f "$STATE" ]; then
  echo "[project-status] Missing PROJECT-STATE.json. Run scripts/migrate-project first." >&2
  exit 1
fi

json_value() {
  local key="$1"
  grep -m 1 "^[[:space:]]*\"$key\"[[:space:]]*:" "$STATE" 2>/dev/null |
    sed -E 's/^[[:space:]]*"[^"]+"[[:space:]]*:[[:space:]]*"?([^",}]*)"?[,}]?.*$/\1/'
}

project="$(json_value project)"
phase="$(json_value phase)"
status="$(json_value status)"
skill="$(json_value genreSkill)"
locked="$(json_value locked)"

echo "[project-status] Project: ${project:-$PROJECT_NAME}"
echo "[project-status] Phase: ${phase:-unknown}"
echo "[project-status] Status: ${status:-unknown}"
echo "[project-status] Genre Skill: ${skill:-unknown}"
echo "[project-status] Locked: ${locked:-unknown}"

if [ -f "$RUN_LOG" ]; then
  next_step="$(grep '^- 下一步：' "$RUN_LOG" 2>/dev/null | tail -n 1 | sed 's/^- 下一步：//')"
  if [ -n "$next_step" ]; then
    echo "[project-status] Next: $next_step"
  fi
fi

if [ -z "${next_step:-}" ]; then
  case "$phase" in
    0) echo "[project-status] Next: Fill PROJECT.md, then request Phase 1 genre Skill loading." ;;
    1) echo "[project-status] Next: Confirm GENRE-SKILL-LOCK.md, then request Phase 2 story planning." ;;
    2) echo "[project-status] Next: Confirm STORY-SPEC.md and ENDING-LOCK.md, then request Phase 3 outline." ;;
    3) echo "[project-status] Next: Confirm OUTLINE.md and reverse-planning files, then request Phase 4 writing." ;;
    4) echo "[project-status] Next: Finish requested script/chapter files, then request Phase 5 review." ;;
    5) echo "[project-status] Next: Choose revision scope before Phase 6." ;;
    6) echo "[project-status] Next: Confirm revisions or request more fixes before Phase 7 lock." ;;
    7) echo "[project-status] Next: Wait for explicit user confirmation before Phase 8 post-production." ;;
    8) echo "[project-status] Next: Continue only the selected post-production output type." ;;
  esac
fi

case "$locked" in
  true|True|1) ;;
  *)
    if [ -f "$PROJECT_DIR/locked/FINAL-SCRIPT.md" ]; then
      echo "[project-status] Warning: FINAL-SCRIPT.md exists but PROJECT-STATE.json locked is not true."
    fi
    ;;
esac

if [ "$VALIDATE" -eq 1 ]; then
  bash "$ROOT_DIR/scripts/validate-project-state.sh" "$PROJECT_NAME"
else
  echo "[project-status] Validate: bash scripts/project-status.sh --validate $PROJECT_NAME"
fi
