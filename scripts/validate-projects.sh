#!/usr/bin/env bash
# Validate project directories under projects/ without treating examples as templates.

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS_DIR="$ROOT_DIR/projects"
ERRORS=0
WARNINGS=0

warn() {
  echo "[validate-projects] [warn] $*"
  WARNINGS=$((WARNINGS + 1))
}

error() {
  echo "[validate-projects] [error] $*" >&2
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

check_project_file() {
  local project="$1"
  local path="$2"
  if [ ! -f "$PROJECTS_DIR/$project/$path" ]; then
    error "$project: missing $path"
  fi
}

check_project_dir() {
  local project="$1"
  local path="$2"
  if [ ! -d "$PROJECTS_DIR/$project/$path" ]; then
    error "$project: missing $path/"
  fi
}

file_contains() {
  local file="$1"
  local pattern="$2"
  [ -f "$file" ] && grep -q "$pattern" "$file" 2>/dev/null
}

json_value() {
  local file="$1"
  local key="$2"
  grep -m 1 "^[[:space:]]*\"$key\"[[:space:]]*:" "$file" 2>/dev/null |
    sed -E 's/^[[:space:]]*"[^"]+"[[:space:]]*:[[:space:]]*"?([^",}]*)"?[,}]?.*$/\1/'
}

current_project_phase() {
  local file="$1"
  if [ ! -f "$file" ]; then
    return 0
  fi
  grep -m 1 "当前阶段：" "$file" 2>/dev/null | sed 's/.*当前阶段：//'
}

count_non_readme_files() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    echo 0
    return
  fi
  find "$dir" -maxdepth 1 -type f ! -iname "README.md" 2>/dev/null | wc -l
}

hash_file() {
  local file="$1"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$file" | awk '{print $1}'
  else
    shasum -a 256 "$file" | awk '{print $1}'
  fi
}

validate_lock_manifest() {
  local project="$1"
  local project_dir="$PROJECTS_DIR/$project"
  local manifest="$project_dir/locked/LOCK-MANIFEST.sha256"

  if [ ! -f "$manifest" ]; then
    warn "$project: locked/FINAL-SCRIPT.md exists but locked/LOCK-MANIFEST.sha256 is missing. Run scripts/update-lock-manifest."
    return
  fi

  while IFS= read -r line; do
    line="${line#$'\xef\xbb\xbf'}"
    case "$line" in
      ""|\#*) continue ;;
    esac

    expected_hash="$(echo "$line" | awk '{print $1}')"
    rel_path="$(echo "$line" | sed 's/^[^ ]*  //')"
    file_path="$project_dir/$rel_path"

    if [ ! -f "$file_path" ]; then
      error "$project: lock manifest references missing file: $rel_path"
      continue
    fi

    actual_hash="$(hash_file "$file_path")"
    if [ "$actual_hash" != "$expected_hash" ]; then
      error "$project: locked file changed after manifest: $rel_path"
    fi
  done < "$manifest"
}

validate_skill_lock_manifest() {
  local project="$1"
  local project_dir="$PROJECTS_DIR/$project"
  local manifest="$project_dir/locked/SKILL-LOCK-MANIFEST.sha256"

  if [ ! -f "$manifest" ]; then
    warn "$project: locked/SKILL-LOCK-MANIFEST.sha256 is missing. Run scripts/update-skill-lock-manifest."
    return
  fi

  while IFS= read -r line; do
    line="${line#$'\xef\xbb\xbf'}"
    case "$line" in
      ""|\#*) continue ;;
    esac

    expected_hash="$(echo "$line" | awk '{print $1}')"
    rel_path="$(echo "$line" | sed 's/^[^ ]*  //')"
    file_path="$ROOT_DIR/$rel_path"

    if [ ! -f "$file_path" ]; then
      error "$project: skill lock manifest references missing file: $rel_path"
      continue
    fi

    actual_hash="$(hash_file "$file_path")"
    if [ "$actual_hash" != "$expected_hash" ]; then
      warn "$project: locked genre Skill file changed after skill manifest: $rel_path"
    fi
  done < "$manifest"
}

if [ ! -d "$PROJECTS_DIR" ]; then
  error "Missing projects/ directory."
  exit 1
fi

FOUND=0

