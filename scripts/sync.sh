#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BRANCH="${1:-macOS}"

log() {
  echo "[sync] $1"
}

log "fetch origin/$BRANCH"
git -C "$REPO_ROOT" fetch origin "$BRANCH"

log "checkout $BRANCH"
git -C "$REPO_ROOT" checkout "$BRANCH"

log "pull --ff-only"
git -C "$REPO_ROOT" pull --ff-only origin "$BRANCH"

log "relink dotfiles"
"$REPO_ROOT/scripts/link.sh"

log "done"
