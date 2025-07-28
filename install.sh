#!/usr/bin/env bash
set -euo pipefail

# ─── 1) Locate this script (even if symlinked) ──────────────
SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DOTFILES_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

# ─── 2) Backup existing RCs ─────────────────────────────────
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M)"
echo "⏳ Backing up ~/.bashrc & ~/.zshrc → $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
for rc in .bashrc .zshrc; do
  if [ -e "$HOME/$rc" ]; then
    mv "$HOME/$rc" "$BACKUP_DIR/"
  fi
done

# ─── 3) Symlink in your versioned files ────────────────────
echo "🔗 Symlinking dotfiles → ~/.[bash|zsh]rc"
ln -v -sf "$DOTFILES_DIR/bash/bashrc" "$HOME/.bashrc"
ln -v -sf "$DOTFILES_DIR/zsh/zshrc"  "$HOME/.zshrc"

# ─── 4) Ensure Git, Zsh & Curl exist ───────────────────────
echo "🛠 Installing prerequisites (git, zsh, curl)…"
if   command -v apt >/dev/null; then
  sudo apt update && sudo apt install -y git curl zsh
elif command -v brew >/dev/null; then
  brew install git curl zsh
else
  echo "⚠️  Could not detect package manager—please install git, zsh, curl yourself."
fi

# ─── 5) Install fzf from GitHub (so we get its install script) ──
if [ ! -d "$HOME/.fzf" ]; then
  echo "📦 Cloning fzf…"
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
fi
echo "⚙️  Running fzf’s own installer"
# note: --key-bindings, --completion, no shell-rc edits
yes | "$HOME/.fzf/install" --key-bindings --completion --no-update-rc

echo "✅ Done! Restart your shell: exec \$SHELL or source ~/.bashrc / ~/.zshrc"
