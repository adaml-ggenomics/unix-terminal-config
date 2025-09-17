#!/usr/bin/env sh
if [ -n "${BASH_VERSION-}" ]; then
  # Bash
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  DOTFILES="$(cd "$SCRIPT_DIR/.." && pwd)"
  echo "using bash" 
elif [ -n "${ZSH_VERSION-}" ]; then
  # Zsh
  DOTFILES=${${(%):-%N}:A:h:h}
    echo "using zsh"
else
  echo "❌ Unsupported shell: $SHELL" >&2
  exit 1
fi
export DOTFILES
echo "Using DOTFILES directory: $DOTFILES"