#!/usr/bin/env bash
# Create a blank evolution proposal template.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROPOSALS_DIR="$ROOT_DIR/workflow/feedback/proposals"

usage() {
  echo "Usage: bash scripts/new-proposal.sh <proposal-name>"
  echo "Example: bash scripts/new-proposal.sh 20260518-120000-proposal.md"
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

PROPOSAL_NAME="${1:-}"
if [ -z "$PROPOSAL_NAME" ]; then
  usage >&2
  exit 1
fi

case "$PROPOSAL_NAME" in
  */*|*\\*|.*)
    echo "[new-proposal] Invalid proposal name: $PROPOSAL_NAME" >&2
    exit 1
    ;;
esac

if [ ! -d "$PROPOSALS_DIR" ]; then
  echo "[new-proposal] Missing workflow/feedback/proposals/ directory." >&2
  exit 1
fi

TARGET="$PROPOSALS_DIR/$PROPOSAL_NAME"
if [ -e "$TARGET" ]; then
  echo "[new-proposal] Target already exists: workflow/feedback/proposals/$PROPOSAL_NAME" >&2
  exit 1
fi

cp "$PROPOSALS_DIR/TEMPLATE.md" "$TARGET"
echo "[new-proposal] Created workflow/feedback/proposals/$PROPOSAL_NAME from TEMPLATE.md."
