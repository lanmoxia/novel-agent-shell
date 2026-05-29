#!/usr/bin/env bash
# Validate real edu-shortdrama project instances without applying legacy novel/script artifact rules.

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS_DIR="$ROOT_DIR/projects"
ERRORS=0
WARNINGS=0

info() {
  echo "[validate-edu-shortdrama-project] [info] $*"
}

warn() {
  echo "[validate-edu-shortdrama-project] [warn] $*"
  WARNINGS=$((WARNINGS + 1))
}

error() {
  echo "[validate-edu-shortdrama-project] [error] $*" >&2
  ERRORS=$((ERRORS + 1))
}

json_query() {
  local file="$1"
  local query="$2"
  python -c '
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
query = sys.argv[2]
data = json.loads(path.read_text(encoding="utf-8"))
value = data
for part in query.split("."):
    if not isinstance(value, dict) or part not in value:
        sys.exit(2)
    value = value[part]
if isinstance(value, bool):
    print("true" if value else "false")
elif value is None:
    print("null")
elif isinstance(value, (dict, list)):
    print(json.dumps(value, ensure_ascii=False))
else:
    print(value)
' "$file" "$query"
}

json_type() {
  local file="$1"
  local query="$2"
  python -c '
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
query = sys.argv[2]
data = json.loads(path.read_text(encoding="utf-8"))
value = data
for part in query.split("."):
    if not isinstance(value, dict) or part not in value:
        sys.exit(2)
    value = value[part]
if isinstance(value, bool):
    print("bool")
elif isinstance(value, int) and not isinstance(value, bool):
    print("int")
elif isinstance(value, str):
    print("string")
elif isinstance(value, list):
    print("array")
elif isinstance(value, dict):
    print("object")
elif value is None:
    print("null")
else:
    print(type(value).__name__)
' "$file" "$query"
}

json_bool() {
  local file="$1"
  local query="$2"
  json_query "$file" "$query" 2>/dev/null || true
}

require_file() {
  local project="$1"
  local project_dir="$2"
  local rel_path="$3"
  if [ ! -f "$project_dir/$rel_path" ]; then
    error "$project: missing $rel_path"
  fi
}

require_json_field() {
  local project="$1"
  local state="$2"
  local field="$3"
  if ! json_type "$state" "$field" >/dev/null 2>&1; then
    error "$project: PROJECT-STATE.json missing required field: $field"
  fi
}

require_json_type() {
  local project="$1"
  local state="$2"
  local field="$3"
  local expected="$4"
  local actual

  if ! actual="$(json_type "$state" "$field" 2>/dev/null)"; then
    error "$project: PROJECT-STATE.json missing required field: $field"
    return
  fi
  if [ "$actual" != "$expected" ]; then
    error "$project: PROJECT-STATE.json field $field must be $expected, got $actual."
  fi
}

require_json_value() {
  local project="$1"
  local state="$2"
  local field="$3"
  local expected="$4"
  local actual

  if ! actual="$(json_query "$state" "$field" 2>/dev/null)"; then
    error "$project: PROJECT-STATE.json missing required field: $field"
    return
  fi
  if [ "$actual" != "$expected" ]; then
    error "$project: PROJECT-STATE.json field $field must be '$expected', got '$actual'."
  fi
}

require_confirmed_true() {
  local project="$1"
  local state="$2"
  local key="$3"
  if [ "$(json_bool "$state" "confirmedArtifacts.$key")" != "true" ]; then
    error "$project: confirmedArtifacts.$key must be true."
  fi
}

require_text_any() {
  local project="$1"
  local project_dir="$2"
  local rel_path="$3"
  local label="$4"
  shift 4
  local file="$project_dir/$rel_path"
  local pattern

  if [ ! -f "$file" ]; then
    error "$project: $rel_path missing; cannot check $label."
    return
  fi

  for pattern in "$@"; do
    if grep -q "$pattern" "$file" 2>/dev/null; then
      return
    fi
  done

  error "$project: $rel_path missing required semantic keyword for $label: $*"
}

