#!/usr/bin/env bash
set -euo pipefail

log() {
  echo "[bootstrap] $1"
}

ensure_xcode_clt() {
  if xcode-select -p >/dev/null 2>&1; then
    return
  fi

  log "Xcode Command Line Tools not found"
  log "run: xcode-select --install"
  exit 1
}

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  log "Homebrew not found, installing"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

load_brew_env() {
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_packages() {
  local packages
  packages=(git neovim fnm fzf ripgrep fd zsh-autosuggestions)

  log "Installing brew packages: ${packages[*]}"
  brew install "${packages[@]}"
}

install_oh_my_zsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    log "oh-my-zsh already installed"
    return
  fi

  log "Installing oh-my-zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

main() {
  ensure_xcode_clt
  ensure_homebrew
  load_brew_env
  install_packages
  install_oh_my_zsh

  log "done. next: make link"
}

main "$@"
