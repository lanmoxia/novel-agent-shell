#!/usr/bin/env bash
# Validate PROJECT-STATE.json against recovery-critical project artifacts.

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS_DIR="$ROOT_DIR/projects"
TARGET_PROJECT="${1:-}"
ERRORS=0
WARNINGS=0

usage() {
  echo "Usage: bash scripts/validate-project-state.sh [project-name]"
}

warn() {
  echo "[validate-project-state] [warn] $*"
  WARNINGS=$((WARNINGS + 1))
}

error() {
  echo "[validate-project-state] [error] $*" >&2
  ERRORS=$((ERRORS + 1))
}

is_template_project() {
  case "$1" in
    _template|_template-edu-shortdrama)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

json_value() {
  local file="$1"
  local key="$2"
  grep -m 1 "^[[:space:]]*\"$key\"[[:space:]]*:" "$file" 2>/dev/null |
    sed -E 's/^[[:space:]]*"[^"]+"[[:space:]]*:[[:space:]]*"?([^",}]*)"?[,}]?.*$/\1/'
}

json_bool() {
  local file="$1"
  local key="$2"
  local value
  value="$(json_value "$file" "$key")"
  case "$value" in
    true|True|1) echo "true" ;;
    false|False|0) echo "false" ;;
    *) echo "" ;;
  esac
}

confirmed_artifact() {
  local file="$1"
  local key="$2"
  json_bool "$file" "$key"
}

require_confirmed_file() {
  local project="$1"
  local project_dir="$2"
  local state="$3"
  local key="$4"
  local rel_path="$5"
  local confirmed
  confirmed="$(confirmed_artifact "$state" "$key")"
  if [ "$confirmed" = "true" ] && [ ! -f "$project_dir/$rel_path" ]; then
    error "$project: confirmedArtifacts.$key is true but $rel_path is missing."
  fi
}

require_gate() {
  local project="$1"
  local state="$2"
  local key="$3"
  local phase="$4"
  local confirmed
  confirmed="$(confirmed_artifact "$state" "$key")"
  if [ "$confirmed" != "true" ]; then
    error "$project: phase $phase requires confirmedArtifacts.$key to be true."
  fi
}

chapter_count() {
  local project_dir="$1"
  if [ ! -d "$project_dir/scripts" ]; then
    echo 0
    return
  fi
  find "$project_dir/scripts" -maxdepth 1 -type f -name "*.md" ! -name "SCRIPT-STATUS.md" 2>/dev/null | wc -l
}

