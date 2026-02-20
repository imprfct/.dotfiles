# dotfiles (macOS)

Minimal setup for `zsh`, `oh-my-zsh`, `vim` fallback, `nvim`, and `ghostty`.

## 1) Quick Start on a New Mac

```bash
xcode-select --install # once
git clone https://github.com/<USER>/<REPO>.git ~/.dotfiles
cd ~/.dotfiles
git checkout macOS
make install
exec zsh
```

## 2) Update and Re-sync

```bash
cd ~/.dotfiles
make sync
```

## Managed Links

- `zsh/.zshrc -> ~/.zshrc`
- `zsh/.zprofile -> ~/.zprofile`
- `vim/.vimrc -> ~/.vimrc`
- `config/nvim -> ~/.config/nvim`
- `config/ghostty -> ~/.config/ghostty`

`make link` creates backups before replacing files in `~/.dotfiles-backup/<timestamp>/...`.
