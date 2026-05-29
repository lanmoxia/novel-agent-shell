#!/usr/bin/env bash
# Validate pluggable genre Skill packages under genre-skills/.

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GENRE_DIR="$ROOT_DIR/genre-skills"

ERRORS=0
WARNINGS=0

warn() {
  echo "[validate-genre-skills] [warn] $*"
  WARNINGS=$((WARNINGS + 1))
}

error() {
  echo "[validate-genre-skills] [error] $*" >&2
  ERRORS=$((ERRORS + 1))
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

if [ ! -d "$GENRE_DIR" ]; then
  error "Missing genre-skills/ directory."
  exit 1
fi

FOUND=0

for skill_dir in "$GENRE_DIR"/*/; do
  [ -d "$skill_dir" ] || continue

  skill_name="$(basename "$skill_dir")"
  case "$skill_name" in
    _*) continue ;;
  esac

  FOUND=$((FOUND + 1))
  skill_file="$skill_dir/SKILL.md"

  if [ ! -f "$skill_file" ]; then
    error "$skill_name: missing SKILL.md."
    continue
  fi

  first_line="$(head -n 1 "$skill_file" 2>/dev/null || true)"
  if [ "$first_line" != "---" ]; then
    error "$skill_name: SKILL.md must start with YAML frontmatter."
  else
    check_frontmatter_field "$skill_file" "name" || error "$skill_name: SKILL.md frontmatter missing name."
    check_frontmatter_field "$skill_file" "description" || error "$skill_name: SKILL.md frontmatter missing description."
    check_frontmatter_field "$skill_file" "version" || warn "$skill_name: SKILL.md frontmatter missing optional version."
    if ! grep -Eq "^capabilities:" "$skill_file" 2>/dev/null; then
      warn "$skill_name: SKILL.md frontmatter missing recommended capabilities; loader must infer from files."
    fi
  fi

  if [ -f "$skill_dir/outline-method.md" ] || [ -f "$skill_dir/output-style.md" ]; then
    echo "[validate-genre-skills] $skill_name: legacy-compatible format detected."
  else
    for recommended in genre-profile.md style-guide.md structure-rules.md character-rules.md dialogue-rules.md taboo.md review-rubric.md; do
      [ -f "$skill_dir/$recommended" ] || warn "$skill_name: recommended file missing: $recommended."
    done
  fi

  [ -d "$skill_dir/templates" ] || warn "$skill_name: optional templates/ directory missing."
  [ -d "$skill_dir/examples" ] || warn "$skill_name: optional examples/ directory missing."
done

if [ "$FOUND" -eq 0 ]; then
  warn "No active genre skills found under genre-skills/."
fi

echo "[validate-genre-skills] Completed with $ERRORS error(s), $WARNINGS warning(s)."

if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi

exit 0
