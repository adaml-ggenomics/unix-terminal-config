#!/usr/bin/env bash
set -euo pipefail

# ─── 1) Locate this script (even if symlinked) ──────────────
SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done

# DOTFILES_DIR="$(pwd)"
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
echo "🔗 Symlinking dotfiles..."

# Always create .bashrc symlink since bash is standard
if ! ln -v -sf "$DOTFILES_DIR/bash/bashrc" "$HOME/.bashrc"; then
    echo "⚠️  Failed to create .bashrc symlink"
    exit 1
else
    echo "✅ Created .bashrc symlink"
fi

# Only create .zshrc symlink if zsh is available
if command -v zsh >/dev/null 2>&1; then
    if ! ln -v -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"; then
        echo "⚠️  Failed to create .zshrc symlink"
        exit 1
    else
        echo "✅ Created .zshrc symlink"
    fi
else
    echo "ℹ️  Zsh not found - skipping .zshrc symlink"
fi

# ─── 4) Check prerequisites and install if possible ───────────────────────
echo "🛠 Checking prerequisites..."

# Check if we can use sudo
CAN_SUDO=false
if sudo -n true 2>/dev/null; then
    CAN_SUDO=true
fi

# Try to install missing packages if we have sudo
if [ "$CAN_SUDO" = true ]; then
    echo "📦 Installing missing packages..."
    if command -v apt >/dev/null; then
        sudo apt update && sudo apt install -y git curl zsh
    elif command -v yum >/dev/null; then
        sudo yum install -y git curl zsh
    elif command -v brew >/dev/null; then
        brew install git curl zsh
    else
        echo "⚠️  Could not detect package manager"
    fi
else
    echo "⚠️  No sudo privileges - cannot install packages automatically"
    echo "ℹ️  Please ask your system administrator to install: git, curl, zsh"
fi

# Check what's available
check_versions() {
    echo ""
    echo "📋 Available tools:"
    
    if command -v git >/dev/null 2>&1; then
        echo "✅ Git: $(git --version)"
    else
        echo "❌ Git: not found"
    fi
    
    if command -v curl >/dev/null 2>&1; then
        echo "✅ Curl: $(curl --version | head -n 1)"
    else
        echo "❌ Curl: not found"
    fi
    
    if command -v zsh >/dev/null 2>&1; then
        echo "✅ Zsh: $(zsh --version)"
    else
        echo "❌ Zsh: not found (bash-only setup)"
    fi
}
check_versions

echo ""
echo "✅ Setup complete!"
echo ""
echo "🔄 To start using your new configuration:"
if command -v zsh >/dev/null 2>&1; then
    echo "   • Restart bash: exec bash  or  source ~/.bashrc"
    echo "   • Restart zsh:  exec zsh   or  source ~/.zshrc"
else
    echo "   • Restart bash: exec bash  or  source ~/.bashrc"
    echo "   • To use zsh later: ask admin to install zsh, then run this script again"
fi
