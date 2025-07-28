#!/usr/bin/env bash
set -euo pipefail

# 1) Figure out where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES="$SCRIPT_DIR"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M)"

echo "⏳ Backing up existing dotfiles → $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
for rc in .bashrc .zshrc; do
  if [ -e "$HOME/$rc" ]; then
    mv "$HOME/$rc" "$BACKUP_DIR/"
  fi
done

echo "🔗 Symlinking shell configs"
ln -sf "$DOTFILES/bash/bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES/zsh/zshrc"  "$HOME/.zshrc"

echo "🛠 Installing prerequisites"
if   command -v apt >/dev/null; then
  sudo apt update
  sudo apt install -y git curl zsh fzf
elif command -v brew >/dev/null; then
  brew install git curl zsh fzf
else
  echo "⚠️  Please install git, zsh, and fzf manually."
fi

echo "⚙️  Running fzf installer"
# Non-interactive, key-bindings + completion only
yes | "$(command -v fzf)" --install --key-bindings --completion --no-update-rc

echo "✅ Done! Reload with: exec \$SHELL or source ~/.zshrc (or ~/.bashrc)"
