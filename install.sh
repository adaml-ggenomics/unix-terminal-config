#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M)"

echo "⏳ Backing up existing dotfiles → $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
for f in .bashrc .zshrc; do
  [ -e "$HOME/$f" ] && mv "$HOME/$f" "$BACKUP_DIR/"
done

echo "📥 Cloning or updating dotfiles repo"
if [ ! -d "$DOTFILES" ]; then
  git clone git@github.com:<you>/dotfiles.git "$DOTFILES"
else
  cd "$DOTFILES" && git pull
fi

echo "🔗 Symlinking shell configs"
ln -sf "$DOTFILES/bash/bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES/zsh/zshrc"  "$HOME/.zshrc"

echo "🛠 Installing prerequisites"
if command -v apt >/dev/null; then
  sudo apt update
  sudo apt install -y git curl zsh fzf
elif command -v brew >/dev/null; then
  brew install git curl zsh fzf
else
  echo "⚠️  Could not detect package manager—please install git, zsh, and fzf yourself."
fi

echo "⚙️  Running fzf installer"
# Non-interactive, key-bindings + completion only
yes | "$(command -v fzf)" --install --key-bindings --completion --no-update-rc

echo "✅ Done! Reload with: exec \$SHELL or source ~/.zshrc (or ~/.bashrc)"