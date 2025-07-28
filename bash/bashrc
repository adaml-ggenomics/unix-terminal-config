# 1) Define DOTFILES
DOTFILES="$HOME/.dotfiles"

# 2) Source common utilities (aliases, functions, history, prompt)
if [ -d "$DOTFILES/common" ]; then
  for f in "$DOTFILES/common/"*.sh; do
    # shellcheck disable=SC1090
    source "$f"
  done
fi

# 3) Source Bash-specific plugins
if [ -f "$DOTFILES/bash/plugins.sh" ]; then
  source "$DOTFILES/bash/plugins.sh"
fi

# 4) Bash-only tweaks
export EDITOR=vim
shopt -s histappend 