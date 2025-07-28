#!/usr/bin/env bash
set -euo pipefail

# Pattern for your backups
BACKUP_GLOB="$HOME/.dotfiles_backup_"*

# Find the latest backup directory
latest_backup=$(ls -d $BACKUP_GLOB 2>/dev/null | sort | tail -n1 || true)

if [[ -z "$latest_backup" ]]; then
  echo "❌ No backup directory found (looking for $BACKUP_GLOB)."
  exit 1
fi

echo "🔄 Restoring from: $latest_backup"

for rc in bashrc zshrc; do
  src="$latest_backup/$rc"
  dest="$HOME/.$rc"

  if [[ -f "$src" ]]; then
    echo "  • Restoring .$rc → $dest"
    mv -f "$src" "$dest"
  else
    echo "  • Skipping .$rc (no backup found in $latest_backup)"
  fi
done

# Optional: remove the backup dir once restored
# echo "🗑 Removing backup folder $latest_backup"
# rm -rf "$latest_backup"

echo "✅ Done! Restart your shell (or run: source ~/.bashrc && source ~/.zshrc)"