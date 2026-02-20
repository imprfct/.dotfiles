#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_ROOT="$HOME/.dotfiles-backup/$TIMESTAMP"

log() {
  echo "[link] $1"
}

backup_path() {
  local target="$1"
  local rel_path backup_path

  rel_path="${target#$HOME/}"
  backup_path="$BACKUP_ROOT/$rel_path"

  mkdir -p "$(dirname "$backup_path")"
  mv "$target" "$backup_path"
  log "backup: $target -> $backup_path"
}

link_path() {
  local src="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] || [ -e "$target" ]; then
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
      log "ok: $target already linked"
      return
    fi

    mkdir -p "$BACKUP_ROOT"
    backup_path "$target"
  fi

  ln -s "$src" "$target"
  log "link: $target -> $src"
}

link_path "$REPO_ROOT/zsh/.zshrc" "$HOME/.zshrc"
link_path "$REPO_ROOT/zsh/.zprofile" "$HOME/.zprofile"
link_path "$REPO_ROOT/vim/.vimrc" "$HOME/.vimrc"
link_path "$REPO_ROOT/config/nvim" "$HOME/.config/nvim"
link_path "$REPO_ROOT/config/ghostty" "$HOME/.config/ghostty"

if [ -d "$BACKUP_ROOT" ]; then
  log "backup root: $BACKUP_ROOT"
fi

log "done"
