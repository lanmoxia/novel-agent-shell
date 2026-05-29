#!/usr/bin/env bash
# Create a new project from projects/_template without touching sample projects.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_DIR="$ROOT_DIR/projects/_template"
PROJECTS_DIR="$ROOT_DIR/projects"

usage() {
  echo "Usage: bash scripts/new-project.sh <project-name>"
  echo "Example: bash scripts/new-project.sh huanghe-minsu-horror-002"
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

PROJECT_NAME="${1:-}"
if [ -z "$PROJECT_NAME" ]; then
  usage >&2
  exit 1
fi

case "$PROJECT_NAME" in
  _template|test-*|*/*|*\\*|.*)
    echo "[new-project] Invalid project name: $PROJECT_NAME" >&2
    echo "[new-project] Use a plain project directory name, not a sample/template/reserved path." >&2
    exit 1
    ;;
esac

if ! echo "$PROJECT_NAME" | grep -Eq '^[a-z0-9][a-z0-9._-]*$'; then
  echo "[new-project] Invalid project name: $PROJECT_NAME" >&2
  echo "[new-project] Use lowercase letters, numbers, dots, underscores, and hyphens." >&2
  exit 1
fi

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "[new-project] Missing template directory: projects/_template" >&2
  exit 1
fi

TARGET_DIR="$PROJECTS_DIR/$PROJECT_NAME"
if [ -e "$TARGET_DIR" ]; then
  echo "[new-project] Target already exists: projects/$PROJECT_NAME" >&2
  exit 1
fi

mkdir -p "$PROJECTS_DIR"
cp -R "$TEMPLATE_DIR" "$TARGET_DIR"

echo "[new-project] Created projects/$PROJECT_NAME from projects/_template."
echo "[new-project] Next: edit PROJECT.md, then run bash scripts/validate-shell.sh."
