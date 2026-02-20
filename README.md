# dotfiles (macOS)

Минимальный набор: `zsh`, `oh-my-zsh`, `vim` fallback, `nvim`, `ghostty`.

## 1) Первый пуш ветки `macOS`

```bash
git checkout macOS
git add .
git commit -m "macOS dotfiles bootstrap"
git push -u origin macOS
```

## 2) Быстрый старт на новом Mac

```bash
xcode-select --install # один раз
git clone https://github.com/<USER>/<REPO>.git ~/.dotfiles
cd ~/.dotfiles
git checkout macOS
make bootstrap
make link
exec zsh
```

## 3) Обновить и пересинкать

```bash
cd ~/.dotfiles
make sync
```

## 4) Держать всегда в синке (опционально)

```bash
cd ~/.dotfiles
make autosync-install
```

Это ставит `launchd`-агент и делает `make sync` каждые 30 минут.
Лог: `~/Library/Logs/dotfiles-sync.log`.

Удалить:

```bash
cd ~/.dotfiles
make autosync-remove
```

## Что синкается

- `zsh/.zshrc -> ~/.zshrc`
- `zsh/.zprofile -> ~/.zprofile`
- `vim/.vimrc -> ~/.vimrc`
- `config/nvim -> ~/.config/nvim`
- `config/ghostty -> ~/.config/ghostty`

`make link` перед заменой делает бэкап в `~/.dotfiles-backup/<timestamp>/...`.