count_non_readme_files() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    echo 0
    return
  fi
  find "$dir" -maxdepth 1 -type f ! -iname "README.md" 2>/dev/null | wc -l
}

validate_project() {
  local project="$1"
  local project_dir="$2"
  local state="$project_dir/PROJECT-STATE.json"
  local phase

  info "$project: checking edu-shortdrama project instance."

  for file in \
    "PROJECT.md" \
    "PROJECT-STATE.json" \
    "GENRE-SKILL-LOCK.md" \
    "specs/STORY-SPEC.md" \
    "planning/ENDING-LOCK.md" \
    "outlines/OUTLINE.md" \
    "scripts/SCRIPT-STATUS.md" \
    "RUN-LOG.md" \
    "PROJECT-MEMORY.md"; do
    require_file "$project" "$project_dir" "$file"
  done

  if ! python -m json.tool "$state" >/dev/null 2>&1; then
    error "$project: PROJECT-STATE.json is not valid JSON."
    return
  fi

  for field in \
    "project" \
    "projectType" \
    "skillId" \
    "phase" \
    "status" \
    "locked" \
    "confirmedArtifacts" \
    "eduTextStatus" \
    "sceneMappingStatus" \
    "scriptStatus" \
    "subtitleStatus" \
    "shotlistStatus" \
    "reviewStatus" \
    "productionPackageStatus" \
    "lockedArtifacts" \
    "lastUpdated" \
    "notes"; do
    require_json_field "$project" "$state" "$field"
  done

  require_json_value "$project" "$state" "project" "$project"
  require_json_value "$project" "$state" "projectType" "edu-shortdrama"
  require_json_value "$project" "$state" "skillId" "wenyan-skill"
  require_json_type "$project" "$state" "phase" "int"
  require_json_type "$project" "$state" "status" "string"
  require_json_type "$project" "$state" "locked" "bool"
  require_json_type "$project" "$state" "confirmedArtifacts" "object"
  require_json_type "$project" "$state" "lockedArtifacts" "array"
  require_json_type "$project" "$state" "notes" "array"

  phase="$(json_query "$state" phase 2>/dev/null || echo -1)"
  if ! echo "$phase" | grep -Eq '^[0-8]$'; then
    error "$project: PROJECT-STATE.json phase must be an integer from 0 to 8."
    phase="-1"
  fi

  if [ "$phase" -ge 0 ] 2>/dev/null; then
    require_file "$project" "$project_dir" "PROJECT.md"
    require_confirmed_true "$project" "$state" "projectMd"
  fi
  if [ "$phase" -ge 1 ] 2>/dev/null; then
    require_file "$project" "$project_dir" "GENRE-SKILL-LOCK.md"
    require_confirmed_true "$project" "$state" "genreSkillLock"
  fi
  if [ "$phase" -ge 2 ] 2>/dev/null; then
    require_file "$project" "$project_dir" "specs/STORY-SPEC.md"
    require_file "$project" "$project_dir" "planning/ENDING-LOCK.md"
    require_confirmed_true "$project" "$state" "storySpec"
    require_confirmed_true "$project" "$state" "endingLock"
    require_confirmed_true "$project" "$state" "originalTextAnalysis"
  fi
  if [ "$phase" -ge 3 ] 2>/dev/null; then
    require_file "$project" "$project_dir" "outlines/OUTLINE.md"
    require_confirmed_true "$project" "$state" "outline"
    require_confirmed_true "$project" "$state" "sceneMapping"
  fi
  if [ "$phase" -ge 4 ] 2>/dev/null; then
    require_file "$project" "$project_dir" "scripts/SCRIPT-STATUS.md"
    require_confirmed_true "$project" "$state" "script"
    if [ ! -f "$project_dir/scripts/SMOKE-DRAFT.md" ] && ! find "$project_dir/scripts" -maxdepth 1 -type f -name "*.md" ! -name "SCRIPT-STATUS.md" 2>/dev/null | grep -q .; then
      error "$project: phase $phase requires scripts/SMOKE-DRAFT.md or another explicit shortdrama draft file."
    fi
  fi

  if [ "$phase" -lt 5 ] 2>/dev/null && [ -f "$project_dir/reviews/final-review.md" ]; then
    error "$project: phase $phase must not have reviews/final-review.md."
  fi
  if [ "$phase" -lt 7 ] 2>/dev/null; then
    for file in "locked/FINAL-SCRIPT.md" "locked/LOCK-MANIFEST.sha256" "locked/SKILL-LOCK-MANIFEST.sha256"; do
      if [ -f "$project_dir/$file" ]; then
        error "$project: phase $phase must not have $file."
      fi
    done
  fi
  if [ "$phase" -lt 8 ] 2>/dev/null; then
    for post_dir in short-drama-shotlists seedance-prompts; do
      post_count="$(count_non_readme_files "$project_dir/$post_dir")"
      if [ "$post_count" -gt 0 ]; then
        error "$project: phase $phase must not have formal post-production files under $post_dir/."
      fi
    done
  fi

  require_text_any "$project" "$project_dir" "specs/STORY-SPEC.md" "original text" "原文"
  require_text_any "$project" "$project_dir" "specs/STORY-SPEC.md" "plain translation" "白话"
  require_text_any "$project" "$project_dir" "specs/STORY-SPEC.md" "teaching objectives" "教学目标"
  require_text_any "$project" "$project_dir" "specs/STORY-SPEC.md" "non-rewritable facts" "不可改写事实"
  require_text_any "$project" "$project_dir" "outlines/OUTLINE.md" "scene mapping" "Scene"
  require_text_any "$project" "$project_dir" "outlines/OUTLINE.md" "original text mapping" "原文"
  require_text_any "$project" "$project_dir" "outlines/OUTLINE.md" "subtitle notes" "字幕"
  require_text_any "$project" "$project_dir" "outlines/OUTLINE.md" "video risk" "视频生成风险" "视频风险"
  require_text_any "$project" "$project_dir" "scripts/SCRIPT-STATUS.md" "phase label" "Phase 4"
  require_text_any "$project" "$project_dir" "scripts/SCRIPT-STATUS.md" "smoke draft status" "烟测草案"
  require_text_any "$project" "$project_dir" "scripts/SCRIPT-STATUS.md" "not final production" "不是最终生产稿" "不代表正式生产稿"
  if [ -f "$project_dir/scripts/SMOKE-DRAFT.md" ]; then
    require_text_any "$project" "$project_dir" "scripts/SMOKE-DRAFT.md" "smoke draft label" "烟测草案"
    require_text_any "$project" "$project_dir" "scripts/SMOKE-DRAFT.md" "not final production" "不是最终生产稿"
  fi
}

if [ ! -d "$PROJECTS_DIR" ]; then
  error "Missing projects/ directory."
  exit 1
fi

FOUND=0
for project_dir in "$PROJECTS_DIR"/*/; do
  [ -d "$project_dir" ] || continue
  project="$(basename "$project_dir")"
  case "$project" in
    _template|_template-edu-shortdrama|test-*|*-smoke-test)
      continue
      ;;
  esac
  state="$project_dir/PROJECT-STATE.json"
  if [ -f "$state" ] && [ "$(json_query "$state" projectType 2>/dev/null || true)" = "edu-shortdrama" ]; then
    FOUND=$((FOUND + 1))
    validate_project "$project" "$project_dir"
  fi
done

if [ "$FOUND" -eq 0 ]; then
  warn "No edu-shortdrama project instances found under projects/."
fi

echo "[validate-edu-shortdrama-project] Completed with $ERRORS error(s), $WARNINGS warning(s)."

if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi

exit 0