validate_project() {
  local project="$1"
  local project_dir="$PROJECTS_DIR/$project"
  local state="$project_dir/PROJECT-STATE.json"
  local run_log="$project_dir/RUN-LOG.md"

  if [ ! -d "$project_dir" ]; then
    error "$project: missing project directory."
    return
  fi
  if [ ! -f "$state" ]; then
    error "$project: missing PROJECT-STATE.json. Run scripts/migrate-project first."
    return
  fi
  if [ ! -f "$run_log" ]; then
    warn "$project: missing RUN-LOG.md; recovery will not have a next-step trail."
  fi

  local project_type state_project phase status locked
  project_type="$(json_value "$state" projectType)"
  if [ "$project_type" = "edu-shortdrama" ]; then
    echo "[validate-project-state] [info] $project: edu-shortdrama state skipped from legacy recovery validation; handled by validate-edu-shortdrama-project."
    return
  fi

  state_project="$(json_value "$state" project)"
  phase="$(json_value "$state" phase)"
  status="$(json_value "$state" status)"
  locked="$(json_bool "$state" locked)"

  if [ -z "$state_project" ]; then
    error "$project: PROJECT-STATE.json missing project."
  elif [ "$state_project" != "$project" ]; then
    error "$project: PROJECT-STATE.json project is '$state_project'."
  fi

  if ! echo "$phase" | grep -Eq '^[0-8]$'; then
    error "$project: PROJECT-STATE.json phase must be an integer from 0 to 8."
    phase="-1"
  fi
  if [ -z "$status" ]; then
    error "$project: PROJECT-STATE.json missing status."
  fi
  if [ -z "$locked" ]; then
    error "$project: PROJECT-STATE.json locked must be true or false."
  fi

  require_confirmed_file "$project" "$project_dir" "$state" "projectMd" "PROJECT.md"
  require_confirmed_file "$project" "$project_dir" "$state" "genreSkillLock" "GENRE-SKILL-LOCK.md"
  require_confirmed_file "$project" "$project_dir" "$state" "storySpec" "specs/STORY-SPEC.md"
  require_confirmed_file "$project" "$project_dir" "$state" "endingLock" "planning/ENDING-LOCK.md"
  require_confirmed_file "$project" "$project_dir" "$state" "outline" "outlines/OUTLINE.md"
  require_confirmed_file "$project" "$project_dir" "$state" "reverseOutline" "planning/REVERSE-OUTLINE.md"
  require_confirmed_file "$project" "$project_dir" "$state" "finalReview" "reviews/final-review.md"
  require_confirmed_file "$project" "$project_dir" "$state" "revisionLog" "revisions/revision-log.md"
  require_confirmed_file "$project" "$project_dir" "$state" "finalScript" "locked/FINAL-SCRIPT.md"

  if [ "$phase" -ge 1 ] 2>/dev/null; then
    require_gate "$project" "$state" "projectMd" "$phase"
  fi
  if [ "$phase" -ge 2 ] 2>/dev/null; then
    require_gate "$project" "$state" "genreSkillLock" "$phase"
    if ! grep -q "状态：已锁定" "$project_dir/GENRE-SKILL-LOCK.md" 2>/dev/null; then
      warn "$project: phase $phase expects GENRE-SKILL-LOCK.md to say 状态：已锁定."
    fi
  fi
  if [ "$phase" -ge 3 ] 2>/dev/null; then
    require_gate "$project" "$state" "storySpec" "$phase"
    require_gate "$project" "$state" "endingLock" "$phase"
  fi
  if [ "$phase" -ge 4 ] 2>/dev/null; then
    require_gate "$project" "$state" "outline" "$phase"
    require_gate "$project" "$state" "reverseOutline" "$phase"
  fi
  if [ "$phase" -ge 5 ] 2>/dev/null; then
    local scripts_written
    scripts_written="$(chapter_count "$project_dir")"
    if [ "$scripts_written" -eq 0 ]; then
      error "$project: phase $phase requires at least one script/chapter file under scripts/."
    fi
  fi
  if [ "$phase" -ge 6 ] 2>/dev/null; then
    require_gate "$project" "$state" "finalReview" "$phase"
  fi
  if [ "$phase" -ge 7 ] 2>/dev/null; then
    require_gate "$project" "$state" "finalScript" "$phase"
    if [ "$locked" != "true" ]; then
      error "$project: phase $phase requires PROJECT-STATE.json locked to be true."
    fi
  fi

  if [ -f "$project_dir/locked/FINAL-SCRIPT.md" ] && [ "$locked" != "true" ]; then
    warn "$project: locked/FINAL-SCRIPT.md exists but PROJECT-STATE.json locked is not true."
  fi
  if [ "$locked" = "true" ] && [ ! -f "$project_dir/locked/FINAL-SCRIPT.md" ]; then
    error "$project: PROJECT-STATE.json locked is true but locked/FINAL-SCRIPT.md is missing."
  fi
  if [ "$status" = "locked" ] && [ "$locked" != "true" ]; then
    error "$project: status is locked but locked is not true."
  fi

  if [ -f "$run_log" ]; then
    if ! grep -q "^- 下一步：" "$run_log" 2>/dev/null; then
      warn "$project: RUN-LOG.md has no 下一步 entry."
    fi
    if [ "$phase" -ge 0 ] 2>/dev/null; then
      local last_phase
      last_phase="$(grep "^- 当前阶段：Phase " "$run_log" 2>/dev/null | tail -n 1 || true)"
      if [ -n "$last_phase" ] && ! echo "$last_phase" | grep -q "Phase $phase"; then
        warn "$project: latest RUN-LOG phase does not match PROJECT-STATE.json phase $phase."
      fi
    fi
  fi

  echo "[validate-project-state] [info] $project: phase ${phase:-unknown}, status ${status:-unknown}, locked ${locked:-unknown}."
}

if [ "$TARGET_PROJECT" = "-h" ] || [ "$TARGET_PROJECT" = "--help" ]; then
  usage
  exit 0
fi

if [ ! -d "$PROJECTS_DIR" ]; then
  error "Missing projects/ directory."
  exit 1
fi

if [ -n "$TARGET_PROJECT" ]; then
  if is_template_project "$TARGET_PROJECT"; then
    error "Refusing template directory as active project: $TARGET_PROJECT"
  else
    case "$TARGET_PROJECT" in
      test-*|*-smoke-test|*/*|*\\*|.*)
      error "Refusing reserved/sample/invalid project: $TARGET_PROJECT"
      ;;
      *)
        validate_project "$TARGET_PROJECT"
        ;;
    esac
  fi
else
  FOUND=0
  for project_dir in "$PROJECTS_DIR"/*/; do
    [ -d "$project_dir" ] || continue
    project="$(basename "$project_dir")"
    if is_template_project "$project"; then
      continue
    fi
    case "$project" in
      test-*|*-smoke-test)
        continue
        ;;
    esac
    FOUND=$((FOUND + 1))
    validate_project "$project"
  done
  if [ "$FOUND" -eq 0 ]; then
    warn "No active production projects found under projects/."
  fi
fi

echo "[validate-project-state] Completed with $ERRORS error(s), $WARNINGS warning(s)."

if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi

exit 0