for project_dir in "$PROJECTS_DIR"/*/; do
  [ -d "$project_dir" ] || continue
  project="$(basename "$project_dir")"

  if is_template_project "$project"; then
    echo "[validate-projects] [info] $project: template directory skipped from active project validation."
    continue
  fi

  case "$project" in
    test-*|*-smoke-test)
      echo "[validate-projects] [info] $project: sample/test project present; do not use it as a production template."
      continue
      ;;
  esac

  FOUND=$((FOUND + 1))

  state_file="$PROJECTS_DIR/$project/PROJECT-STATE.json"
  if [ -f "$state_file" ] && [ "$(json_value "$state_file" projectType)" = "edu-shortdrama" ]; then
    echo "[validate-projects] [info] $project: edu-shortdrama project skipped from legacy active project validation; handled by validate-edu-shortdrama-project."
    continue
  fi

  check_project_file "$project" "PROJECT.md"
  check_project_file "$project" "PROJECT-STATE.json"
  check_project_file "$project" "RUN-LOG.md"
  check_project_file "$project" "GENRE-SKILL-LOCK.md"
  check_project_file "$project" "PROJECT-MEMORY.md"
  check_project_dir "$project" "specs"
  check_project_dir "$project" "outlines"
  check_project_dir "$project" "planning"
  check_project_dir "$project" "materials"
  check_project_dir "$project" "scripts"
  check_project_dir "$project" "drafts"
  check_project_dir "$project" "reviews"
  check_project_dir "$project" "revisions"
  check_project_dir "$project" "locked"
  check_project_dir "$project" "revisions/snapshots"
  check_project_dir "$project" "drafts/rewrite-candidates"

  for planning_file in ENDING-LOCK.md REVERSE-OUTLINE.md FORESHADOW-LEDGER.md REVEAL-SCHEDULE.md; do
    check_project_file "$project" "planning/$planning_file"
  done

  lock_file="$PROJECTS_DIR/$project/GENRE-SKILL-LOCK.md"
  if [ -f "$state_file" ]; then
    if ! grep -q '"phase"[[:space:]]*:' "$state_file" 2>/dev/null; then
      error "$project: PROJECT-STATE.json missing phase."
    fi
    if ! grep -q '"status"[[:space:]]*:' "$state_file" 2>/dev/null; then
      error "$project: PROJECT-STATE.json missing status."
    fi
    if ! grep -q '"locked"[[:space:]]*:' "$state_file" 2>/dev/null; then
      error "$project: PROJECT-STATE.json missing locked."
    fi
  fi

  run_log="$PROJECTS_DIR/$project/RUN-LOG.md"
  if [ -f "$run_log" ]; then
    if ! grep -q "运行记录" "$run_log" 2>/dev/null; then
      warn "$project: RUN-LOG.md does not contain a run record section."
    fi
  fi

  if [ -f "$lock_file" ]; then
    if file_contains "$lock_file" "状态：已锁定"; then
      if ! grep -q "Skill 版本：.*[0-9]" "$lock_file" 2>/dev/null; then
        warn "$project: GENRE-SKILL-LOCK.md is locked but does not record Skill 版本."
      fi
      if ! grep -q "能力声明：" "$lock_file" 2>/dev/null; then
        warn "$project: GENRE-SKILL-LOCK.md is locked but does not record capability source."
      fi
      if ! grep -q "缺失能力：" "$lock_file" 2>/dev/null; then
        warn "$project: GENRE-SKILL-LOCK.md is locked but does not record missing capabilities."
      fi
      validate_skill_lock_manifest "$project"
    fi
  fi

  if [ -f "$PROJECTS_DIR/$project/locked/FINAL-SCRIPT.md" ]; then
    if [ ! -f "$PROJECTS_DIR/$project/reviews/final-review.md" ]; then
      error "$project: locked/FINAL-SCRIPT.md exists but reviews/final-review.md is missing."
    fi
    if ! file_contains "$PROJECTS_DIR/$project/scripts/SCRIPT-STATUS.md" "已锁稿"; then
      warn "$project: locked/FINAL-SCRIPT.md exists but scripts/SCRIPT-STATUS.md does not say 已锁稿."
    fi
    if ! file_contains "$PROJECTS_DIR/$project/PROJECT.md" "Phase 7"; then
      warn "$project: locked/FINAL-SCRIPT.md exists but PROJECT.md does not say Phase 7."
    fi
    validate_lock_manifest "$project"
    if [ -f "$state_file" ] && ! grep -q '"locked"[[:space:]]*:[[:space:]]*true' "$state_file" 2>/dev/null; then
      warn "$project: locked/FINAL-SCRIPT.md exists but PROJECT-STATE.json locked is not true."
    fi
  fi

  project_phase="$(current_project_phase "$PROJECTS_DIR/$project/PROJECT.md")"
  script_count=$(find "$PROJECTS_DIR/$project/scripts" -maxdepth 1 -name "*.md" -not -name "SCRIPT-STATUS.md" -type f 2>/dev/null | wc -l)
  if [ "$script_count" -gt 0 ]; then
    if echo "$project_phase" | grep -q "Phase 0" 2>/dev/null; then
      warn "$project: PROJECT.md says Phase 0 but scripts/ contains $script_count chapter file(s)."
    fi
    if [ ! -f "$PROJECTS_DIR/$project/reviews/final-review.md" ]; then
      warn "$project: scripts/ contains chapter files but reviews/final-review.md is missing."
    fi
    if ! file_contains "$PROJECTS_DIR/$project/planning/REVERSE-OUTLINE.md" "状态：.*已确认"; then
      warn "$project: scripts/ contains chapter files but planning/REVERSE-OUTLINE.md is not marked confirmed."
    fi
    if [ ! -f "$PROJECTS_DIR/$project/PROJECT-MEMORY.md" ]; then
      error "$project: scripts/ contains chapter files but PROJECT-MEMORY.md is missing."
    fi
  fi

  if [ -f "$PROJECTS_DIR/$project/reviews/final-review.md" ]; then
    if echo "$project_phase" | grep -q "Phase 0" 2>/dev/null; then
      warn "$project: PROJECT.md says Phase 0 but reviews/final-review.md exists."
    fi
    if ! grep -q "评分" "$PROJECTS_DIR/$project/reviews/final-review.md" 2>/dev/null; then
      warn "$project: reviews/final-review.md does not contain a scoring section."
    fi
    if ! grep -q "修订/重写建议" "$PROJECTS_DIR/$project/reviews/final-review.md" 2>/dev/null; then
      warn "$project: reviews/final-review.md does not contain rewrite guidance."
    fi
  fi

  revision_count=$(find "$PROJECTS_DIR/$project/revisions" -maxdepth 1 -name "*.md" -not -name "README.md" -not -name "revision-log.md" -type f 2>/dev/null | wc -l)
  candidate_count=$(count_non_readme_files "$PROJECTS_DIR/$project/drafts/rewrite-candidates")
  snapshot_count=$(count_non_readme_files "$PROJECTS_DIR/$project/revisions/snapshots")
  snapshot_history_marker="$PROJECTS_DIR/$project/revisions/snapshots/README.md"
  if [ -f "$PROJECTS_DIR/$project/revisions/revision-log.md" ]; then
    if grep -q "重写候选" "$PROJECTS_DIR/$project/revisions/revision-log.md" 2>/dev/null && [ "$candidate_count" -eq 0 ]; then
      warn "$project: revision-log.md mentions rewrite candidates but drafts/rewrite-candidates/ has no candidate files."
    fi
    if grep -Eq "修改|替换|修订" "$PROJECTS_DIR/$project/revisions/revision-log.md" 2>/dev/null && [ "$snapshot_count" -eq 0 ] && ! grep -q "historical-no-snapshot: true" "$snapshot_history_marker" 2>/dev/null; then
      warn "$project: revision-log.md records edits but revisions/snapshots/ has no snapshot files."
    fi
  fi

  for post_dir in shotlists short-drama-shotlists seedance-prompts; do
    post_count=$(count_non_readme_files "$PROJECTS_DIR/$project/$post_dir")
    if [ "$post_count" -gt 0 ]; then
      if ! echo "$project_phase" | grep -q "Phase 8" 2>/dev/null; then
        warn "$project: $post_dir/ contains $post_count non-README file(s), but PROJECT.md does not say Phase 8."
      fi
      if [ ! -f "$PROJECTS_DIR/$project/locked/FINAL-SCRIPT.md" ]; then
        error "$project: $post_dir/ contains output but locked/FINAL-SCRIPT.md is missing."
      fi
    fi
  done
done

if [ "$FOUND" -eq 0 ]; then
  warn "No active production projects found under projects/."
fi

echo "[validate-projects] Completed with $ERRORS error(s), $WARNINGS warning(s)."

if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi

exit 0
