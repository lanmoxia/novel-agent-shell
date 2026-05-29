#!/usr/bin/env bash
# Validate the edu-shortdrama project template without treating it as an active project.

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_DIR="$ROOT_DIR/projects/_template-edu-shortdrama"
STATE_FILE="$TEMPLATE_DIR/PROJECT-STATE.json"
ERRORS=0
WARNINGS=0

info() {
  echo "[validate-edu-shortdrama-template] [info] $*"
}

warn() {
  echo "[validate-edu-shortdrama-template] [warn] $*"
  WARNINGS=$((WARNINGS + 1))
}

error() {
  echo "[validate-edu-shortdrama-template] [error] $*" >&2
  ERRORS=$((ERRORS + 1))
}

require_dir() {
  local rel_path="$1"
  if [ ! -d "$TEMPLATE_DIR/$rel_path" ]; then
    error "missing directory: $rel_path/"
  fi
}

require_file() {
  local rel_path="$1"
  if [ ! -f "$TEMPLATE_DIR/$rel_path" ]; then
    error "missing file: $rel_path"
  fi
}

require_text_any() {
  local rel_path="$1"
  local label="$2"
  shift 2
  local file="$TEMPLATE_DIR/$rel_path"
  local pattern

  if [ ! -f "$file" ]; then
    error "$rel_path missing; cannot check $label."
    return
  fi

  for pattern in "$@"; do
    if grep -q "$pattern" "$file" 2>/dev/null; then
      return
    fi
  done

  error "$rel_path missing required semantic keyword for $label: $*"
}

json_query() {
  local query="$1"
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
' "$STATE_FILE" "$query"
}

json_type() {
  local query="$1"
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
' "$STATE_FILE" "$query"
}

require_json_field() {
  local field="$1"
  if ! json_type "$field" >/dev/null 2>&1; then
    error "PROJECT-STATE.json missing required field: $field"
  fi
}

require_json_type() {
  local field="$1"
  local expected="$2"
  local actual

  if ! actual="$(json_type "$field" 2>/dev/null)"; then
    error "PROJECT-STATE.json missing required field: $field"
    return
  fi

  if [ "$actual" != "$expected" ]; then
    error "PROJECT-STATE.json field $field must be $expected, got $actual."
  fi
}

require_json_value() {
  local field="$1"
  local expected="$2"
  local actual

  if ! actual="$(json_query "$field" 2>/dev/null)"; then
    error "PROJECT-STATE.json missing required field: $field"
    return
  fi

  if [ "$actual" != "$expected" ]; then
    error "PROJECT-STATE.json field $field must be '$expected', got '$actual'."
  fi
}

if [ ! -d "$TEMPLATE_DIR" ]; then
  error "missing template directory: projects/_template-edu-shortdrama/"
else
  info "checking projects/_template-edu-shortdrama/"
fi

for dir in \
  "materials" \
  "specs" \
  "planning" \
  "outlines" \
  "scripts" \
  "reviews" \
  "revisions" \
  "locked" \
  "short-drama-shotlists" \
  "seedance-prompts" \
  "drafts"; do
  require_dir "$dir"
done

for file in \
  "PROJECT.md" \
  "PROJECT-STATE.json" \
  "GENRE-SKILL-LOCK.md" \
  "PROJECT-MEMORY.md" \
  "RUN-LOG.md" \
  "materials/README.md" \
  "specs/STORY-SPEC.md" \
  "planning/ENDING-LOCK.md" \
  "outlines/OUTLINE.md" \
  "scripts/SCRIPT-STATUS.md" \
  "reviews/README.md" \
  "revisions/README.md" \
  "revisions/revision-log.md" \
  "locked/README.md" \
  "locked/FINAL-SCRIPT.md" \
  "short-drama-shotlists/README.md" \
  "seedance-prompts/README.md" \
  "drafts/README.md"; do
  require_file "$file"
done

if [ -f "$STATE_FILE" ]; then
  if ! python -m json.tool "$STATE_FILE" >/dev/null 2>&1; then
    error "PROJECT-STATE.json is not valid JSON."
  else
    for field in \
      "projectType" \
      "skillId" \
      "phase" \
      "status" \
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
      require_json_field "$field"
    done

    require_json_value "projectType" "edu-shortdrama"
    require_json_value "skillId" "wenyan-skill"
    require_json_type "phase" "int"
    require_json_type "status" "string"
    require_json_type "confirmedArtifacts" "object"
    require_json_type "lockedArtifacts" "array"
    require_json_type "notes" "array"

    status_value="$(json_query "status" 2>/dev/null || true)"
    if [ -z "$status_value" ]; then
      error "PROJECT-STATE.json field status must be non-empty."
    fi

    for artifact in \
      "projectMd" \
      "genreSkillLock" \
      "storySpec" \
      "endingLock" \
      "outline" \
      "originalTextAnalysis" \
      "sceneMapping" \
      "script" \
      "subtitlePlan" \
      "shotlistPlan" \
      "teachingReview" \
      "revisionLog" \
      "finalScript" \
      "productionPackage"; do
      require_json_field "confirmedArtifacts.$artifact"
    done
  fi
fi

require_text_any "specs/STORY-SPEC.md" "original text" "原文"
require_text_any "specs/STORY-SPEC.md" "plain translation" "白话"
require_text_any "specs/STORY-SPEC.md" "teaching objectives" "教学目标"
require_text_any "outlines/OUTLINE.md" "scene mapping" "Scene" "场景"
require_text_any "outlines/OUTLINE.md" "original text mapping" "原文"
require_text_any "scripts/SCRIPT-STATUS.md" "subtitle plan" "字幕"
require_text_any "scripts/SCRIPT-STATUS.md" "shotlist plan" "分镜"
require_text_any "GENRE-SKILL-LOCK.md" "capability declaration" "capabilities" "declaredCapabilities"
require_text_any "locked/FINAL-SCRIPT.md" "final script or production package boundary" "最终剧本" "生产稿包"

info "active-project lock state, final-review, RUN-LOG runtime records, Phase 7, and lock manifest checks are intentionally out of scope for this template validator."
echo "[validate-edu-shortdrama-template] Completed with $ERRORS error(s), $WARNINGS warning(s)."

if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi

exit 0
